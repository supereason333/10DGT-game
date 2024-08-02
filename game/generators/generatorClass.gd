extends Resource
class_name PassiveGenerator

@export var name := "generator name"
@export var amount:int			# How many do you own
@export var cost_profile:CostProfile = CostProfile.new()	# skil isue

@export var base_speed:float
@export var base_produce:int

@export var produces:int:		# how many products are made
	set(value):
		produces = value
	get:
		return base_produce + produce_add
@export var speed:float:
	set(value):
		speed = value
	get:
		return base_speed * speed_mult

@export var speed_mult := 1.0	# multiply of speed (lower is better)
@export var produce_add := 0	# how much more it makes
