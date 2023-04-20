require 'ISUI/ISUIElement'

local Shape = require 'lib/geom/Shape'
local geom = require 'lib/geom'

---@class ShapeDisplay: ISUIElement
---@field shape Shape
---@field pxPerIn number
local ShapeDisplay = ISUIElement:derive('ShapeDisplay')

---Create a new display area for shapes
---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@param shape Shape
---@param aabb AABB|nil
---@return ShapeDisplay
function ShapeDisplay:new(x, y, width, height, shape, aabb)
    local o = ISUIElement.new(self, x, y, width, height)

    o.shape = shape

    local size = math.sqrt(self.width^2 + self.height^2)

    aabb = aabb or shape:aabb()

    o.pxPerIn = size / geom.distance(aabb[1], aabb[2])


    return o
end

function ShapeDisplay:render()
    local w = self.width / 2
    local h = self.height / 2
    for line in self.shape:lines() do
        self:drawLine2(
            line[1][1] * self.pxPerIn + w, line[1][2] * self.pxPerIn + h,
            line[2][1] * self.pxPerIn + w, line[2][2] * self.pxPerIn + h,
            1, 1, 1, 1
        )
    end

    ISUIElement.render(self)
end
