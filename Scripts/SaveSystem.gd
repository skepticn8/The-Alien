extends Node

var save_path = "user://savefile.tasf"

func save_game():
	var save_file = File.new()
	
	save_file.open(save_path, File.WRITE)
	
	save_file.store_string(get_parent().get_filename())
	
	save_file.close()

func load_game():
	var save_file = File.new()
	
	save_file.open(save_path, File.READ)
	
	var content = save_file.get_as_text()
	
	save_file.close()
	
	get_tree().change_scene(content)

func _process(_delta):
	if Input.is_action_just_pressed("save_game"):
		save_game()
	if Input.is_action_just_pressed("load_game"):
		load_game()
