extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_btn_obs_pressed():
	var image = Image.new()
	var error = image.load("res://snapshot.png")
	if error != OK:
		print("Failed to load image")
		return
	
	
	var http = HTTPRequest.new()
	add_child(http)
	
	# Connect the request_completed signal to handle the response
	http.request_completed.connect(Callable(self, "_on_request_completed"))
	
	var url = settings.baseurl + "/obs"
	var boundary = "----GodotFormBoundary" + str(randi())
	
	var png_data = get_dummy_png_bytes()  # Replace with your own PNG data logic
	var body = PackedByteArray()
	body.append_array(boundary_header(boundary, "file", "image.png", "image/png"))
	body.append_array(image.save_png_to_buffer())
	body.append_array(("\r\n--" + boundary + "--\r\n").to_utf8_buffer())
	
	var headers = PackedStringArray([
		"Content-Type: multipart/form-data; boundary=" + boundary,
		"Content-Length: " + str(body.size())
	])
	
	var result = http.request_raw(url, headers, HTTPClient.METHOD_POST, body)
	if result != OK:
		print("request_raw failed with code: ", result)

func boundary_header(boundary: String, field_name: String, filename: String, mime_type: String) -> PackedByteArray:
	var header = "--%s\r\nContent-Disposition: form-data; name=\"%s\"; filename=\"%s\"\r\nContent-Type: %s\r\n\r\n" % [
		boundary, field_name, filename, mime_type
	]
	return header.to_utf8_buffer()

func _on_request_completed(result, response_code, headers, body):
	print("Request completed with status code: ", response_code)
	print("Response body:\n", body.get_string_from_utf8())

# Dummy placeholder just for compilation; replace with real image code
func get_dummy_png_bytes() -> PackedByteArray:
	var image = Image.create(64, 64, false, Image.FORMAT_RGBA8)
	image.fill(Color(1, 0, 0))  # Red square
	return image.save_png_to_buffer()
