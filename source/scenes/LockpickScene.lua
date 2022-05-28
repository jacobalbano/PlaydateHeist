import 'libraries/noble/utilities/Utilities'

LockpickScene = {}
class("LockpickScene").extends(NobleScene)

LockpickScene.baseColor = Graphics.kColorBlack

local clickTolerance <const> = 5
local clicks <const> = { }
local clickSounds <const> = {}
local clickIndex = 0
local synth
local freq = 2

function nextPin()
    clickIndex = clickIndex + 1
    print('pin at ' .. clicks[clickIndex] .. ' degrees')
end

function playRandomClick()
    local clickIdx = math.random(#clickSounds)
    if (clickSounds[clickIdx]:isPlaying()) then
        clickIdx = math.ringInt(clickIdx, 1, #clickSounds)
    end

    clickSounds[clickIdx]:play()
end

function LockpickScene:init()
	LockpickScene.super.init(self)

    for i = 1, 4 do clicks[i] = math.random(360) end
    nextPin()

    synth = playdate.sound.synth.new(playdate.sound.kWaveNoise)

    local audioPath = 'assets/audio/lockpickclicks/'
    for i, value in ipairs(playdate.file.listFiles(audioPath)) do
        clickSounds[i] = playdate.sound.sampleplayer.new(audioPath .. value)
    end

	LockpickScene.inputHandler = {
		cranked = function(change, acceleratedChange)
            if (clickIndex >= #clicks) then return end

            local currentPos = playdate.getCrankPosition()
            local dist = math.abs(math.angleDiff(currentPos, clicks[clickIndex]))
            if (dist < 30) then
                local vol =  math.scale(dist, 0, 30, .05, 0)
                synth:playNote(freq, vol, 1 / 15)
                if (dist < 1 and math.abs(change) < 1) then
                    playRandomClick()
                    nextPin()
                    synth:noteOff()
                end
            end
		end,

		AButtonDown = function() end,
		AButtonUp = function() end,
		BButtonDown = function() end,
		BButtonUp = function() end,
	}

end

function LockpickScene:start()
	LockpickScene.super.start(self)
end

function LockpickScene:enter()
	LockpickScene.super.enter(self)
end

function LockpickScene:update()
	LockpickScene.super.update(self)
end