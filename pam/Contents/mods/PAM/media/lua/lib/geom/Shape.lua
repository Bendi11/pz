---@alias LinesIterator fun(): Line|nil
---@alias Point { [1]: number, [2]: number }
---@alias Line { [1]: Point, [2]: Point }

---@class Shape: Point[]
local Shape = {}

---@param list Point[] with length >= 3
---@return Shape
function Shape:new(list)
    ---@type Shape
    local o = {}
    self.__index = self
    setmetatable(o, self)

    o = list

    return o
end

---Create a new square Shape from a side length
---@param len number
---@return Shape
function Shape.new_square(len)
    len = len / 2
    local points = {
        {-len, -len},
        {-len, len },
        {len,  len },
        {len,  -len},
    }

    return Shape:new(points)
end

---Get the point in the list after this point
---@param idx number
---@return number
function Shape:next_point(idx) return (idx + 1) % #self end

---Get an iterator over all lines that make up the perimeter of this shape
---@return LinesIterator
function Shape:lines()
    local i = 0
    return function()
        i = i + 1
        if i <= #self then return {self[i], self:next_point(i)} end
    end
end

---Get the total area of this shape
---@return number
function Shape:area()
    local area = 0
    for line in self:lines() do
        area = area + line[1][1] * line[2][2]
        area = area - line[1][2] * line[2][1]
    end

    return math.abs(area) / 2
end

return Shape
