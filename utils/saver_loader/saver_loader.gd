extends Node

var save_path := "res://saves/"

func save_settings():
	if !FileAccess.file_exists(save_path + "settings.tres"):
		ResourceSaver.save(GameSettings.new(), save_path + "settings.tres")

func load_settings() -> GameSettings:
	if !FileAccess.file_exists(save_path + "settings.tres"):
		save_settings()
	
	return ResourceLoader.load(save_path + "settings.tres")
