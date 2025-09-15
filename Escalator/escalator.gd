extends CharacterBody2D

var gravity = 300
var walkingVelocity = 150
var jumpVelocity = 200

signal beenHit;

func _ready() -> void:
	pass

var startedDown = false
var jumpCount = 0;
	
func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		if(velocity.y > 0 && !startedDown):
			$AnimatedSprite2D.animation = "jump_down"
			$AnimatedSprite2D.play();
			startedDown = true
	else:
		velocity.y = 0
		startedDown = false
		jumpCount = 0
	
	if Input.is_action_pressed("Right"):
		velocity.x = walkingVelocity
		if(is_on_floor()):
			$AnimatedSprite2D.animation = "walking"
			$AnimatedSprite2D.play();
		$AnimatedSprite2D.flip_h = false;
	elif Input.is_action_pressed("Left"):
		velocity.x = -walkingVelocity;
		if(is_on_floor()):
			$AnimatedSprite2D.animation = "walking"
			$AnimatedSprite2D.play();
		$AnimatedSprite2D.flip_h = true;
	else:
		velocity.x = 0
		if(is_on_floor()):
			$AnimatedSprite2D.animation = "default"
			$AnimatedSprite2D.play();
	
	if Input.is_action_just_pressed("Jump") && (is_on_floor() || jumpCount < 2):
		velocity.y = -jumpVelocity
		$AnimatedSprite2D.animation = "jump_up"
		$AnimatedSprite2D.play()
		jumpCount += 1
		startedDown = false
		
		
	move_and_slide();


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Ow!")
	$CPUParticles2D.emitting = true
	$AudioStreamPlayer.play() # Replace with function body.
	beenHit.emit();

func doSomething() -> void:
	print("Doing Something!");
