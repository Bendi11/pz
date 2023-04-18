require 'ISBaseObject'

local Point = require 'lib.geom.Point'

---@class Shape
---@field points Point[]


local Shape = {}

---@param p1 Point
---@param p2 Point
---@param p3 Point
---@return Shape
function Shape:triangle(p1, p2, p3)
    ---@type Shape
    local o = ISBaseObject.new(self)

    o.points = {}

    return o
end

return Shape
