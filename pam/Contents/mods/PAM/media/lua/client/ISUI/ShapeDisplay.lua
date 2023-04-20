require 'ISUI/ISUIElement'

local Shape = require 'lib/geom/Shape'

---@class ShapeDisplay: ISUIElement
---@field shape Shape
local ShapeDisplay = ISUIElement:derive('ShapeDisplay')

---Create a new display area for shapes
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@return ShapeDisplay
function ShapeDisplay:new(x, y, width, height)
    local o = ISUIElement.new(self, x, y, width, height)

    return o
end

---Initialise state for this shape display, calculating the maximum extent of the shape if it is not given
---@param shape Shape
---@param extends AABB
function ShapeDisplay:initialise(shape)
    self.shape = shape
end
