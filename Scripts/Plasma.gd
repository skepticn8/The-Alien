extends Area2D

const SPEED = 300

var velocity = Vector2()
var direction = 1

func _ready():
	$AnimatedSprite.play("Main")

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	elif direction == -1:
		$AnimatedSprite.flip_h = true
	
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Plasma_body_entered(body):
	if "Enemy" in body.name:
		body.death()
	
	queue_free()

func set_plasma_direction(dir):
	direction = dir
	
	if dir == 1:
		$AnimatedSprite.flip_h = false
	elif dir == -1:
		$AnimatedSprite.flip_h = true
