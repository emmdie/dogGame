extends Node


export(PackedScene) var stone_scene
export(PackedScene) var fish_scene
var score

func _ready():
	randomize()

func game_over():
	$RockTimer.stop()
	$FishTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()

func new_game():
	score = 0
	$Mafi.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_StartTimer_timeout():
	$RockTimer.start()
	$FishTimer.start()




func _on_RockTimer_timeout():
	var stone = stone_scene.instance()


	# Choose a random location on Path2D.
	var stone_spawn_location = get_node("RockPath/RockSpawnLocation")
	stone_spawn_location.offset = randi()
	


	# Set the mob's direction perpendicular to the path direction.
	var direction = stone_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	stone.position = stone_spawn_location.position


	# Add some randomness to the direction.
	#direction += rand_range(-PI / 4, PI / 4)
	#mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	stone.linear_velocity = velocity.rotated(direction)


	# Spawn the mob by adding it to the Main scene.
	add_child(stone)
	



func _on_FishTimer_timeout():
	var fish = fish_scene.instance()
	
	var fish_spawn_location = get_node("FishPath/FishSpawnLocation")
	fish_spawn_location.offset = randi()
	
	var direction = fish_spawn_location.rotation + PI / 2
	
	fish.position = fish_spawn_location.position
	
	var velocity = Vector2(rand_range(220.0, 250.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)
	
	add_child(fish)

func _on_Mafi_collected():
	score += 1
	$HUD.update_score(score)
	$FishCoughtSound.pitch_scale = rand_range(0.9, 1.2)
	#print(str($FishCoughtSound.pitch_scale))
	$FishCoughtSound.play()
