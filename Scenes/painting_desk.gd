extends Node

@onready var canvas = $TextureRect/Mask

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
