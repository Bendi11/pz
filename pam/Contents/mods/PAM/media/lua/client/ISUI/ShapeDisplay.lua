require 'ISUI/ISUIElement'

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
---@return ShapeDisplay
function ShapeDisplay:new(x, y, width, height)
    return ISUIElement.new(self, x, y, width, height)
end

---Set the currently viewed shape, and bounding box that serves to scale the shape to fit the window size
---@param shape Shape|nil
---@param aabb AABB|nil
function ShapeDisplay:setShape(shape, aabb)
    aabb = aabb or (shape and shape:aabb()) or nil
    local size = math.sqrt(self.width^2 + self.height^2)
    o.pxPerIn = (aabb and size / geom.distance(aabb[1], aabb[2])) or nil
end

function ShapeDisplay:render()
    if self.shape then
        local w = self.width / 2
        local h = self.height / 2
        for line in self.shape:lines() do
            self:drawLine2(
                line[1][1] * self.pxPerIn + w, line[1][2] * self.pxPerIn + h,
                line[2][1] * self.pxPerIn + w, line[2][2] * self.pxPerIn + h,
                1, 1, 1, 1
            )
        end
    end

    ISUIElement.render(self)
end

return ShapeDisplay
