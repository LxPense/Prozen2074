extends Pickup
class_name BulletChange

export var choice : String = "W"

# The default bulletStrategy is the NormalShot
var bulletStrategyChoice : BaseBulletStrategy	= NormalShotBulletStrategy.new()

func _on_VisibilityNotifier2D_screen_entered():
	updateText(choice)

func _on_VisibilityNotifier2D_screen_exited():
	pass # Replace with function body.

# A bulletStrategy is picked depending on the string-input
func setBulletStrategyType(var choice: String):
	if(choice == "F"):
		bulletStrategyChoice = FastShotBulletStrategy.new()
	elif(choice == "N"):
		bulletStrategyChoice = NormalShotBulletStrategy.new()
	elif(choice == "W"):
		bulletStrategyChoice = WideShotBulletStrategy.new()
	else:
		bulletStrategyChoice = NormalShotBulletStrategy.new()
		
	PlayerVariables.setBulletStrategy(bulletStrategyChoice)

# Is called once to set the text on the sprite
func updateText(var choice: String):
	if(choice == "F"):
		$Sprite/TextureRect.text = "F"
	elif(choice == "N"):
		$Sprite/TextureRect.text = "N"
	elif(choice == "W"):
		$Sprite/TextureRect.text = "W"
	else:
		$Sprite/TextureRect.text = "N"
		
func _on_Area2D_area_entered(area):
	setBulletStrategyType(choice)
	self.queue_free()
