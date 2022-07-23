extends Control

func _ready():
	$ExitGame.grab_focus()
	$Options.grab_focus()
	$PlayGame.grab_focus()

func _on_PlayGame_pressed():
	get_tree().change_scene("res://Scenes/Level01.tscn")

func _on_Options_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")

func _on_ExitGame_pressed():
	get_tree().quit()
