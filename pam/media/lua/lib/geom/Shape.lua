local Point = require 'lib.geom.Point'

---@alias LinesIterator (fun(Shape, number): Point|nil, Point|nil)

---@class Shape
---@field points Point[]
local Shape = {}

---@param list Point[] with length >= 3
---@return Shape
function Shape:new(list)
    ---@type Shape
    local o = {}
    self.__index = self
    setmetatable(o, self)

    o.points = list

    return o
end

---Create a new square Shape from a side length
---@param len number
---@return Shape
function Shape.new_square(len)
    len = len / 2
    local points = {
        Point:new(-len, -len),
        Point:new(-len, len),
        Point:new(len, len),
        Point:new(len, -len),
    }

    return Shape:new(points)
end

---Get the point in the list after this point
---@param idx number
---@return Point
function Shape:next_point(idx)
    if idx == #self.points then
        idx = 0
    end
    return self.points[idx + 1]
end

---Iterator function for iterating over the lines in a shape
---@param state { shape: Shape, i: number }
---@return Point|nil, Point|nil
local function line_iter(state)
    state.i = state.i + 1

    if i ~= #state.shape.points then
        local p1 = state.shape.points[state.i]
        local p2 = state.shape:next_point(state.i)

        return p1, p2
    end
end

---Get an iterator over all lines that make up the perimeter of this shape
---@return LinesIterator, table
function Shape:lines()
    local state = { shape = self, i = 0 }
    return line_iter, state
end

---Get the total area of this shape
---@return number
function Shape:area()
    local area = 0
    for i = 1, #self.points do
        local j = self:next_point(i)
        area = area + self.points[i].x * j.y
        area = area - self.points[i].y * j.x
    end

    return math.abs(area) / 2
end

return Shape
