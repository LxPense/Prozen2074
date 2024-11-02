extends KinematicBody2D
class_name Player

const SPEED = 8

var manual_shot_ready = true
var automatic_shot_ready = false

# Score, health and lives are managed and stored inside the autoload PlayerVariables
var score : int
var health : int
var lives : int

var vulnerable = true

#NOTE, because this was a problem once: The position of the player is given by only the Player node, trough the position of the red marker in the 2D view!
# This holds the reference to the current area that hits the player (for example a laser)
var current_hitting_area = null
onready var animationPlayer = $Sprite/AnimationPlayer
onready var animationTree = $Sprite/AnimationTree
onready var flashShaderPlayer = $Sprite/FlashShaderPlayer 

var playerbullet = load("res://Bullets/Bullet.tscn")
var spacebossbullet = load("res://Bullets/Bullet_SpaceBoss.tscn")
var bulletSpawner = load("res://Bullets/BulletSpawner.gd")

func _ready():
	score = PlayerVariables.score
	health = PlayerVariables.player_health
	lives = PlayerVariables.get_lives()
	position = PlayerVariables.player_spawn_position
	bulletSpawner = $BulletSpawner
	bulletSpawner.setTarget($BulletSpawner/Target)
	
	# The bulletStrategy only defines the behaviour and the look of the bullet, the bulletSpawner is responsible for the actual physics
	bulletSpawner.setBulletStrategy(PlayerVariables.current_bulletStrategy)
	

func _physics_process(_delta):
	# This method is only responsible for moving the player by pressing a key
	check_input()
	
	# This code moves the player by the shift-amount of the shifting wall
	#global_position = global_position + CameraSettings.getCameraMove()
	var camera_velocity = CameraSettings.getCameraMove()
	position = position + move_and_slide(camera_velocity.normalized() * CameraSettings.WALL_CURRENT_MOVEMENT)

func check_input():
	var velocity = Vector2.ZERO	
	
	# Code to check in which direction the player is going
	
	if Input.is_action_pressed("move_right") and (position.x + 110 < $"/root/Game/View/Camera".offset.x + 1280):
		velocity.x += 1.0
		
	elif Input.is_action_pressed("move_right") and position.x + 110 >= $"/root/Game/View/Camera".offset.x + 1280:
		velocity.x = 0.0

	if Input.is_action_pressed("move_left") and (position.x >= $"/root/Game/View/Camera".offset.x):
		velocity.x -= 1.0
		
	elif Input.is_action_pressed("move_left") and position.x <= $"/root/Game/View/Camera".offset.x:
		velocity.x += 0.0															#There is no change because the player can get crushed by tiles in the left direction, changing it would mean that the player couldn't get crushed

	if Input.is_action_pressed("move_up") and (position.y >= 0):
		velocity.y -= 1.0
		
	elif Input.is_action_pressed("move_up") and position.y <= 0:
		velocity.y = 0.0
	
	if Input.is_action_pressed("move_down") and (position.y + 92 <= 720):
		velocity.y += 1.0
		
	elif Input.is_action_pressed("move_down") and position.y + 92 >= 720:
		velocity.y = 0.0
	
	# Code to handle the shooting
	
	if Input.is_action_just_pressed("shoot"):
		automatic_shot_ready = false
		shoot_manual()
		$"CooldownAuto/HolddownTime".start()
		
	if Input.is_action_pressed("shoot"):
		if(automatic_shot_ready):
			shoot_auto()
			pass
	
	position = position + move_and_slide(velocity.normalized() * SPEED)
	
	# Is used to map the movement according to the velocity -> is being handled by the AnimationNodeBlendSpace2D
	
	animate(velocity)
		
func animate(velocity):
	animationTree.set("parameters/BlendSpace2D/blend_position", velocity)
	
func shoot_manual():
	if manual_shot_ready:
		#$AudioStreamPlayer.play()
		  $BulletSpawner.execute_Strategy()
		
func shoot_auto():
	if(automatic_shot_ready and $CooldownAuto.time_left <= 0):
		#$AudioStreamPlayer.play()
		$BulletSpawner.execute_Strategy()
		automatic_shot_ready = false

func hit():
	if vulnerable:	
		PlayerVariables.player_health -= 1
		PlayerVariables.emit_signal("heart_depleted", PlayerVariables.player_health, false)
		start_flashing()
		PlayerVariables.screen_exit_expected = true
		check_health_and_decide()

# Checks the health and lives of the player and executes other code according to the result of the checks
# -> When the player has 0 health, the scene is reloaded
# -> When the player has 0 lives, the continue-screen is shown

# Note: Causes issues as of 20.08.2024!!
func check_health_and_decide():
	
	#Handles losing lives with the help of the singleton PlayerVariables
	if PlayerVariables.player_health < 0:
		PlayerVariables.player_lives = PlayerVariables.player_lives - 1
		PlayerVariables.player_health = 3
		PlayerVariables.emit_signal("reload_scene_with_player")
		
	if(PlayerVariables.player_lives < 0):
		#When the player loses all lives, he's presented with a Continue-screen, that manages further events
		SceneController.change_current_scene("scene_continue")
		PlayerVariables.player_lives = 3

func add_score(score_amount):
	score += score_amount

func set_score(score_amount):
	score = score_amount

func set_lives(_lives : int):
	lives = _lives

func _on_CooldownManual_timeout():
	manual_shot_ready = true

func _on_HolddownTime_timeout():
	automatic_shot_ready = true

# When flashing, the player is invincible
func start_flashing():
	flashShaderPlayer.play("Start")
	$"FlashTimer".start()
	vulnerable = false
	
func stop_flashing():
	flashShaderPlayer.play("Stop")
	vulnerable = true

func _on_FlashTimer_timeout():
	stop_flashing()
	
# Checks if a bullet hits the BulletHitbox
func _on_BulletHitBox_area_entered(area):
	if area != null:
		current_hitting_area = area
		hit()
	
# Checks if the player collides with an area named EntityHitbox (Every enemy has one)
func _on_EnemyHitBox_area_entered(area):
#	if area.name == "EntityHitbox" and (current_hitting_area != area or area != null):
#		current_hitting_area = area
#		hit()
	if area.is_in_group("enemy"):
		current_hitting_area = area
		hit()

# Player exits the visible screen, only if the exit was not expected (if screen_exit_expected is false) the act gets reloaded
func _on_VisibilityNotifier2D_screen_exited():
	if(!PlayerVariables.screen_exit_expected):
		PlayerVariables.player_lives = PlayerVariables.player_lives - 1
		PlayerVariables.player.check_health_and_decide()
	
# Player enters the visible screen, after that it is not expected that the player leaves the screen 
func _on_VisibilityNotifier2D_screen_entered():
	position = PlayerVariables.player_spawn_position	
