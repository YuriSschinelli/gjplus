extends Area2D
@onready var prospero = $"../Prospero"
#TODO fazer esse código generalizável para todas as transições
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.overlaps_body(prospero):
		if Input.is_action_just_pressed("ui_enter"):
			get_tree().change_scene_to_file("res://Sala04.tscn")
