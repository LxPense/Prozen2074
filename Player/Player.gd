extends KinematicBody2D

const SPEED = 400

#starting_pos holds the original position for further purposes, for example when the level is reset
var starting_pos

var score = 0
var Bullet = preload("res://Bullets/Bullet.tscn")

var manual_shot_ready = true
var automatic_shot_ready = false

var health = 3
var vulnerable = true

#Lives is stored inside the singleton PlayerVariables, so it remains the same even when the Level-scene is reset (which happens if the player loses all its health)
var lives

signal heart_depleted(heart, active)

#NOTE, because this was a problem once: The position of the player is given by only the Player node, trough the position of the red marker in the 2D view!
# This holds the reference to the current area that hits the player (for example a laser)
var current_hitting_area = null
onready var animationPlayer = $Sprite/AnimationPlayer
onready var animationTree = $Sprite/AnimationTree
onready var animationState = $Sprite/AnimationTree.get("parameters/playback")
onready var flashShaderPlayer = $Sprite/FlashShaderPlayer 

func _ready():
	lives = PlayerVariables.get_lives()
	starting_pos = position

func _physics_process(_delta):
	check_input()
	check_outside()
	
	position = position + WallVariables.WALL_CURRENT_MOVEMENT
	PlayerVariables.player_position = position

func check_input():
	var velocity = Vector2.ZERO	
	print($"/root/Game/Level/Camera".offset.x)
	print(position.x)
	
	if Input.is_action_pressed("move_right") and (position.x + 110 < $"/root/Game/Level/Camera".offset.x + 1280):
		velocity.x += 1
	elif Input.is_action_pressed("move_right") and position.x + 110 >= $"/root/Game/Level/Camera".offset.x + 1280:			#Not good: values (128, , 52) are from trial and error, are not exact
		velocity.x = 0															#Too bad!

	if Input.is_action_pressed("move_left") and (position.x >= $"/root/Game/Level/Camera".offset.x):
		velocity.x -= 1
	elif Input.is_action_pressed("move_left") and position.x <= $"/root/Game/Level/Camera".offset.x:
		velocity.x += 0															#There is no change because the player can get crushed by tiles in the left direction, changing it would mean that the player couldn't get crushed

	if Input.is_action_pressed("move_up") and (position.y >= 0):
		velocity.y -= 1
		
	elif Input.is_action_pressed("move_up") and position.y <= 0:
		velocity.y = 0
	
	if Input.is_action_pressed("move_down") and (position.y + 92 <= 720):
		velocity.y += 1
	elif Input.is_action_pressed("move_down") and position.y + 92 >= 720:
		velocity.y = 0
	
	if Input.is_action_just_pressed("shoot"):
		automatic_shot_ready = false
		shoot_manual()
		$"CooldownAuto/HolddownTime".start()
		
	if Input.is_action_pressed("shoot"):
		if(automatic_shot_ready):
			shoot_auto()	

	move_and_slide(velocity.normalized() * SPEED)
	animate(velocity)
		
func animate(velocity):
	animationTree.set("parameters/Move/blend_position", velocity)
	animationTree.set("parameters/Idle/blend_position", velocity)
	
func shoot_manual():
	if manual_shot_ready:
		var bullet = Bullet.instance()
		bullet.transform = $BulletSpawn.global_transform
		$"/root/Game/Level/BulletsList".add_child(bullet)
		manual_shot_ready = false
		
func shoot_auto():
	if automatic_shot_ready and $CooldownAuto.time_left <= 0:
		var bullet = Bullet.instance()
		bullet.transform = $BulletSpawn.global_transform
		$"/root/Game/Level/BulletsList".add_child(bullet)
		automatic_shot_ready = false
		
func check_outside():
	if position.x + 111 <= $"/root/Game/Level/Camera".offset.x:
		get_tree().change_scene("res://UI/Menu.tscn")

func hit():
	if vulnerable:	
		health -= 1
		start_flashing()
		emit_signal("heart_depleted", health, false)
		
	#Handles losing lives with the help of the singleton PlayerVariables
	if health < 0:
		PlayerVariables.set_lives(PlayerVariables.get_lives() -1)
		if(PlayerVariables.get_lives() >= 0):
			get_tree().reload_current_scene()
		else:
			#When the player completely loses, the lives are instantly reset but the player still sees the Menu-screen
			PlayerVariables.set_lives(3)
			get_tree().change_scene("res://UI/Menu.tscn")		
		

func add_score(score_amount):
	score += score_amount

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
	
func _on_BulletHitBox_area_entered(_area):
	if _area != null:
		hit()
		current_hitting_area = _area
	
func _on_EnemyHitBox_area_entered(area):
	if area.name == "EntityHitbox" and current_hitting_area != area or area != null:
		current_hitting_area = area
		hit()
