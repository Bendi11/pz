
---@class Point
---@field x number
---@field y number
local Point = {}

---Create a new point from x and y coordinates
---@param x number
---@param y number
---@return Point
function Point:new(x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.x = x
    o.y = y

    return o
end

return Point
