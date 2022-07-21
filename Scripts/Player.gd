extends KinematicBody2D

const SPEED = 300
const JUMP = -420
const GRAVITY = 10
const UP = Vector2(0, -1)

var velocity = Vector2()

var is_attacking = false
var is_captured = false

onready var fps_label = $UI/FPS

const PLASMA = preload("res://Other/Plasma.tscn")

func _physics_process(_delta):
	if is_captured == false:
		velocity.y += GRAVITY
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false:
				velocity.x = SPEED
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("Run")
				
				if sign($Position2D.position.x) == -1:
					$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false:
				velocity.x = -SPEED
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("Run")
				
				if sign($Position2D.position.x) == 1:
					$Position2D.position.x *= -1
		
		else:
			velocity.x = 0
			
			if is_attacking == false:
				$AnimatedSprite.play("Idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_accept"):
				if is_attacking == false:
					velocity.y += JUMP
					
					$JumpSound.play()
		else:
			if is_attacking == false:
				if velocity.y > 0:
					$AnimatedSprite.play("Jump-Fall")
				else:
					$AnimatedSprite.play("Jump-Fall")
		
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
			is_attacking = true
			
			$AnimatedSprite.play("Attack")
			
			$AttackSound.play()
			
			var plasma = PLASMA.instance()
			
			if sign($Position2D.position.x) == 1:
				plasma.set_plasma_direction(1)
			else:
				plasma.set_plasma_direction(-1)
			
			get_parent().add_child(plasma)
			plasma.position = $Position2D.global_position
		
		velocity = move_and_slide(velocity, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					captured()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("enable_fullscreen"):
		OS.window_fullscreen = true
	if Input.is_action_just_pressed("disable_fullscreen"):
		OS.window_fullscreen = false
	
	var fpstxt = String(Engine.get_frames_per_second())
	
	fps_label.clear()
	
	fps_label.add_text("FPS: " + fpstxt)

func _on_AnimatedSprite_animation_finished():
	is_attacking = false

func captured():
	is_captured = true
	
	velocity = Vector2(0, 0)
	
	$CollisionShape2D.call_deferred("set_disabled", true)
	
	$AnimatedSprite.play("Captured")
	
	$CapturedSound.play()
	
	$CapturedTimer.start()

func _on_CapturedTimer_timeout():
	get_tree().reload_current_scene()
