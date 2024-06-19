extends Node2D

@export var bug_scene : PackedScene
var score 


func game_over():
	$BugTimer.stop()
	$ScoreTimer2.stop()
	$HUD.show_game_over()
	
func  new_game():
	$StartTimer.start()	
	$player.start_pos($StartPosition.position)
	score = 0 
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("bugs", "queue_free")
	
func _on_score_timer_2_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$BugTimer.start()
	$ScoreTimer2.start()

func _on_bug_timer_timeout():
	var bug = bug_scene.instantiate()
	var bug_loction = $BugPath/BugPathLocation
	bug_loction.progress_ratio = randf()
	
	
	var direction = bug_loction.rotation + PI / 2
	bug.position = bug_loction.position
	direction += randf_range(-PI /4, PI /4)
	bug.rotation = direction
	
	var velocity =Vector2(randf_range(150.0, 250.0), 0.0)
	bug.linear_velocity = velocity.rotated(direction)
	add_child(bug)
