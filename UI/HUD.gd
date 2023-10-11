extends CanvasLayer

var current_score = 0

func _ready():
	updateScore(0)
	# Sets the text for the lives to the default starting amount (for example 3)
	$Lives/LivesText.text = str(PlayerVariables.get_lives())

	var playernode = get_tree().get_root().find_node("Player", true, false)
	playernode.connect("heart_depleted", self, "changeHeartState")

func updateScore(score):
	$TextDisplay/TextHolder/ScoreText.text = "Score: %s" % (str(score))
	
func _on_Update_timeout():
	if($"/root/Game/View/Player".score > current_score):
		updateScore($"/root/Game/View/Player".score)
		current_score = $"/root/Game/View/Player".score
			
# This method changes the heart animation
# heartnum stands for the first (1), second (2) and third (3) heart
# active stands for whether the heart should be full or depeleted, depending on the choice the corresponding animation is played
func changeHeartState(heartnum, active):
	$HeartDisplay.changeHeart(heartnum, active)
	
