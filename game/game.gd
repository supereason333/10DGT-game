extends Control

@onready var money_label := $TopBar/VBoxContainer/MoneyLabel
@onready var product_label := $TopBar/VBoxContainer/ProductLabel

func update_display():
	money_label.text = "Money: " + str(GlobalValues.money)
	product_label.text = "Products: " + str(GlobalValues.products)

func _process(delta):
	update_display()
