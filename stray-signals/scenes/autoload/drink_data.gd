extends Node

# Day -> Encounter(s)
var drink_puzzles = {
	1: {
		1: {
			"perfect": {
				"ingredients": {
					"flavors": ["matcha", "mango"],
					"topping": "boba",
					"cup": "mug",
					"modification": "heat"
				},
				"stats": {}
			},
			"good": {
				"ingredients": {
					"flavors": ["matcha", "mango"],
					"topping": "boba",
					"cup": "mug",
					"modification": "heat"
				},
				"stats": {}
			}
		},
		2: {
			"perfect": {
				"ingredients": {
					"flavors": ["matcha"],
					"modification": "stir"
				},
				"stats": {
					"fancy_cozy_direction": ["fancy"],
					"fancy_cozy_intensity": [4, 3]
				}
			},
			"good": {
				"ingredients": {
					"flavors": ["matcha"]
				},
				"stats": {
					"fancy_cozy_direction": ["fancy"],
					"fancy_cozy_intensity": [2]
				}
			}
		},
	},
	2: {
		1: {
			"perfect": {
				"ingredients": {
					"topping": "cream_and_cat_treats"
				},
				"stats": {
					"bitter_sweet_direction": ["sweet"],
					"bitter_sweet_intensity": [-1, 0, 1],   # less than half sweet
					"cool_warm_direction": ["cold"],
					"cool_warm_intensity": [4, 3]           # extremely or very cool
				}
			},
			"good": {
				"ingredients": {
					"topping": "cream_and_cat_treats"
				},
				"stats": {
					"bitter_sweet_direction": ["sweet"],
					"bitter_sweet_intensity": [-1, 0, 1, 2],  # < 6 sweet
					"cool_warm_direction": ["cold"],
					"cool_warm_intensity": [3, 2]             # > 5 cool
				}
			}
		},
		2: {
			"perfect": {
				"ingredients": {
					"flavors": ["mango"],
					"topping": "catnip"
				},
				"stats": {}
			},
			"good": {
				"ingredients": {
					"flavors": ["mango"],
					"topping": "catnip"
				},
				"stats": {}
			},
		},
		3: {
			"perfect": {
				"ingredients": {
					"topping": "cream_and_cat_treats"
				},
				"stats": {
					"fancy_cozy_direction": ["cozy"],
					"fancy_cozy_intensity": [4, 3],
					"cool_warm_direction": ["warm"],
					"cool_warm_intensity": [4, 3]
					}
			},
			"good": {
				"ingredients": {
					"topping": "cream_and_cat_treats"
				},
				"stats": {
					"fancy_cozy_intensity": [2, 1],
					"cool_warm_intensity": [2, 1]
				}
			}
		}
	},
	3: {
		1: {
			"perfect": {
				"ingredients": {
					"flavors": ["milk_tea"],
					"flavors_or": ["strawberry", "mango"],
					"topping": "boba",
				},
				"stats": {}
			},
			"good": {
				"ingredients": {
					"flavors": ["milk_tea"],
					"topping": "boba",
				},
				"stats": {}
			}
		},
		2: {
			"perfect": {
				"ingredients": {
					"topping": "boba",
					"modification": "shake"
				},
				"stats": {}
			},
			"good": {
				"ingredients": {
					"topping": "boba"
				},
				"stats": {}
			}	
		},
		3: {
			"perfect": {
				"ingredients": {
					"flavors": ["strawberry", "mango"]
				},
				"stats": {
					"cool_warm_direction": ["cold"],
					"cool_warm_intensity": [4, 3]
				}
			},
			"good": {
				"ingredients": {
					"flavors_or": ["strawberry", "mango"]
				},
				"stats": {
					"cool_warm_direction": ["cold"],
					"cool_warm_intensity": [2]
				}
			}
		}
	},
	4: {
		1: {
			
		},
		2: {
			
		},
		3: {
			
		}
	},
	5: {
		1: {
			
		}
	}
}
