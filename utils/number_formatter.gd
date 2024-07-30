extends Node

func _ready():
	print(sci_format(0.00000234223, 4))

func format(input:float):
	var settings := SaverLoader.load_settings()
	
	match settings.number_format:
		0:
			return input
		1:
			return 
		_:
			return input

func sci_format(number:float, dp:int) -> String:
	var return_string := ""
	var num := str(number)
	if !num.contains("."):
		num += ".0"
	
	var whole := num.split(".")[0]
	var deci := num.split(".")[1]
	
	if int(whole) != 0:
		return_string += whole[0] + "."
		
		var exp:int = len(whole) - 1
		
		if len(whole + deci) <= dp:
			var zero := ""
			for i in range(dp - len(str(whole + deci)) + 1):
				zero += "0"
				
			return_string += str(whole + deci).right(-1) + zero + "e" + str(exp)
		else:
			return_string += str(whole + deci).right(-1).left(dp) + "e" + str(exp)
	
	return return_string
