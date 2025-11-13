extends Control

@onready var hide_button: Button = $HideButton
@onready var show_button: Button = $ShowButton


func _ready():
	
	hide_button.pressed.connect(_hide_hand)
	show_button.pressed.connect(_show_hand)


func _hide_hand():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(self.position.x, self.position.y+180), 0.5)
	await tween.finished
	show_button.show()
	hide_button.hide()

func _show_hand():
	show_button.hide()
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(self.position.x, self.position.y-180), 0.5)
	await tween.finished
	hide_button.show()
