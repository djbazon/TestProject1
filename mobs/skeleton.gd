extends CharacterBody2D

var chase = false
var speed = 10
const jump_velocity = -100
var jumpf = false
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 0.7
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)	
	timer.start()
	
	
func _on_timer_timeout():
	if jumpf == true:
		velocity.y = jump_velocity
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.3
	var player = $"../../player/Adlof"
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = speed * direction.x
	else:
		velocity.x =0 
	move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Adlof":
		chase = true
		jumpf = true	
func _on_detector_body_exited(body: Node2D) -> void:
	if body.name == "Adlof":
		chase = false
		jumpf = false
