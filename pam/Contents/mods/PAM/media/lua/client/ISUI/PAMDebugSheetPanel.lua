require 'ISUI.ISPanelJoypad'

---@class PAMDebugSheetPanel: ISPanelJoypad
---@field dbgText ISTextBox
local PAMDebugSheetPanel = ISPanelJoypad:derive('PAMDebugSheetPanel')

---Name to use when referencing in an ISTabPanel
---@type string
PAMDebugSheetPanel.VIEW_NAME = 'Sheet Geometry'

---@return PAMDebugSheetPanel
function PAMDebugSheetPanel:new(x, y, width, height)
    return ISPanelJoypad.new(self, x, y, width, height)
end

function PAMDebugSheetPanel:createChildren()
    
    self.dbgText = ISTextBox:new(0, 0, self:getWidth(), self:getHeight(), 'Debug text')
end

return PAMDebugSheetPanel
