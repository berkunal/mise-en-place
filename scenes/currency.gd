extends Control

@export var currentMoney = 0

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Panel/HBoxContainer/MoneyCount.text = str(currentMoney)

func incrementMoneyByValue(inc):
	currentMoney += inc

func _on_test_button_pressed():
	incrementMoneyByValue(2)
