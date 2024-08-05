extends CanvasLayer

var current_score = PlayerVariables.score

func _ready():
	updateScore(0)
	
	# Sets the text for the lives to the default starting amount (for example 3)
	$Lives/LivesText.text = str(PlayerVariables.get_lives())
	PlayerVariables.connect("heart_depleted", self, "changeHeartState")
	
func updateScore(score):
	$TextDisplay/TextHolder/ScoreText.text = "Score: %s" % (str(score))
	
func _on_Update_timeout():
	if(PlayerVariables.score > current_score):
		updateScore(PlayerVariables.score)
		current_score = PlayerVariables.score
			
# This method changes the heart animation
# heartnum stands for the first (1), second (2) and third (3) heart
# active stands for whether the heart should be full or depeleted, depending on the choice the corresponding animation is played
func changeHeartState(heartnum, active):
	$HeartDisplay.changeHeart(heartnum, active)
	
