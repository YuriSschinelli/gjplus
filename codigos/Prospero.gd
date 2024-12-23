extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var movimento = []
var walking = false
var jumping = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func armazenaposicoes():
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		movimento.append(self.global_position)
		

func morte():
	get_tree().change_scene_to_file("res://tela_de_derrota.tscn")

func vencer():
		get_tree().change_scene_to_file("res://tela_de_vitoria.tscn")
		
func _physics_process(delta):
	# Add the gravity.
	armazenaposicoes()
	if not is_on_floor():
		get_node("AnimatedSprite2D").play("Jump")
		velocity.y += gravity * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		get_node("AnimatedSprite2D").play("Running")
		velocity.x = direction * SPEED
		if direction < 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x == 0 and velocity.y == 0:
		get_node("AnimatedSprite2D").play("Idle")
	print(movimento)
	move_and_slide()
