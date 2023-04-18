require 'Map.SGlobalObject'

---@class SMillGlobalObject: SGlobalObject
---@field workDimensions { width: number, height: number }
---@field loadedStock 
local SMillGlobalObject = SGlobalObject:derive('SMillGlobalObject')

---@return SMillGlobalObject
function SMillGlobalObject:new(luaSystem, gObject)
    return SGlobalObject.new(self, luaSystem, gObject)
end

---comment
---@param modData { [string]: any }
function SMillGlobalObject:fromModData(modData)
    self.workDimensions = modData['workDimensions']
end
