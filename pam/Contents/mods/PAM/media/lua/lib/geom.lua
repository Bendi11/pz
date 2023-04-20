local geom = {}

local sqrt = math.sqrt

---Calculate the distance from `p1` to `p2`
---@param p1 Point
---@param p2 Point
---@return number
function geom.distance(p1, p2)
    return sqrt( (p2[1] - p1[1])^2 + (p2[2] - p1[2])^2)
end

---Check if the given point is on the given line segment
---@param line Line
---@param point Point
---@return boolean
function geom.point_on_line(line, point)
    local dist = geom.distance(point, line[1]) + geom.distance(point, line[2])
    return dist == geom.distance(line[1], line[2])
end

return geom
