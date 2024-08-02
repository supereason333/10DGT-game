extends Node

func format(input:float) -> String:
	var settings := SaverLoader.load_settings()
	
	match settings.number_format:
		0:				# unformated
			return str(input)
		1:				# rounded if small, sci format if large
			if input >= pow(10, settings.number_format_accuracy + 2):
				return sci_format(input, settings.number_format_accuracy)
			else:
				return str(snapped(input, 1 / pow(10, settings.number_format_accuracy)))
		2:				# sci format for all
			return sci_format(input, settings.number_format_accuracy)
		_:
			return str(input)

func sci_format(number:float, decimal_places:int) -> String:
	# this code was totaly not written by chatgpt i am totaly not incompetent
	var abs_number = abs(number)
	var exponent = 0
	
	if abs_number != 0.0:
		while abs_number >= 10.0:
			abs_number /= 10.0
			exponent += 1
		while abs_number < 1.0:
			abs_number *= 10.0
			exponent -= 1
	
	# Format the number with specified decimal places
	var format_string = "%." + str(decimal_places) + "f"
	var formatted_number = format_string % abs_number
	
	if number < 0:
		formatted_number = "-" + formatted_number
	
	return formatted_number + "e" + str(exponent)
