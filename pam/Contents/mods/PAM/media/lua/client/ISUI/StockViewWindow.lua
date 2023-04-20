require 'ISUI/ISCollapsableWindow'

local ShapeDisplay = require 'ISUI/ShapeDisplay'

---@class StockViewWindow: ISCollapsableWindow
---@field shape ShapeDisplay
local StockViewWindow = ISCollapsableWindow:derive('StockViewWindow')

StockViewWindow.instance = nil
local WINDOW_NAME = 'pam-stock-view'

---@param x integer
---@param y integer
---@param width integer
---@param height integer
---@return StockViewWindow
function StockViewWindow:new(x, y, width, height)
    ---@type StockViewWindow
    local o = ISCollapsableWindow.new(self, x, y, width, height)

    o.shape = ShapeDisplay:new(0, 0, self.width, self.height)
    o.title = 'Stock Viewer'
    o:setResizable(false)

    StockViewWindow.instance = o

    return o
end

---@return StockViewWindow
function StockViewWindow.getInstance()
    if not StockViewWindow.instance then
        StockViewWindow.instance = StockViewWindow:new(100, 100, 640, 480)
        ISLayoutManager.RegisterWindow(
            WINDOW_NAME,
            StockViewWindow,
            StockViewWindow.instance
        )
    end

    return StockViewWindow.instance
end

function StockViewWindow:createChildren()
    self.shape = ShapeDisplay:new(0, 0, self.width, self.height)
    self.shape:initialise()
    self:addChild(self.shape)
end

---Open a new stock viewer for the given sheet stock
---@param item InventoryItem
function StockViewWindow.open(item)
    local window = StockViewWindow.getInstance()

    local modData = item:getModData()
    if not (modData or modData['PAM']) then return end
    local pam = modData['PAM'] --[[@as PAMSheetStock]]

    window.shape:setShape(pam.stock)
    window:addToUIManager()
end

function StockViewWindow:close()
    self:removeFromUIManager()
end
