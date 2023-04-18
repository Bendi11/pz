require 'Map.SGlobalObject'

---@class CMillGlobalObject: SGlobalObject
---@field workDimensions { width: number, height: number }
---@field loadedStock 
local CMillGlobalObject = SGlobalObject:derive('CMillGlobalObject')

---@return CMillGlobalObject
function CMillGlobalObject:new(luaSystem, gObject)
    return SGlobalObject.new(self, luaSystem, gObject)
end

---comment
---@param modData { [string]: any }
function CMillGlobalObject:fromModData(modData)
    self.workDimensions = modData['workDimensions']
end
