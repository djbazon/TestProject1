extends CharacterBody2D

var chase = false
var speed = 300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var player = $"../../player/Adlof"
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = speed * direction.x
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Adlof":
		chase = true	
