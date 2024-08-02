extends VBoxContainer

var id:int
var gen := PassiveGenerator.new()
@onready var timer := $GeneratorTimer
@onready var progress_bar := $ProgressBar

@onready var data_label := $DataLabel
@onready var owned_label := $HBoxContainer2/OwnedLabel
@onready var pps_label := $HBoxContainer2/PPSLabel
@onready var buy_button := $Buttons/BuyButton
@onready var sell_button := $Buttons/SellButton
@onready var buy_label := $Labels/BuyLabel
@onready var sell_label := $Labels/SellLabel

func _ready():
	#loading from 
	var gen_defaults:PassiveGenerator = ResourceLoader.load("res://resources/generator_defualts.tres").resource[id]
	gen.base_speed = gen_defaults.base_speed
	gen.base_produce = gen_defaults.base_produce
	
	update_display()
	
	$NameLabel.text = gen.name
	
	timer.wait_time = gen.speeds
	if gen.amount == 0:
		timer.stop()
	else:
		timer.start()

func _process(delta):
	if gen.amount > 0:
		progress_bar.value += 100 * (delta / gen.speed)

func update_display():
	owned_label.text = "Owned: " + str(gen.amount)
	pps_label.text = "PPS: " + str(gen.produces * gen.amount / gen.speed)
	data_label.text = "Makes " + str(gen.produces  * gen.amount) + " product(s) in " + str(gen.speed) + " second(s)"
	buy_label.text = "Buy $" + Formatter.format(gen.cost_profile.get_cost(gen.amount))
	if gen.amount != 0:
		sell_label.text = "Sell $" + Formatter.format(gen.cost_profile.get_cost(gen.amount - 1) / 10)
	else:
		sell_label.text = "you have none"

func on_data_save():
	GlobalValues.data.generators.resource[id] = gen

# Node signals

func _on_buy_button_pressed():
	if GlobalValues.data.money >= gen.cost_profile.get_cost(gen.amount):
		if gen.amount == 0:
			timer.start()
		
		GlobalValues.data.money -= gen.cost_profile.get_cost(gen.amount)
		gen.amount += 1
	
	update_display()

func _on_sell_button_pressed():
	if gen.amount >= 1:
		gen.amount -= 1
		GlobalValues.data.money += gen.cost_profile.get_cost(gen.amount) / 10
	
	if gen.amount == 0:
		timer.stop()
		progress_bar.value = 0
	
	update_display()

func _on_generator_timer_timeout():
	progress_bar.value = 0
	
	GlobalValues.data.products += gen.produces * gen.amount
