extends CharacterBody2D

# Variáveis Ajustáveis (Export)

@export var speed = 200.0
@export var jump_velocity = -350
@export var xrl8 = 2.5

# Varáveis fixas 

var direction
var run
var punch
var punchPressed = false
var gravity = 980
var anim = "Idle"


# Quando começar a aplicação

@onready var hitboxPlayer =  $HitBoxPlayer/CollisionShape2D
@onready var animator = $AnimatedSprite2D
@onready var camera = $Camera2D


func _physics_process(delta):
	Move(delta)
	Animations()
	CameraMove()
	pass

func HurtPlayer():
	if Global.life > 1:
		if not punchPressed:
			animator.play("hurt")
			Global.life -= 1
			await get_tree().create_timer(0.5).timeout
	else:
		get_tree().change_scene_to_file("res://Scenes/gameover.tscn")
		Global.GameOver()
	pass

func Animations():
	if velocity.x != 0 and is_on_floor() and run:
		animator.play("run")
	elif punch and is_on_floor() and not run and not punchPressed:
		punchPressed = true
		animator.play("attack")
		hitboxPlayer.disabled = false
		await get_tree().create_timer(0.5).timeout
		hitboxPlayer.disabled = true
		punchPressed = false
	elif velocity.x != 0 and is_on_floor() and not punchPressed:
		animator.play("walk")
	elif velocity.x == 0 and is_on_floor() and not punchPressed:
		animator.play("idle")
		
	if not is_on_floor():
		animator.play("jump")
		
	if direction > 0:
		animator.flip_h = false
		hitboxPlayer.position.x = 59
	elif direction < 0:
		animator.flip_h = true
		hitboxPlayer.position.x = -59
	pass

func _on_hurtbox_player_area_entered(area):
	HurtPlayer()
	pass

func Move(delta):
	direction = Input.get_axis("Left", "Right")
	run = Input.is_action_pressed("Run")
	punch = Input.is_action_just_pressed("Punch")
	
	if direction and run and is_on_floor():
		velocity.x = direction * speed * xrl8
	elif direction :
		velocity.x = direction * speed
	else:
		velocity.x = 0
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		
	move_and_slide()
	pass

func CameraMove():
	if self.position.y >= 685 and self.position.x >= 3319 or self.position.y >= 1000:
		camera.limit_right = 10456
		camera.limit_bottom = 1835
		pass



