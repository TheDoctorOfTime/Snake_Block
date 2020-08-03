extends Node

var level = 1

func getLevel():
	return level

func getSkin():
	return 1
	
func onGameReady():
	print("Event onGameReady")

func onLevelComplete(isLevelSuccess, coins=0):
	print("Event onLevelComplete:", isLevelSuccess)
	if isLevelSuccess:
		level+=1
