local geom = require 'lib/geom'

---@alias LinesIterator fun(): Line|nil
---@class Point: { [1]: number, [2]: number }
---@alias Line { [1]: Point, [2]: Point }
---@alias AABB { [1]: Point, [2]: Point }

---@class Shape: Point[]
local Shape = {}

---@param list Point[] with length >= 3
---@return Shape
function Shape:new(list)
    ---@type Shape
    local o = list
    self.__index = self
    setmetatable(o, self)

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

---Create a new rectangle Shape from a width and height
---@param width number
---@param height number
---@return Shape
function Shape.new_rect(width, height)
    width = width / 2
    height = height / 2

    local points = {
        {-width, -height},
        {width, -height},
        {width, height},
        {-width, height}
    }

    return Shape:new(points)
end

---Get the point in the list after this point
---@param idx number
---@return number
function Shape:next_point(idx)
    if (idx + 1) > #self then return 1 else return idx + 1 end
end
function Shape:prev_point(idx) if idx == 1 then return #self else return idx - 1 end end

---Get an iterator over all lines that make up the perimeter of this shape
---@return LinesIterator
function Shape:lines()
    local i = 0
    return function()
        i = i + 1
        if i <= #self then return {self[i], self[self:next_point(i)]} end
    end
end

---Get an iterator over the points in this shape
---@return fun(): Point|nil
function Shape:points()
    local i = 0
    return function()
        i = i + 1
        if i <= #self then return self[i] end
    end
end

---Get a line array by first point index
---@param idx integer
---@return Line|nil
function Shape:line_by_idx(idx)
    if idx <= #self then return { self[idx], self:next_point(idx) } end
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

---Get the index of a given point
---@param point Point
---@return integer
function Shape:point_idx(point)
    for i=1, #self do
        if self[i] == point then return i end
    end
end

---Divide the shape along a given `cut` line
---@param cut Shape
---@return Shape, Shape|nil
function Shape:divide(cut)
    local point_on_line, insert = geom.point_on_line, table.insert

    local first_divider, second_divider

    for line in self:lines() do
        if point_on_line(line, cut[1]) then
            first_divider = line
        end
        if point_on_line(line, cut[#cut]) then
            second_divider = line
        end
    end

    if not first_divider or not second_divider then return self, nil end

    local function divided(first, next)
        local idx = self:point_idx(first_divider[first])
        local i = idx
        local point

        local part = {}
        while true do
            point = self[i]

            insert(part, point)
            if point == second_divider[3 - first] then
                break
            end

            i = next(self, i)
            if i == idx then return self, nil end
        end

        for j = #cut,1,-1 do
            insert(part, cut[j])
        end

        return Shape:new(part)

    end

    if first_divider == second_divider then
        local original = divided(1, self.prev_point)

        local part = {}
        for p in cut:points() do insert(part, {p[1], p[2]}) end

        return original, Shape:new(part)
    end

    return divided(1, self.prev_point), divided(2, self.next_point)
end

---Get an axis-aligned bounding box for this shape
---@return AABB
function Shape:aabb()
    local min_pt = {self[1][1], self[1][2]}
    local max_pt = {self[1][1], self[1][2]}
    
    local min, max = math.min, math.max
    for point in self:points() do
        min_pt[1] = min(min_pt[1], point[1])
        min_pt[2] = min(min_pt[2], point[2])

        max_pt[1] = max(max_pt[2], point[1])
        max_pt[2] = max(max_pt[2], point[2])
    end

    return { min_pt, max_pt }
end

return Shape
