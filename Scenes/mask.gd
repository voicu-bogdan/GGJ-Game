extends Sprite2D
#@onready var Sprite = get_node("Sprite2D")
#var isBeingPressed = false

@export var img_size := Vector2i(1000, 1000)
@export var paint_color := Color.RED
@export var brush_size := 10

var img : Image


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	img = Image.create_empty(img_size.x, img_size.y, false, Image.FORMAT_RGBA8)
	img.fill(Color.WHITE)
	texture = ImageTexture.create_from_image(img)
	

func _paint_tex(pos) ->void:
	img.fill_rect(Rect2i(pos, Vector2i(1, 1)).grow(brush_size), paint_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.is_echo() == false:
			if event.button_index == MOUSE_BUTTON_LEFT:
				var lpos = to_local(event.position)
				var impos = lpos-offset+get_rect().size/2.0
				_paint_tex(impos)
				texture.update(img)
			if event.button_index == MOUSE_BUTTON_RIGHT:
				var lpos = to_local(event.position)
				var impos = lpos-offset+get_rect().size/2.0
				paint_color = img.get_pixelv(impos)
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			var lpos = to_local(event.position)
			var impos = lpos-offset+get_rect().size/2.0
			_paint_tex(impos)
			texture.update(img)
