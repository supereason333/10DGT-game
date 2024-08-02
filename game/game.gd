extends Control

var generator := preload("res://game/generators/generator.tscn")

@onready var money_label := $LeftAligned/TopBar/VBoxContainer/MoneyLabel
@onready var product_label := $LeftAligned/TopBar/VBoxContainer/ProductLabel
@onready var generator_container := $LeftAligned/LeftPanel/GeneratorContainer/GeneratorContainer
@onready var sell_button := $LeftAligned/LeftPanel/SellContainer/SellButton

func _ready():
	#for passive_generator in ResourceLoader.load("res://resources/generator_defualts.tres").resource:
	#for passive_generator in SaverLoader.load_data().generators.resource:
	for i in len(GlobalValues.data.generators.resource):
		var gen := generator.instantiate()
		gen.gen = GlobalValues.data.generators.resource[i]
		gen.id = i
		generator_container.add_child(gen)

func update_display():
	money_label.text = "Money: " + Formatter.format(GlobalValues.data.money)
	product_label.text = "Products: " + Formatter.format(GlobalValues.data.products)
	if sell_btn_hover:
		sell_button.text = "$" + Formatter.format(GlobalValues.data.product_cost * GlobalValues.data.products)

func _process(delta):
	update_display()

func _on_sell_button_pressed():
	GlobalValues.data.money += GlobalValues.data.product_cost * GlobalValues.data.products
	GlobalValues.data.products = 0

func on_data_save():
	pass


func _on_button_pressed():
	GlobalValues.data.products += 100000

var sell_btn_hover := false
func _on_sell_button_mouse_entered():
	sell_btn_hover = true

func _on_sell_button_mouse_exited():
	sell_btn_hover = false
	sell_button.text = "Sell products"

func _on_button_2_pressed():
	SaverLoader.save_data()
