extends Node

@onready var canvas = $TextureRect/Mask
@onready var view = $SubViewportContainer/SubViewport
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_color_rect_focus_entered() -> void:
	canvas.paint_color = Color.RED


func _on_color_rect_2_focus_entered() -> void:
	canvas.paint_color = Color.GREEN


func _on_color_rect_3_focus_entered() -> void:
	canvas.paint_color = Color.BLUE


func _on_color_rect_4_focus_entered() -> void:
	canvas.paint_color = Color.WHITE


func _on_h_slider_drag_ended(value_changed: bool) -> void:
	canvas.brush_size = $Panel/HSlider.value
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		view.get_texture().get_image().\
		save_jpg("res://Debug/Debug.jpg")
		pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	canvas.square = $Panel/CheckButton.button_pressed
