extends Node


var gallery_data = {
	cafe_background = {
		unlocked = false,
		title = "Stray Signals Cafe",
		description = "The cafe where the story begins, the home of Stray Signals."
	},
	ending_background = {
		unlocked = false,
		title = "City Overview",
		description = "Where the story ends... the city that is the home to all of the characters and stories that is the heart of Stray Signals."
	},
	alexandra_neutral = {
		unlocked = false,
		title = "Alexandra - Neutral",
		description = "The detective, Alexandra, who is trying to figure out what is going on around the city."
	},
	alexandra_happy = {
		unlocked = false,
		title = "Alexandra - Happy",
		description = "The detective, Alexandra, who is trying to figure out what is going on around the city."
	},
	alexandra_angry = {
		unlocked = false,
		title = "Alexandra - Angry",
		description = "The detective, Alexandra, who is trying to figure out what is going on around the city."
	},
	alexandra_sad = {
		unlocked = false,
		title = "Alexandra - Sad",
		description = "The detective, Alexandra, who is trying to figure out what is going on around the city."
	},
	loren_neutral = {
		unlocked = false,
		title = "Loren - Neutral",
		description = "Stray Signals long time coming regular who might be the only reason that you're still in business."
	},
	loren_happy = {
		unlocked = false,
		title = "Loren - Happy",
		description = "Stray Signals long time coming regular who might be the only reason that you're still in business."
	},
	loren_angry = {
		unlocked = false,
		title = "Loren - Angry",
		description = "Stray Signals long time coming regular who might be the only reason that you're still in business."
	},
	loren_sad = {
		unlocked = false,
		title = "Loren - Sad",
		description = "Stray Signals long time coming regular who might be the only reason that you're still in business."
	},
	archimedes_neutral = {
		unlocked = false,
		title = "Archimedes - Neutral",
		description = "Archimedes is the know it all... is he the missing link in the mystery?"
	},
	archimedes_happy = {
		unlocked = false,
		title = "Archimedes - Happy",
		description = "Archimedes is the know it all... is he the missing link in the mystery?"
	},
	archimedes_sad = {
		unlocked = false,
		title = "Archimedes - Sad",
		description = "Archimedes is the know it all... is he the missing link in the mystery?"
	},
	gg_neutral = {
		unlocked = false,
		title = "GG - Neutral",
		description = "There is more to GG than meets the eye."
	},
	gg_happy = {
		unlocked = false,
		title = "GG - Happy",
		description = "There is more to GG than meets the eye."
	},
	gg_angry = {
		unlocked = false,
		title = "GG - Angry",
		description = "There is more to GG than meets the eye."
	},
	gg_sad = {
		unlocked = false,
		title = "GG - Sad",
		description = "There is more to GG than meets the eye."
	},
	whiskerly_neutral = {
		unlocked = false,
		title = "Whiskerly - Neutral",
		description = "A new regular at Stray Signals. Why does Whiskerly seem so familiar? It's like I've known him for years."
	},
	whiskerly_happy = {
		unlocked = false,
		title = "Whiskerly - Happy",
		description = "A new regular at Stray Signals. Why does Whiskerly seem so familiar? It's like I've known him for years."
	},
	whiskerly_sad = {
		unlocked = false,
		title = "Whiskerly - Sad",
		description = "A new regular at Stray Signals. Why does Whiskerly seem so familiar? It's like I've known him for years."
	},
	zara_neutral = {
		unlocked = false,
		title = "Zara - Neutral",
		description = "Zara might just be the fanciest cat that you will ever meet."
	},
	zara_happy = {
		unlocked = false,
		title = "Zara - Happy",
		description = "Zara might just be the fanciest cat that you will ever meet."
	},
	zara_sad = {
		unlocked = false,
		title = "Zara - sad",
		description = "Zara might just be the fanciest cat that you will ever meet."
	},
	cup = {
		unlocked = false,
		title = "Cup",
		description = "An empty cup, but it has served so many drinks to the customers of Stray Signals."
	},
	mug = {
		unlocked = false,
		title = "Mug",
		description = "If you want a cozy, warm drink at Stray Signals, this is the cup for you."
	},
	glass = {
		unlocked = false,
		title = "Glass",
		description = "Feeling fancy?"
	},
	coffee = {
		unlocked = false,
		title = "Coffee",
		description = "The first thing ever served at Stray Signals was... you guessed it... a cup of coffee. How else does a night city keep running?"
	},
	matcha = {
		unlocked = false,
		title = "Coffee",
		description = "The first thing ever served at Stray Signals was... you guessed it... a cup of coffee. How else does a night city keep running?"
	},
	mango = {
		unlocked = false,
		title = "Coffee",
		description = "The first thing ever served at Stray Signals was... you guessed it... a cup of coffee. How else does a night city keep running?"
	},
	strawberry = {
		unlocked = false,
		title = "Coffee",
		description = "The first thing ever served at Stray Signals was... you guessed it... a cup of coffee. How else does a night city keep running?"
	},
	milk_tea = {
		unlocked = false,
		title = "Milk Tea",
		description = "To complement the coffee, of course Stray Signals serves milk tea too."
	},
	catnip = {
		unlocked = false,
		title = "Catnip",
		description = "At popular request, Stray Signals added catnip to it's menu and is the most popular spot for the city's cats to stop by to grab a drink."
	},
	boba = {
		unlocked = false,
		title = "Boba",
		description = "Boba is the perfect addition to any drink."
	},
	cream_and_cat_treats = {
		unlocked = false,
		title = "Cream & Cat Treats",
		description = "A fan favorite of the cat locals that visit Stray Signals."
	},
	magical_mushroom_fish = {
		unlocked = false,
		title = "Magical Mushroom Fish",
		description = "The only thing that will help solve the mystery clouding the city and bring your regulars back to Stray Signals."
	},
}
