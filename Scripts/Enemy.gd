extends KinematicBody2D

const SPEED = 200
const GRAVITY = 15
const UP = Vector2(0, -1)

var velocity = Vector2()
var direction = -1

var health = 3
var is_dead = false

func _ready():
	$AnimatedSprite.play("Run")

func _physics_process(_delta):
	if is_dead == false:
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
		
		if direction == -1:
			$AnimatedSprite.flip_h = false
		elif direction == 1:
			$AnimatedSprite.flip_h = true
		
		velocity = move_and_slide(velocity, UP)
		
		if is_on_wall():
			direction = direction * -1
			$RayCast2D.position.x *= -1
		if $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.captured()

func death():
	$AnimatedSprite.play("Hurt")
	
	$HurtSound.play()
	
	health -= 1
	
	$HurtTimer.start()
	
	if health == 0:
		is_dead = true
		
		velocity = Vector2(0, 0)
		
		$CollisionShape2D.call_deferred("set_disabled", true)
		
		$DeathTimer.start()
		
		$AnimatedSprite.play("Death")

func _on_DeathTimer_timeout():
	queue_free()

func _on_HurtTimer_timeout():
	$AnimatedSprite.play("Run")
