extends CanvasLayer

var index: int = 0
var tutorial_slides : Array = [
	{
		"text": "Here at [i]Stray Signals[/i], you’ll be crafting drinks for customers that you encounter. Each customer will ask for their drink to have various [b]traits[/b] or [b]flavors[/b]. It’s up to you to figure out the combination of [b]ingredients[/b] to serve them the perfect drink!",
		"image": preload("res://assets/art/tutorial/tutorial_1.png")
		},
	{
		"text": "Here you see the different types of [i]ingredients[/i] you can add to your drinks. Each drink will be composed of a [b]container[/b], a [b]base flavor[/b], a [b]secondary flavor[/b], a [b]topping[/b], and a [b]modification[/b]. When you select an [i]ingredient[/i], it will appear below the shelves.",
		"image": preload("res://assets/art/tutorial/tutorial_2.png")
	},
	{
		"text": "First select your [i]container[/i] type, then select your [i]base flavor[/i] by [b]clicking and dragging[/b] the [i]ingredient[/i] to the drink and [b]pressing “P”[/b] to [i]pour[/i]. Repeat with the [i]secondary flavor[/i]. Finally select your [i]topping[/i], and [i]modification[/i]. ",
		"image": preload("res://assets/art/tutorial/tutorial_3.png")
	},
	{
		"text": "Each [i]ingredient[/i] will change the [b]traits[/b] of your drink. Use these [b]traits[/b] to help [i]serve[/i] customers the perfect drink. For example, if a customer is asking for a [b]cool[/b] drink, you may want to increase the [b]cool trait[/b] in your drink.",
		"image": preload("res://assets/art/tutorial/tutorial_4.png")
	},
	{
		"text": "Once you have finished making your drink, you may serve it to the customer by clicking [b]serve[/b]. Or if you would like to change something, click [b]restart[/b] to clear the board and start again.",
		"image": preload("res://assets/art/tutorial/tutorial_5.png")
	}
]


func start_tutorial():
	index = 0
	visible = true
	show_slide()


func show_slide():
	var slide = tutorial_slides[index]
	
	$SlidePanel/VBoxContainer/Image.texture = slide["image"]
	$SlidePanel/VBoxContainer/RichTextLabel.text = slide["text"]
	
	if index == tutorial_slides.size() - 1:
		$SlidePanel/VBoxContainer/NextButton.text = "START!"
	else:
		$SlidePanel/VBoxContainer/NextButton.text = "NEXT"


func _on_next_button_pressed():
	if index < tutorial_slides.size() - 1:
		index += 1
		show_slide()
	else:
		hide()
