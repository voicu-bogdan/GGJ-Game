extends Control
@onready var npc = $Customer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	npc.texture = load("res://Assets/Sprites/npc_1.png")
	
	#npc.texture = load("res://Assets/Sprites/npc_line.png")
	#await get_tree().create_timer(10).timeout
	#npc.texture = load("res://Assets/Sprites/npc_line_red.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
