extends Sprite2D
class_name Pet

var pet_name:String = "Pet"
var pet_description:String = "Description"
var health:int = 1
var attack:int = 1
var tier:int = 1
var experience:int = 0
var buy_price:int = 3
var sell_price:int = 1
var player:AudioStreamPlayer

func loadJSON(_json,shop_upgrade,max_buy_price,pet_discount):
	name = _json["name"]
	pet_description = _json["description"]
	attack = clampi(_json["attack"] + shop_upgrade, 1, 50)
	health = clampi(_json["health"] + shop_upgrade, 1, 50)
	tier = _json["tier"]
	buy_price = clampi(max_buy_price - pet_discount, 0, max_buy_price)
	texture = load(_json["texture"])
	player = $AudioStreamPlayer
	player.stream = load(_json["sfx"])
