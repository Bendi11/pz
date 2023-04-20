require 'ISBaseObject'

local Shape = require 'lib/geom/Shape'

---@class PAMSheetStock: ISBaseObject
---@field stock Shape
local PAMSheetStock = ISBaseObject:derive('PAMSheetStock')

---Create a new piece of rectangular sheet stock using the given size
---@param width number width of the sheet in inches
---@param height number height of the sheet in inches
---@return PAMSheetStock
function PAMSheetStock:new(width, height)
    ---@type PAMSheetStock
    local o = ISBaseObject.new(self)

    o.stock = Shape.new_rect(width, height)

    return o
end
