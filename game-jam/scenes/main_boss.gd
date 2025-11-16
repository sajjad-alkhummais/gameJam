extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

var playerInRange = false;
var attacks = ["Attack1", "Attack2"]
func on_animation_finished(anim_name: StringName) -> void:
	if(playerInRange):
		var attackType = attacks[randi_range(0,1)]
		animation_player.play(attackType)
	else:
		animation_player.play("idle")
	
	print("test, idle")

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		playerInRange = true
		var attackType = attacks[randi_range(0,1)]
		animation_player.play(attackType)
		print("attack 1")

func _on_hitbox_entered(body: Node2D) -> void:
	#body.take_damage()
	print("Take damage")
	


func _on_detection_body_exited(body: Node2D) -> void:
	playerInRange = false;
