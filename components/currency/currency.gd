extends Control

@export var current_money = 0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Panel/HBoxContainer/MoneyCount.text = str(current_money)

func increment_money_by_value(inc):
	current_money += inc

func _on_test_button_pressed():
	increment_money_by_value(2)
