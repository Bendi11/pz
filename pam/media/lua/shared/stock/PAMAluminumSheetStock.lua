require 'ISBaseObject'

local json = require 'lib.json'
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
end

local shape = geom.Shape.new_square(5)

for p1, p2 in shape:lines() do
    print(json.encode(p1) .. ' -> ' .. json.encode(p2))
end

print(shape:area())
