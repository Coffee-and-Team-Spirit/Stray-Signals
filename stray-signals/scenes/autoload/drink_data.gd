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
					"fancy_cozy_intensity": [3, 4]
				}
			},
			"good": {
				"ingredients": {
					"flavors": ["matcha"]
				},
				"stats": {
					"fancy_cozy_direction": ["fancy"],
					"fancy_cozy_intensity": [2, 3, 4]
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
					"bitter_sweet_intensity": [-1, 0, 1],   # less than slightly sweet
					"cool_warm_direction": ["cool"],
					"cool_warm_intensity": [1, 2, 3, 4]     # all intensities of cool
				}
			},
			"good": {
				"ingredients": {
					"topping": "cream_and_cat_treats"
				},
				"stats": {
					"bitter_sweet_intensity": [-1, 0, 1], 
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
					"fancy_cozy_direction": ["cozy"],
					"fancy_cozy_intensity": [2, 1],
					"cool_warm_direction": ["warm"],
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
					"flavors_or": ["strawberry", "mango"],
					"topping": "boba",
				},
				"stats": {}
			}
		},
		2: {
			"perfect": {
				"ingredients": {
					"modification": "shake"
				},
				"stats": {
					"bitter_sweet_direction": ["sweet"],
					"bitter_sweet_intensity": [2, 3, 4]
				}
			},
			"good": {
				"ingredients": {
					"modification": "shake"
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
					"cool_warm_direction": ["cool"],
					"cool_warm_intensity": [3, 4]
				}
			},
			"good": {
				"ingredients": {
					"flavors_or": ["strawberry", "mango"]
				},
				"stats": {
					"cool_warm_direction": ["cool"],
					"cool_warm_intensity": [2, 3, 4]
				}
			}
		}
	},
	4: {
		1: {
			"perfect": {
				"ingredients": {
					"flavors": ["mango", "mango"], 
					"toppings": ["catnip"]
				},
			"stats": {}
			},
			"good": {
				"ingredients": {
					"flavors": ["mango"],
					"toppings": ["catnip"]
				},
				"stats": {}
			},
		},
		2: {
			"perfect": {
				"ingredients": {
					"flavors_not": ["matcha"]
				},
				"stats": {
					"fancy_cozy_intensity": [-1, 0]
				}
			},
			"good": {
				"ingredients": {
					"flavors_not": ["matcha"]
				},
				"stats": {
					"fancy_cozy_intensity": [-1, 0, 1, 2]
				}
			},
		},
		3: {
			"perfect": {
				"ingredients": {
					"modification": "shake"
				},
				"stats": {
					"bitter_sweet_direction": ["sweet"],
					"bitter_sweet_intensity": [2, 3, 4]
				}
			},
			"good": {
				"ingredients": {
					"modification": "shake"
				},
				"stats": {}
			}		
		},
		4: {
			"perfect": {
				"ingredients": {
					"cup": "cup",
					"topping": "boba"
				},
				"stats": {
					"cool_warm_direction": ["cool"],
					"cool_warm_intensity": [3, 4]
				}
			},
			"good": {
				"ingredients": {
					"cup": "cup",
					"topping": "boba"
				},
				"stats": {
					"cool_warm_direction": ["cool"],
					"cool_warm_intensity": [1, 2, 3, 4]
				}
			}
		}
	},
	5: {
		2: {
			"perfect": {
				"ingredients": {
					"modification": "stir"
				},
				"stats": {
					"cool_warm_direction": ["warm"],
					"cool_warm_intensity": [3, 4]
				}
			},
			"good": {
				"ingredients": {
					"modification": "stir"
				},
				"stats": {
					"cool_warm_direction": ["warm"],
					"cool_warm_intensity": [2, 3, 4]
				}
			}
		},
		3: {
			"perfect": {
				"ingredients": {
					"modification": "stir",
					"flavors": ["coffee"],
					"topping": "magical_mushroom_fish"
				},
				"stats": {
					"cool_warm_intensity": [-1],
					"fancy_cozy_direction": ["fancy"],      
					"fancy_cozy_intensity": [0, 1, 2, 3, 4] 
				}
			},
			"good": {
				"ingredients": {
					"flavors": ["coffee"],
					"topping": "magical_mushroom_fish"
				},
				"stats": {
					"cool_warm_intensity": [-1, 0],
					"fancy_cozy_direction": ["fancy"],      
					"fancy_cozy_intensity": [0, 1, 2, 3, 4] 
				}
			}
		},
		4: {
			"perfect": {
				"ingredients": {
					"modification": "shake",
					"topping": "boba"
				},
				"stats": {
				}
			},
			"good": {
				"ingredients": {
					"topping": "boba"
				},
				"stats": {
				}
			}
		},
		5: {
			"perfect": {
				"ingredients": {
					"flavors": ["strawberry", "milk_tea"],
					"cup": "glass"
				},
				"stats": {
					"bitter_sweet_direction": ["sweet"],
					"bitter_sweet_intensity": [-1, 0]
				}
			},
			"good": {
				"ingredients": {
					"flavors": ["strawberry", "milk_tea"],
					"cup": "glass"
				},
				"stats": {
				}
			}
			
		},
		6: {
			"perfect": {
				"ingredients": {
				},
				"stats": {
					"fancy_cozy_intensity": [-1, 0],
					"bitter_sweet_intensity": [-1, 0],
					"cool_warm_intensity": [-1, 0]
				}
			},
			"good": {
				"ingredients": {
				},
				"stats": {
					"fancy_cozy_intensity": [-1, 0, 2],
					"bitter_sweet_intensity": [-1, 0, 2],
					"cool_warm_intensity": [-1, 0, 2]
				}
			}
			
			
				
		}
	}
}
