extends GraphEdit

# Overriding the is_valid_connection method to check port types
func is_valid_connection(from_node: String, from_port: int, to_node: String, to_port: int) -> bool:
	# Get the actual nodes
	var from_node_instance = get_node(from_node)
	var to_node_instance = get_node(to_node)

	# Get the port types (Output of From_Node, Input of To_Node)
	var from_port_type = from_node_instance.get_connection_output_type(from_port)
	var to_port_type = to_node_instance.get_connection_input_type(to_port)

	# Check if they match
	return from_port_type == to_port_type
