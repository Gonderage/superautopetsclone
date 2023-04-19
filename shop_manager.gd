extends Node2D

@export var pet_template:Node
@export var food_template:Node
@export var start_coins:int = 10

var current_coins = 10
var current_tier:int = 1
var shop_upgrade:int = 0
var pet_discount:int = 0
var food_discount:int = 0
var max_buy_price:int = 3

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		spawn_pet("nekoarc", $"..")

func spawn_pet(pet_name:String, parent):
	var path = "res://pets/" + pet_name + ".json"
	var file = FileAccess.open(path, FileAccess.READ)
	var _json = JSON.parse_string(file.get_as_text())
	
	#BRING FORTH YOUR STRONGEST PET from the json data
	var new_pet = pet_template.duplicate()
	new_pet.set_script(load(_json["script"]))	#Script goes first or you can not set the variables.
	new_pet.pet_name = _json["name"]
	new_pet.pet_description = _json["description"]
	new_pet.attack = clampi(_json["attack"] + shop_upgrade, 1, 50)
	new_pet.health = clampi(_json["health"] + shop_upgrade, 1, 50)
	new_pet.tier = _json["tier"]
	new_pet.buy_price = clampi(max_buy_price - pet_discount, 0, max_buy_price)
	new_pet.texture = load(_json["texture"])
	new_pet.position = get_global_mouse_position()
	
	#Add to the scene
	parent.add_child(new_pet)

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
