extends Node
class_name PetLib

const tier1 = {
	0: "modern",
	1: "chaos",
	2: "classic",
	3: "destiny",
	4: "sad"
}

const tier2 = {
	0: "3d",
	1: "amogus",
	2: "sonic",
	3: "sad",
	4: "pixel"
}

const tier3 = {
	0: "ankha",
	1: "happy",
	2: "megumin",
	3: "smoker",
	4: "vile"
}

const tiers = {
	1: tier1,
	2: tier2,
	3: tier3
}

static func get_pet(pet:int, tier:int):
	return tiers[tier][pet]
