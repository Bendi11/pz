require 'ISUI.ISCollapsableWindow'

---@class PAMMillControlWindow: ISCollapsableWindow
local PAMMillControlWindow = ISCollapsableWindow:derive("PAMMillControlWindow")

---Name of the window used for registering window in ISLayoutManager
---@type string
PAMMillControlWindow.WINDOW_NAME = 'pam-mill-ctrl'
---Static instance of a PAMMillControlWindow
---@type PAMMillControlWindow|nil
PAMMillControlWindow.instance = nil

---Create a new MillControlWindow from (x, y) position and (width, height) size
---@param x number
---@param y number
---@param width number
---@param height number
---@return PAMMillControlWindow
function PAMMillControlWindow:new(x, y, width, height)
    ---@type PAMMillControlWindow
    local o = ISCollapsableWindow.new(self, x, y, width, height)
    PAMMillControlWindow.instance = o
    return o
end

function PAMMillControlWindow:createChildren()
    ISCollapsableWindow.createChildren(self)
end

---Get the active `MillControlWindow` instance, or instantiate it
---@return PAMMillControlWindow
function PAMMillControlWindow.getInstance()
    if not PAMMillControlWindow.instance then
        PAMMillControlWindow.instance = PAMMillControlWindow:new(100, 100, 600, 800)
        ISLayoutManager.RegisterWindow(
            PAMMillControlWindow.WINDOW_NAME,
            PAMMillControlWindow,
            PAMMillControlWindow.instance
        )
    end

    return PAMMillControlWindow.instance
end
