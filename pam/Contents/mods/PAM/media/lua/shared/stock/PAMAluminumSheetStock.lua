--[[require 'ISBaseObject'

local geom = require 'lib.geom'

---@class PAMAluminumSheetStock: ISBaseObject
---@field geometry Shape
local PAMAluminumSheetStock = ISBaseObject:derive('PAMAluminumSheetStock')

---@return PAMAluminumSheetStock
function PAMAluminumSheetStock:new()
    ---@type PAMAluminumSheetStock
    local o = ISBaseObject.new(self)
    setmetatable(o, self)
    self.__index = self

    o.geometry = geom.Shape.new_square(1)

    return o
end]]
