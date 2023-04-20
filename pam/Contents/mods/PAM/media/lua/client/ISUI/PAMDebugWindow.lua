require 'ISUI/ISCollapsableWindow'

local PAMDebugSheetPanel = require 'ISUI/PAMDebugSheetPanel'
local StockViewWindow = require 'ISUI/StockViewWindow'

---@class PAMDebugWindow: ISCollapsableWindow
---@field mainpanel ISTabPanel
---@field debugSheets PAMDebugSheetPanel
PAMDebugWindow = ISCollapsableWindow:derive("PAMDebugWindow")

---Name of the window used for registering window in ISLayoutManager
local WINDOW_NAME = 'pam-dbg'
local WINDOW_TITLE = 'PAM Debug'

---Static instance of a PAMMillControlWindow
---@type PAMDebugWindow|nil
PAMDebugWindow.instance = nil

---Create a new MillControlWindow from (x, y) position and (width, height) size
---@param x number
---@param y number
---@param width number
---@param height number
---@return PAMDebugWindow
function PAMDebugWindow:new(x, y, width, height)
    ---@type PAMDebugWindow
    local o = ISCollapsableWindow.new(self, x, y, width, height)
    o.title = WINDOW_TITLE
    o:setResizable(false)

    PAMDebugWindow.instance = o
    return o
end

function PAMDebugWindow:createChildren()
    ISCollapsableWindow.createChildren(self)

    self.mainpanel = ISTabPanel:new(0, self:titleBarHeight(), self.width, self.height - self:titleBarHeight())
    self.mainpanel:initialise()
    self.mainpanel.equalTabWidth = false
    self:addChild(self.mainpanel)

    self.debugSheets = PAMDebugSheetPanel:new(0, 8, self.width, self.height - 8)
    self.debugSheets:initialise()
    self.mainpanel:addView(PAMDebugSheetPanel.VIEW_NAME, self.debugSheets)

    self.mainpanel:activateView(PAMDebugSheetPanel.VIEW_NAME)
end

---Get the active `MillControlWindow` instance, or instantiate it
---@return PAMDebugWindow
function PAMDebugWindow.getInstance()
    if not PAMDebugWindow.instance then
        PAMDebugWindow.instance = PAMDebugWindow:new(100, 100, 640, 480)
        ISLayoutManager.RegisterWindow(
            WINDOW_NAME,
            PAMDebugWindow,
            PAMDebugWindow.instance
        )
    end

    return PAMDebugWindow.instance
end

function PAMDebugWindow:close()
    self:removeFromUIManager()
end

---@param items InventoryItem[]
function PAMDebugWindow.onFillInventoryObjectContextMenu(player, ctx, items)
    for i=1,#items do
        if items[i]:getName() == 'AluminumSheetStock' then
            ctx:addOption('View Stock', nil, function() StockViewWindow.open(items[i]) end)
        end
    end
    ctx:addOption('Show Debug Menu', nil, function() PAMDebugWindow.getInstance():addToUIManager() end)
end

Events.OnFillInventoryObjectContextMenu.Add(PAMDebugWindow.onFillInventoryObjectContextMenu)
