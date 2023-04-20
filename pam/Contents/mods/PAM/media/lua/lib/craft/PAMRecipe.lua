require 'ISBaseObject'

---@class RecipeItem
---@field validate fun(InventoryItem): boolean
---@field icon string
---@field name string
---@field count integer

---@class PAMRecipe
---@field name string
---@field slots RecipeItem[]
---@field results RecipeItem[]
local PAMRecipe = {}

---Create a new recipe from a list of used items 
---@param name string User-facing name of the recipe
---@param items RecipeItem[]
---@param results RecipeItem[]
---@return PAMRecipe
function PAMRecipe:new(name, items, results)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.slots = items
    o.name = name
    o.results = results

    return o
end
