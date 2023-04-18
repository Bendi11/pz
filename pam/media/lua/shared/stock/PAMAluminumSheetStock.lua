require 'ISBaseObject'

---@class PAMAluminumSheetStock: ISBaseObject
---@field geometry
local PAMAluminumSheetStock = ISBaseObject:derive('PAMAluminumSheetStock')

---@return PAMAluminumSheetStock
function PAMAluminumSheetStock:new()
    local o = ISBaseObject.new(self)

    return o
end
