extends CharacterBody2D

var mainBossPositions = [Vector2(430,230), Vector2(630,230)]

var direction = null;
var playerInRange = false;
@export var MOVE_SPEED: float = 100.0
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D
# This variable will store a reference to the player (the "cat")
var player_target: Node2D = null
# The _ready() function runs once when the boss enters the scene.
# We'll use it to find the player.
func _ready():
	# This line searches the entire game scene
	# for the first node in the "player" group.
	player_target = get_tree().get_first_node_in_group("player")
	# This is a safety check in case you forget to add the player to the group.
	if player_target == null:
		print("MAIN BOSS ERROR: Could not find any node in the 'player' group. The boss will not move.")
	else:
		direction = (player_target.global_position - global_position).normalized()
	
func _physics_process(delta):
	
	if not player_target:
		return

	direction = (player_target.global_position - global_position).normalized()
	if not playerInRange:
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		move_and_slide()
	
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true


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


func _on_timer_timeout() -> void:
	print("3 sec passed")
		# First, check if we successfully found the player in the _ready() function.
	if not playerInRange:
		velocity = direction * MOVE_SPEED
