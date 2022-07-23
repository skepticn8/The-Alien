extends Control

func _ready():
	$ETMM.grab_focus()

func _on_ETMM_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
