extends GraphEdit

# Overriding the is_valid_connection method
func is_valid_connection(from_node: String, from_port: int, to_node: String, to_port: int) -> bool:
	# Get the output type of the from_node
	var from_node_output_type = get_node(from_node).get_connection_output_type(from_port)
	print(from_node_output_type)
	# Get the input type of the to_node
	var to_node_input_type = get_node(to_node).get_connection_input_type(to_port)
	print(to_node_input_type)
	
	# Check if the output type matches the input type
	return from_node_output_type == to_node_input_type
