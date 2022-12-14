extends Area2D

signal hit
signal collected

export var speed = 400
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func _process(delta):
	var velocity = Vector2.ZERO #the players movement vector
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("ui_menu"):
		emit_signal("unpause")
		get_tree().paused = true
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.y = clamp(position.y, 72, screen_size.y - 75)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Mafi_body_entered(body):
	print(body.get_name())
	if (body.get_name().matchn("*Stone*")):
		print("stone collosion")

		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		print("fish collision")
		emit_signal("collected")
		body.queue_free()
