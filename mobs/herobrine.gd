extends CharacterBody2D

var chase = false
var speed = 100
const jump_velocity = -100
var alive = true

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.3
	var player = $"../../player/Adlof"
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = speed * direction.x
	else:
		velocity.x =0
		
	if chase == true and is_on_floor():
		
		if direction.x < 0:
			velocity.x = -speed
			$Sprite2D.flip_h = 0
		if direction.x > 0:
			velocity.x = speed
			$Sprite2D.flip_h = 1
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Adlof":
		chase = true

func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Adlof":
		chase = false

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Adlof":
		alive = false
		queue_free()
		death()
func death ():
	if alive == false:
		get_tree().change_scene_to_file("res://menu.tscn")
		

func _on_head_body_entered(body: Node2D) -> void:
	if body.name == "Adlof":
		$Herobrine_Text.text="Слезь, выблядок"

func _on_head_body_exited(body: Node2D) -> void:
	$Herobrine_Text.text=""
