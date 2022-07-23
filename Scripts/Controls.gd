extends Control

func _ready():
	$BTOM.grab_focus()
	$Xbox.grab_focus()

func _on_BTOM_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")
