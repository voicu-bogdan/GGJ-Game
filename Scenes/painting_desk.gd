extends Node

@onready var canvas = $TextureRect/Mask
@onready var view = $SubViewportContainer/SubViewport
@onready var color_label = $"Panel2/Color Label"
@onready var cuteness = $Panel2/CutenessBar
@onready var scariness = $Panel2/ScarinessBar
var timer = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#await RenderingServer.frame_post_draw
	#var view = get_viewport()
	#view.canvas_cull_mask = 2
	#await RenderingServer.frame_post_draw
	#view.get_texture().get_image().\
		#save_jpg("res://Debug/Debug.jpg")
	#view.canvas_cull_mask = 0xFFFFFFFF
	#var image = thing.get_texture().get_image()
	#image.save_png("res://Debug/Debug.png")

func count_colors() -> void:
	var img = canvas.texture.get_image()
	var counts = {}
	for y in range(img.get_height()):
		for x in range(img.get_width()):
			var pixel_color = img.get_pixel(x, y)
			var color_str = pixel_color.to_html()
			if counts.has(color_str):
				counts[color_str] += 1
			else:
				counts[color_str] = 1
	if is_instance_valid(self):
		call_deferred("_update_ui", counts)

func _update_ui(counts: Dictionary) -> void:
	print("Color Counts: " + str(counts))

	var scary_score := 0
	var cute_score := 0
	var scary_total := 0
	var cute_total := 0

	# ---- SCARY COLORS ----
	if counts.has("7c0200ff"): # Blood Red
		scary_score += counts["7c0200ff"]
		scary_total += counts["7c0200ff"]

	if counts.has("301934ff"): # Dark Purple
		scary_score += counts["301934ff"]
		scary_total += counts["301934ff"]

	if counts.has("176161ff"): # Teal
		scary_score += counts["176161ff"]
		scary_total += counts["176161ff"]

	if counts.has("32cd32ff"): # Lime Green
		scary_score += counts["32cd32ff"]
		scary_total += counts["32cd32ff"]

	if counts.has("030626ff"): # Dark Blue
		scary_score += counts["030626ff"]
		scary_total += counts["030626ff"]

	if counts.has("28282bff"): # Black Mate
		scary_score += counts["28282bff"]
		scary_total += counts["28282bff"]

	# ---- CUTE COLORS ----
	if counts.has("fa5053ff"): # Strawberry
		cute_score += counts["fa5053ff"]
		cute_total += counts["fa5053ff"]

	if counts.has("b0f5aeff"): # Sweet Green
		cute_score += counts["b0f5aeff"]
		cute_total += counts["b0f5aeff"]

	if counts.has("886290ff"): # Lilac Purple
		cute_score += counts["886290ff"]
		cute_total += counts["886290ff"]

	if counts.has("ffcf09ff"): # Peachy Orange
		cute_score += counts["ffcf09ff"]
		cute_total += counts["ffcf09ff"]

	if counts.has("ffb0eaff"): # Vanilla Cream
		cute_score += counts["ffb0eaff"]
		cute_total += counts["ffb0eaff"]

	if counts.has("9dd9e4ff"): # Seafoam Blue
		cute_score += counts["9dd9e4ff"]
		cute_total += counts["9dd9e4ff"]

	# ---- NORMALIZE EACH BAR INDEPENDENTLY ----
	var scary_denominator: float = scary_total + cute_total
	if scary_denominator == 0:
		return

	scariness.value = clamp(float(scary_score) / scary_denominator * 100.0, 0, 100)
	cuteness.value  = clamp(float(cute_score)  / scary_denominator * 100.0, 0, 100)


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += 1
	if timer == 100:
		timer = 0 
		WorkerThreadPool.add_task(count_colors)

		


func _on_color_rect_focus_entered() -> void:
	canvas.paint_color = Globals.bloodRed


func _on_color_rect_2_focus_entered() -> void:
	canvas.paint_color = Globals.darkPurple


func _on_color_rect_3_focus_entered() -> void:
	canvas.paint_color = Globals.teal


func _on_color_rect_4_focus_entered() -> void:
	canvas.paint_color = Globals.limeGreen


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	canvas.brush_size = $Panel/HSlider.value
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		view.get_texture().get_image().\
		save_jpg("res://Debug/Debug.jpg")
		pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	canvas.square = $Panel/CheckButton.button_pressed


func _on_color_rect_5_focus_entered() -> void:
	canvas.paint_color = Globals.darkBlue


func _on_color_rect_6_focus_entered() -> void:
	canvas.paint_color = Globals.blackMate


func _on_color_rect_7_focus_entered() -> void:
	canvas.paint_color = Globals.strawberry


func _on_color_rect_8_focus_entered() -> void:
	canvas.paint_color = Globals.sweetGreen


func _on_color_rect_9_focus_entered() -> void:
	canvas.paint_color = Globals.lilacPurple


func _on_color_rect_10_focus_entered() -> void:
	canvas.paint_color = Globals.peachyOrange


func _on_color_rect_11_focus_entered() -> void:
	canvas.paint_color = Globals.vanillaCream


func _on_color_rect_12_focus_entered() -> void:
	canvas.paint_color = Globals.seafoamBlue


func _on_button_button_up() -> void:
	Globals.finishedCuteness = cuteness.value
	Globals.finishedScariness = scariness.value
	print(Globals.finishedCuteness)
	print(Globals.finishedScariness)
	Globals.masksCompleted += 1
	print(Globals.masksCompleted)
	get_tree().change_scene_to_file("res://Scenes/main_main.tscn")
