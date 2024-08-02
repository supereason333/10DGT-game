extends Node

var loaded_save := 0
var save_path := "res://saves/"

func save_settings():
	if !FileAccess.file_exists(save_path + "settings.tres"):
		ResourceSaver.save(GameSettings.new(), save_path + "settings.tres")

func load_settings() -> GameSettings:
	if !FileAccess.file_exists(save_path + "settings.tres"):
		save_settings()
	
	return ResourceLoader.load(save_path + "settings.tres")

func save_data(tmp := ""):
	if !FileAccess.file_exists(save_path + "data" + str(loaded_save) + tmp + ".tres"):
		var data := SavedData.new()
		data.generators.resource = ResourceLoader.load("res://resources/generator_defualts.tres").resource
		ResourceSaver.save(data, save_path + "data" + str(loaded_save) + tmp + ".tres")
	else:
		get_tree().call_group("data_save", "on_data_save")
		
		ResourceSaver.save(GlobalValues.data, save_path + "data" + str(loaded_save) + tmp + ".tres")

func load_data():
	if !FileAccess.file_exists(save_path + "data" + str(loaded_save) + ".tres"):
		save_data()
	
	GlobalValues.data = ResourceLoader.load(save_path + "data" + str(loaded_save) + ".tres")
	return GlobalValues.data

func delete_data(id:int):
	if !FileAccess.file_exists(save_path + "data" + str(id) + ".tres"):
		FileAccess.WRITE

func load_custom_data(id:int):
	if !FileAccess.file_exists(save_path + "data" + str(id) + ".tres"):
		var data := SavedData.new()
		data.generators.resource = ResourceLoader.load("res://resources/generator_defualts.tres").resource
		ResourceSaver.save(data, save_path + "data" + str(id) + ".tres")
		return data
	
	return ResourceLoader.load(save_path + "data" + str(id) + ".tres")
