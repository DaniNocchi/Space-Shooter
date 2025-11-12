extends Node

#-----------------------------------------#
#INSTRUCTIONS ON HOW TO MAKE A NEW POWERUP#
#-----------------------------------------#
#1- Get the powerup idea                  #
#2- Create the powerup sprite             #
#3- Add the sprite in the spriteList array#
#4- Add the powerup chances on the        #
#powerupList array                        #
#5- Add the powerup action in the action()#
#function below, and if it uses custom    #
#variables, create them in the Variable   #
#Area below the functions.                #
#-----------------------------------------#
#CAUTION if the powerup needs a timer     #
#read the timer instructions below        #
#-----------------------------------------#


#     --break between instructions--      #


#-----------------------------------------#
# INSTRUCTIONS IF THE POWERUP NEEDS TIMER #
#-----------------------------------------#
#1- Add "obj.spawnTimer()" in the action()#
#2- Add the time the timer will have in   #
#the pullTimerTime() function             #
#3- Add what happens if the timer runs out#
#in the timerTimeout() function           #
#-----------------------------------------#


var usingPowerup = [] #Dont change this, this will be changed automatically by the codes
var spriteList = [ #powerup sprite list
	"res://Sprites/power1.png",
	"res://Sprites/power2.png",
	"res://Sprites/power3.png",
	"res://Sprites/power4.png",
	"res://Sprites/power5.png"
]
#var powerupList := [1, 2, 2, 2, 3, 3, 4, 5, 5] #powerup chances
var powerupList := [5]
func action(pwr, obj): 
	match pwr:
		1:
			doublePoints = true
			obj.spawnTimer()
		2:
			fastShots = true
			obj.spawnTimer()
		3:
			shieldOn = true
			obj.spawnTimer()
		4:
			plusLife = true
		5:
			aimbot = true
			obj.spawnTimer()
	#the powerup action
func pullTimerTime(pwr): 
	match pwr: #The time the powerup timer will have (in seconds)
		1: return 10.00
		2: return 10.00
		3: return 15.00
		5: return 10.00
func timerTimeout(pwr): 
	match pwr:
		1: doublePoints = false
		2: fastShots = false
		3: shieldOn = false
		5: aimbot = false
	#What happens if the timer runs out
	#basically just invert the action() effect

func newGame():
	#Called by the game.tscn start code. 
	#What happens when the game start again
	#So basically, reset everything
	doublePoints = false
	fastShots = false
	usingPowerup.clear()
	oldWave = 1
	controller.Wave = 1
	controller.MaxMeteor = 15
	controller.meteorAlive = 0
	controller.Points = 0
	controller.bulletsMissed = 0
	controller.bulletsShot = 0
	controller.powerupsGotten = 0
	controller.meteorKilled = 0
	shieldOn = false
	plusLife = false
	aimbot = false

#Creating variables area
#(add it in the newGame() too)
var doublePoints = false
var fastShots = false
var oldWave = 1
var shieldOn = false
var plusLife = false
var aimbot = false


#Powerup List:
#1- Double Points
#2- Fast Shooting 
#3- Shield
#4- +1 Life
#5- Aimbot
#6- Freeze
#7- Player Invencibility
#8- Triple Bullets
#9- Damage Pulse
