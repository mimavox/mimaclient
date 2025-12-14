# File: graph_node.gd
extends GraphNode

func _ready():
	print("LADDAD!")

# Store input and output types for the GraphNode
var input_port_types = []
var output_port_types = []

# Get the input type of a specific port
func get_connection_input_type(port_index: int) -> int:
	return input_port_types[port_index] if port_index < input_port_types.size() else null

# Get the output type of a specific port
func get_connection_output_type(port_index: int) -> int:
	return output_port_types[port_index] if port_index < output_port_types.size() else null
