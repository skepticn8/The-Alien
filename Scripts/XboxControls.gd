extends Control

func _ready():
	$BTC.grab_focus()

func _on_BTC_pressed():
	get_tree().change_scene("res://Scenes/Controls.tscn")
