extends CharacterBody2D

# Ao começar aplicação
@onready var animator = $AnimatedSprite2D
@onready var hitboxEnemy = $HitboxEnemy/CollisionShape2D
@onready var hitView = $HitView/CollisionShape2D
@onready var viewArea = $ViewArea/CollisionShape2D

# Variáveis Ajustáveis
@export var speed = 20
@export var range = 1
@export var damage = 1

# Variáveis Fixas
var real_speed = 0
var dirX = 1
var life = 5
var move = true
var is_attacking = false
var gravity = 980

# Funções

func _ready():
	real_speed = speed
	$Timer.wait_time = range

func _physics_process(delta):
	Move(delta)

func Move(delta):
	if move:
		animator.play("walk")
		velocity.x = dirX * real_speed
		move_and_slide()
	elif not move:
		velocity.x = dirX * real_speed * 2
		move_and_slide()
	if not is_on_floor():
		velocity.y += gravity * delta

func ChangeSide():
	if dirX == 1:
		dirX = -1
		animator.flip_h = true
		hitboxEnemy.position.x = -62
		hitView.position.x = -62
	else:
		dirX = 1
		animator.flip_h = false
		hitboxEnemy.position.x = 62
		hitView.position.x = 62

func _on_timer_timeout():
	if life > 0 and move:
		ChangeSide()

func Run(area):
	animator.play("run")
	move = false
	Follow(area)

func Follow(area):
	if area.global_position.x < self.global_position.x:
		dirX = -1
		animator.flip_h = true
		hitboxEnemy.position.x = -49
		hitView.position.x = -49
	else:
		dirX = 1
		animator.flip_h = false
		hitboxEnemy.position.x = 49
		hitView.position.x = 49

func TakeDamage():
	if life > 0:
		hitboxEnemy.disabled = true
		animator.play("hurt")
		real_speed = 0
		life -= 1
		await get_tree().create_timer(1).timeout
		animator.play("attack")
		real_speed = speed

func Defeat():
	animator.play("dead")
	await get_tree().create_timer(0.5).timeout
	Global.score += 1
	queue_free()

func Attack():
	if not is_attacking and life > 1:
		hitboxEnemy.disabled = false
		animator.play("attack")
		Global.life -= 1
		await get_tree().create_timer(0.7).timeout
		is_attacking = false
		hitboxEnemy.disabled = true
		await get_tree().create_timer(0.7).timeout
		hitboxEnemy.disabled = false


func _on_hurtbox_enemy_area_entered(area):
	if area.collision_mask == 4:
		if life == 0:
			Defeat()
		else:
			TakeDamage()

func _on_view_area_area_entered(area):
	if area.collision_layer == 2:
		Run(area)

func _on_view_area_area_exited(area):
	if area.collision_layer == 2:
		await get_tree().create_timer(0.5).timeout
		move = true
		is_attacking = false

func _on_hit_view_area_entered(area):
	if area.collision_layer == 2 and not is_attacking:
		Attack()

func _on_hit_view_area_exited(area):
	if area.collision_layer == 2:
		is_attacking = false 
		
