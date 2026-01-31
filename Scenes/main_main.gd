extends Control
@onready var npc = $Customer
@onready var text = $DialogBox/ActualText
@onready var dialog_texture = $DialogTexture
@onready var go_to_workshop = $DialogBox/Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npc_id: int = 0
	var texture_name: String
	
	go_to_workshop.visible = false
	dialog_texture.visible = false
	await get_tree().create_timer(1).timeout
	
	npc_id+=1
	npc.visible = false     
	npc.texture = load(get_texture(npc_id))
	npc.visible = true
	
	dialog_texture.visible = true
	text.add_text("NPC: Good day, sir!")
	await get_tree().create_timer(2).timeout
	text.clear()
	
	text.add_text("Shopkeeper: Good day!")
	await get_tree().create_timer(2).timeout
	text.clear()
	
	#text.add_text("NPC: What a marvelous shop this is. I have heard much of it, and now I see the praise was well deserved.")
	#await get_tree().create_timer(2).timeout
	#text.clear()
	#
	#text.add_text("Shopkeeper:You have my thanks. I have labored in this shop for thirty years, having learned all I know from my father, who himself was taught by my grandfather. It is a family tradition, and I dearly hope my son shall continue it.") 
	#await get_tree().create_timer(2).timeout
	#text.clear()
	#
	#text.add_text("NPC:You are, indeed, a fortunate man")
	#await get_tree().create_timer(2).timeout
	#text.clear()
	#
	#text.add_text("Shopkeeper: How may I help you this day, sir? What is it you are looking for?")
	#await get_tree().create_timer(2).timeout
	#text.clear()
	#
	#text.add_text("NPC: I was in search of a simple mask, a little spooky but not severe, suited to a child of ten, and fashioned in the old manner. Nothing elaborate… with a touch of diabolism")
	#await get_tree().create_timer(2).timeout
	#text.clear()
	#
	#text.add_text("Shopkeeper: You may be assured that you have come to the proper place")
	#await get_tree().create_timer(2).timeout
	#text.clear()
	
	dialog_texture.visible = false
	go_to_workshop.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/painting_desk.tscn")

func get_texture(id) -> String:
	var texture_n: String
	texture_n = "res://Assets/Sprites/npc_" + str(id) + ".png"
	return texture_n
	
#func first_npc() -> void:
	#pick and show texture for first NPC
	#use get_dialog function to get the dialog
#	pass
	
#func get_dialog() -> string:
#	pass
