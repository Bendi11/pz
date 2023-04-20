require 'ISUI/ISPanelJoypad'

local ShapeDisplay = require 'ISUI/ShapeDisplay'
local Shape = require 'lib/geom/Shape'

---@class PAMDebugSheetPanel: ISPanelJoypad
---@field shapeDisplay ShapeDisplay
local PAMDebugSheetPanel = ISPanelJoypad:derive('PAMDebugSheetPanel')

---Name to use when referencing in an ISTabPanel
---@type string
PAMDebugSheetPanel.VIEW_NAME = 'Sheet Geometry'

---@return PAMDebugSheetPanel
function PAMDebugSheetPanel:new(x, y, width, height)
    return ISPanelJoypad.new(self, x, y, width, height)
end

function PAMDebugSheetPanel:createChildren()
    self.shapeDisplay = ShapeDisplay:new(0, 0, self.width, self.height, Shape.new_rect(10, 5))
    self.shapeDisplay:initialise()
    self:addChild(self.shapeDisplay)
end

return PAMDebugSheetPanel
