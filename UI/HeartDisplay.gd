extends Node2D
		
func changeHeart(heart, active):
	
	if !active:
		if heart == 2:
			$HealthMain/Heart1/AnimationPlayer.play("heart_unfold")
		elif heart == 1:
			$HealthMain/Heart2/AnimationPlayer.play("heart_unfold")
		elif heart == 0:
			$HealthMain/Heart3/AnimationPlayer.play("heart_unfold")	

#This method is only called by the animationplayer
func changeAnimationToHeartLoss():
	pass
