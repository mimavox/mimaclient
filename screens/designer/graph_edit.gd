extends GraphEdit

func _ready() -> void:
	# Allow only exact type matches, e.g. 0→0, 1→1, 2→2, ...
	for t in range(0, 8): # or whatever max you use
		add_valid_connection_type(t, t)
