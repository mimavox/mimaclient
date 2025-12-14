extends GraphEdit

# Define type compatibility (use your actual type definitions and logic)
var node_types_compatibility = {
	"type_A": ["type_B", "type_C"], # type_A can connect to type_B and type_C
	"type_B": ["type_A"],          # type_B can connect to type_A
	"type_C": []                   # type_C cannot connect to any type
}

# Overriding the is_valid_connection method
func is_valid_connection(from_node: String, from_port: int, to_node: String, to_port: int) -> bool:
	var from_node_type = get_node_type(from_node) # Get the type of from_node
	var to_node_type = get_node_type(to_node)     # Get the type of to_node
	
	if to_node_type in node_types_compatibility.get(from_node_type, []):
		return true  # Connection is valid
	return false     # Connection is invalid
	
# Helper function to get the node type. Replace this with your actual logic.
func get_node_type(node_name: String) -> String:
	# Assuming each child GraphNode has metadata for their type
	var node = $GraphNodeContainer.get_node(node_name)
	return node.metadata_get("type")
