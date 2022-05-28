-- https://github.com/jacobalbano/BitCave/blob/master/src/tilelighting/TileLighting.as

import "CoreLibs/object"

class('Lighting').extends()

local screenW <const> = 400
local screenH <const> = 240

function Lighting:init(imageTable)
    Lighting.super.init(self)

    self.ambientLevel = 0
    self.autoUpdate = false
    self.padding = 2

    self.tilemap = playdate.graphics.tilemap.new()
    self.tilemap:setImageTable(imageTable)

    
end