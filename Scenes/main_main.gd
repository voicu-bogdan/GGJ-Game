extends Control
@onready var npc = $Customer
@onready var text = $DialogLayer/DialogBox/ActualText
@onready var dialog_texture = $DialogTexture
@onready var go_to_workshop = $Button
@onready var speaker_name = $DialogLayer/Name/Label
@onready var dialog_ui = $DialogLayer
var dialog_index : int = 0

const ANIMATION_SPEED : int = 30
var animate_text : bool = false
var current_visible_chars : int = 0 

const dialog_lines : Array[String] = [
	"Customer: Good day, Shopkeeper.",
	"Shopkeeper:Good day, Customer. What is it you are looking for?",
	"Customer: I was in search of a simple mask, a little spooky or maybe cute.",
	"Shopkeeper: You may be assured that you have come to the proper place."
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npc_id : int = 0
	var texture_name: String
	
	go_to_workshop.visible = false
	dialog_ui.visible = false
	dialog_texture.visible = false
	#await get_tree().create_timer(1).timeout
	
	npc_id = Globals.masksCompleted + 1
	
	if npc_id <= 6:
		npc.visible = false     
		npc.texture = load(get_texture(npc_id))
		npc.visible = true
		
		dialog_ui.visible = true
		dialog_texture.visible = true
		
		dialog_index = 0
		process_current_line()
	
	else:
		get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
		Globals.masksCompleted = 0
	
func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/painting_desk.tscn")

func get_texture(id) -> String:
	var texture_n: String
	texture_n = "res://Assets/Sprites/npc_" + str(id) + ".png"
	return texture_n
	
func parse_line(line : String):
	var line_info = line.split(":")
	assert(len(line_info) >= 2)
	return {
		"speaker_name": line_info[0],
		"text": line_info[1]
	}
	
func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info = parse_line(line)
	change_line(line_info["speaker_name"], line_info["text"])
	#speaker_name.text = line_info["speaker_name"]
	#text.text = line_info["text"]
	
func _input(event):
	if event.is_action_pressed("next_line"):
		if animate_text:
			skip_text_animation()
		else:
			if dialog_index < len(dialog_lines) - 1:
				dialog_index += 1
				process_current_line()
			else:
				dialog_ui.visible = false
				dialog_texture.visible = false
				go_to_workshop.visible = true

func change_line(speaker: String, line : String):
	speaker_name.text = speaker
	current_visible_chars = 0
	text.text = line
	text.visible_characters = 0
	animate_text = true
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	if animate_text:
		if text.visible_ratio < 1:
			text.visible_ratio += (1.0/text.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_chars = text.visible_characters
		else:
			animate_text = false

func skip_text_animation():
	text.visible_ratio = 1

func _on_texture_menu_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
