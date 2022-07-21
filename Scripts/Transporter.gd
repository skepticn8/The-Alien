extends Area2D

export(String, FILE, "*.tscn") var chngto

func _on_Transporter_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene(chngto)
