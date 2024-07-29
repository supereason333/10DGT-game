extends VBoxContainer

var gen := PassiveGenerator.new()
@onready var timer := $GeneratorTimer
@onready var progress_bar := $ProgressBar

@onready var data_label := $DataLabel
@onready var owned_label := $HBoxContainer2/OwnedLabel
@onready var pps_label := $HBoxContainer2/PPSLabel

func _ready():
	gen.cost = 0
	gen.produces = 1
	gen.speed = 1
	gen.amount = 0
	
	update_display()
	
	timer.wait_time = gen.speed
	timer.stop()

func _process(delta):
	if gen.amount > 0:
		progress_bar.value += 100 * gen.speed * delta

func update_display():
	owned_label.text = "Owned: " + str(gen.amount)
	pps_label.text = "PPS: " + str(gen.produces * gen.amount / gen.speed)
	data_label.text = "Makes " + str(gen.produces  * gen.amount) + " product(s) in " + str(gen.speed) + " seconds"

# Node signals

func _on_buy_button_pressed():
	gen.amount += 1
	
	update_display()
	
	if gen.amount == 1:
		timer.start()

func _on_sell_button_pressed():
	gen.amount -= 1
	
	update_display()

func _on_generator_timer_timeout():
	progress_bar.value = 0
	
	GlobalValues.products += gen.produces * gen.amount
