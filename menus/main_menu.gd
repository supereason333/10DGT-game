extends Control

var saves_btn := preload("res://menus/saves_button.tscn")
@onready var saves_container := $ScrollContainer/SavesContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 4:
		var saves := saves_btn.instantiate()
		saves.id = i
		saves_container.add_child(saves)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
