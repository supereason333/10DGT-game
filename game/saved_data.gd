extends Resource
class_name SavedData

@export var money := 0.0
@export var products := 0.0:
	set(value):
		products = int(value)
	get:
		return products

@export var product_cost := 0.1

@export var generators := GeneratorDefaults.new()

@export var work_speed := 10
@export var work_produce := 1
