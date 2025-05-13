extends Label

func update_score():
	self.text = "Score: "+ str(int(GlobalVariables.score))
