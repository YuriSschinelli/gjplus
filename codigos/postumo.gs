extends CharacterBody2D

@onready var prospero = get_parent().get_node("Prospero")
const SPEED = 10000.0
const JUMP_VELOCITY = -400.0
@onready var lista_de_alvos = prospero.movimento
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _animation_manager():
	if self.velocity.y > 0:
		get_node("AnimatedSprite2D").play("Up")
	elif self.velocity.y < 0:
		get_node("AnimatedSprite2D").play("Down")
	if self.velocity.x > 0:
		get_node("AnimatedSprite2D").play("Side")
		get_node("AnimatedSprite2D").flip_h = false
	elif self.velocity.x > 0:
		get_node("AnimatedSprite2D").play("Side")
		get_node("AnimatedSprite2D").flip_h = true
	
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	# Add the gravity.
	_animation_manager()
	await get_tree().create_timer(0.1).timeout
	if not lista_de_alvos.is_empty():
		direction = (lista_de_alvos[0] - self.position).normalized()
		velocity.x = direction.x * SPEED * delta
		velocity.y = direction.y * SPEED * delta
		if position.distance_to(lista_de_alvos[0]) < 68 :
			lista_de_alvos.pop_at(0)
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	if $Morte.overlaps_body(prospero):
		prospero.morte()
	
