extends Control

var save_data:SavedData

var id:int
@onready var name_label := $VBoxContainer/NameLabel
@onready var money_label := $VBoxContainer/MoneyLabel
@onready var product_label := $VBoxContainer/ProductLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	save_data = SaverLoader.load_custom_data(id)
	
	money_label.text = "Money: " + Formatter.format(save_data.money)
	product_label.text = "Products: " + Formatter.format(save_data.products)
	name_label.text = "Save " + str(id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_load_button_pressed():
	SaverLoader.loaded_save = id
	SaverLoader.load_data()
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_delete_button_pressed():
	pass
