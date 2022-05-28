import 'libraries/noble/Noble'
import 'scenes/LockpickScene'

MainMenuScene = {}
class("MainMenuScene").extends(NobleScene)

MainMenuScene.baseColor = Graphics.kColorBlack

local menu
local sequence

function MainMenuScene:init()
	MainMenuScene.super.init(self)

	menu = Noble.Menu.new(false, Noble.Text.ALIGN_CENTER, false, Graphics.kColorWhite, 4,6,0, Noble.Text.FONT_SMALL)

    menu:addItem("Play Game", function()
        Noble.transition(LockpickScene)
    end)

    menu:addItem("Options", function()
        --Noble.transition(OptionsScreen)
    end)

    menu:addItem("Credits", function()
        --Noble.transition(CreditsScreen)
    end)

	local crankTick = 0

	MainMenuScene.inputHandler = {
		upButtonDown = function()
			menu:selectPrevious()
		end,
		downButtonDown = function()
			menu:selectNext()
		end,
		cranked = function(change, acceleratedChange)
			crankTick = crankTick + change
			if (crankTick > 30) then
				crankTick = 0
				menu:selectNext()
			elseif (crankTick < -30) then
				crankTick = 0
				menu:selectPrevious()
			end
		end,
		AButtonDown = function()
			menu:click()
		end
	}

end

function MainMenuScene:start()
	MainMenuScene.super.start(self)

	menu:activate()

end

function MainMenuScene:enter()
	MainMenuScene.super.enter(self)
	sequence = Sequence.new():from(0):to(100, 1.5, Ease.outBounce)
	sequence:start();
end

function MainMenuScene:update()
	MainMenuScene.super.update(self)

	Graphics.setColor(Graphics.kColorBlack)
	Graphics.fillRoundRect(15, 3.75, 120, 80, 15)
	menu:draw(30, 30)
end