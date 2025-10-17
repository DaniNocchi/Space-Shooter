@tool
class_name TextureCircle
extends Node2D

@export var texture_fill: Texture2D:
	set = set_texture_fill

@export var texture_outline: Texture2D:
	set = set_texture_outline

@export_range(1.0, 1024.0) var radius: float = 128.0:
	set = set_radius

@export_range(0.0, 360.0) var length_degrees: float = 360.0:
	set = set_length_degrees

@export var collidable: bool:
	set = set_collidable

var texture_fill_size: Vector2
var texture_outline_size: Vector2
var slice_width_max: float = 32.0
var length: float = TAU


func set_texture_fill(value: Texture2D) -> void:
	texture_fill = value
	
	if texture_fill:
		texture_fill_size = texture_fill.get_size()
	
	if texture_outline == null:
		slice_width_max = texture_fill_size.x if texture_fill else 32.0
	
	queue_redraw()


func set_texture_outline(value: Texture2D) -> void:
	texture_outline = value
	
	if texture_outline:
		texture_outline_size = texture_outline.get_size()
		
		if texture_outline_size.y > radius:
			radius = texture_outline_size.y
			notify_property_list_changed()
		
		slice_width_max = texture_outline_size.x
	else:
		slice_width_max = texture_fill_size.x if texture_fill else 32.0
	
	queue_redraw()


func set_radius(value: float) -> void:
	radius = value
	
	if texture_outline and texture_outline_size.y > radius:
		radius = texture_outline_size.y
	
	queue_redraw()


func set_length_degrees(value: float) -> void:
	length_degrees = value
	length = deg_to_rad(value)
	queue_redraw()


func set_collidable(value: bool) -> void:
	collidable = value
	
	if not is_inside_tree():
		await ready
	
	var has_body = has_node("StaticBody2D")
	if collidable != has_body:
		if collidable:
			var body := StaticBody2D.new()
			var shape := CollisionPolygon2D.new()
			body.add_child(shape, true)
			body.show_behind_parent = true
			add_child(body, true)
		else:
			$StaticBody2D.queue_free()


func _draw() -> void:
	var slice_angle = atan(slice_width_max / (2.0 * radius)) * 2.0
	var slice_count = ceil(TAU / slice_angle)
	
	slice_angle = TAU / slice_count
	slice_count = ceil(length / slice_angle)
	
	var slice_width_left = tan(slice_angle / 2.0) * radius
	var slice_width_right = slice_width_left
	
	var radius_left = sqrt(pow(slice_width_left, 2) + pow(radius, 2))
	var radius_right = sqrt(pow(slice_width_right, 2) + pow(radius, 2))
	var polygon: Array[Vector2] = [Vector2.ZERO]
	
	for i in range(slice_count):
		var angle = slice_angle * i
		
		if i == slice_count - 1:
			slice_width_right = tan((length - angle) / 2.0) * radius * 2.0 - slice_width_left
			radius_right = sqrt(pow(slice_width_right, 2) + pow(radius, 2))
		
		draw_set_transform(Vector2.ZERO, slice_angle / 2.0 + angle, Vector2.ONE)
		
		if texture_fill:
			draw_colored_polygon(
				[
					Vector2(-slice_width_left, -radius),
					Vector2(slice_width_right, -radius),
					Vector2(0, 0)
				],
				Color.WHITE,
				[
					Vector2(0, 0),
					Vector2((slice_width_left + slice_width_right) / texture_fill_size.x, 0),
					Vector2(slice_width_left / texture_fill_size.x, radius / texture_fill_size.y)
				],
				texture_fill
			)
		
		if texture_outline:
			var ratio = (radius - texture_outline_size.y) / radius
			var offset_left = slice_width_left * ratio
			var offset_right = slice_width_right * ratio
			
			draw_colored_polygon(
				[
					Vector2(-slice_width_left, -radius),
					Vector2(slice_width_right, -radius),
					Vector2(offset_right, texture_outline_size.y - radius),
					Vector2(-offset_left, texture_outline_size.y - radius)
				],
				Color.WHITE,
				[
					Vector2(0, 0),
					Vector2((slice_width_left + slice_width_right) / texture_outline_size.x, 0),
					Vector2(0.5 + offset_right / texture_outline_size.x, 1),
					Vector2(0.5 - offset_left / texture_outline_size.x, 1)
				],
				texture_outline
			)
		
		polygon.append(Vector2(sin(angle) * radius_left, -cos(angle) * radius_left))
	
	polygon.append(Vector2(sin(length) * radius_right, -cos(length) * radius_right))
	
	if collidable and has_node("StaticBody2D"):
		var shape: CollisionPolygon2D = $StaticBody2D.get_node("CollisionPolygon2D")
		shape.polygon = polygon
