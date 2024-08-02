extends Resource
class_name CostProfile

@export var base_cost:float
@export var step_add:float
@export var step_mult:float

var table := [0.0]

func get_cost(number:int):
	table[0] = base_cost
	if number >= len(table):
		calc_to(number)
	return table[number]

func calc_to(target:int):
	while len(table) <= target:
		table.append((table[-1] + step_add) * step_mult)
