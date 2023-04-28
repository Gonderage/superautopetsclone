extends Node2D

@onready var pet_template = preload("res://pet_template.tscn")
@export var food_template:Node
@export var start_coins:int = 10

var current_coins = 10
var current_tier:int = 1
var shop_upgrade:int = 0
var pet_discount:int = 0
var food_discount:int = 0
var max_buy_price:int = 3

var current_neko:int = 0

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		spawn_pet(PetLib.get_pet(current_neko,1), %TeamGrid)
		current_neko = (current_neko + 1) % 2
		
		if %TeamGrid.get_child_count()>5: #if more than 5 pets--
			%TeamGrid.get_child(0).queue_free() #--then KILL the first pet
	
	if Input.is_action_just_pressed("ui_cancel") and %TeamGrid.get_child_count()>0:
		%TeamGrid.get_child(-1).queue_free()
		$AudioStreamPlayer.play()

func spawn_pet(pet_name:String, parent):
	var path = "res://pets/json/" + pet_name + ".json"
	var file = FileAccess.open(path, FileAccess.READ)
	var _json = JSON.parse_string(file.get_as_text())
	
	#BRING FORTH YOUR STRONGEST PET from the json data
	var new_pet = pet_template.instantiate()
	new_pet.set_script(load(_json["script"]))	#Script goes first or you can not set the variables.
	new_pet.loadJSON(_json,shop_upgrade,max_buy_price,pet_discount)
#	new_pet.selected.connect(_on_selected) #bind signal to function so 
	
	#Add to the scene
	parent.add_child(new_pet)
	new_pet.player.play()

func spawn_food(food_name:String):
	var path = "res://food/" + food_name + ".json"
	var file = FileAccess.open(path, FileAccess.READ)
	var _json = JSON.parse_string(file.get_as_text())
	
	var new_food = food_template.duplicate()
	new_food.set_script(load(_json["script"]))
	new_food.food_name = _json["name"]
	new_food.food_description = _json["description"]
	new_food.buy_price = clampi(max_buy_price - food_discount, 0, max_buy_price)
	new_food.texture = load(_json["sprite"])

func _on_selected():
	$AudioStreamPlayer.play()
