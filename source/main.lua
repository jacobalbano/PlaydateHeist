import 'libraries/noble/Noble'
import 'scenes/MainMenuScene'
import 'scenes/LockpickScene'

import 'libraries/thuglife/Math'

playdate.setCrankSoundsDisabled(true)

Noble.Settings.setup({
	Difficulty = "Medium"
})

Noble.GameData.setup({
	Score = 0
})

Noble.showFPS = true

Noble.new(LockpickScene, 1.5, Noble.TransitionType.CROSS_DISSOLVE, true)