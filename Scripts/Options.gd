extends Control

func _ready():
	$FSOn.grab_focus()
	$Controls.grab_focus()
	$BTMM.grab_focus()
	$VSOn.grab_focus()
	$VSOff.grab_focus()
	$FSOff.grab_focus()

func _on_FSOn_pressed():
	OS.window_fullscreen = true

func _on_FSOff_pressed():
	OS.window_fullscreen = false

func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")

func _on_BTMM_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_VSOn_pressed():
	OS.vsync_enabled = true

func _on_VSOff_pressed():
	OS.vsync_enabled = false
