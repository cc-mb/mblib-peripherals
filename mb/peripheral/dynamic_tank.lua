-- Imports
local Table = require "mb.algorithm.table"

local Length = require "mb.units.length"
local Volume = require "mb.units.volume"

--- Dynamic tank.
---@class DynamicTank
---@field private _controller table Wrapped dynamic valve.
---@field private _type string Tank type. Either "fluid" or "gas".
local DynamicTank = {}
DynamicTank.__index = DynamicTank

--- Dynamic tank creation parameters.
---@class DynamicTankCreationParameters
---@field name string? Wrapped dynamic tank controller name. Passing nil results in any dynamic tank.
---@field type string? Tank type. Either "fluid" or "gas". Defaults to "fluid".

--- Constructor
---@param params DynamicTankCreationParameters
function DynamicTank.new(params)
  local self = setmetatable({}, DynamicTank)

  self._controller = peripheral.wrap(params.name or "dynamicValve")
  if self._controller == nil or not peripheral.hasType(self._controller, "redstoneIntegrator") then
    error("invalid controller: " .. params.name, 2)
  end

  if not self._controller.isFormed() then
    error("dynamic tank is not formed", 2)
  end

  params.type = params.type or "fluid"
  if not Table.contains_value({"fluid", "gas"}, params.type) then
    error("invalid type: " .. params.type, 2)
  end

  self._type = params.type

  return self
end

--- Get length.
---@return Quantity
function DynamicTank:length()
  return Length:quantity(self._controller.getLength(), Length["m"])
end

--- Get width.
---@return Quantity
function DynamicTank:width()
  return Length:quantity(self._controller.getWidth(), Length["m"])
end

--- Get height.
---@return Quantity
function DynamicTank:height()
  return Length:quantity(self._controller.getHeight(), Length["m"])
end

--- Get capacity.
---@return Quantity
function DynamicTank:capacity()
  local value = 0
  if self._type == "fluid" then
    value = self._controller.getTankCapacity()
  elseif self._type == "gas" then
    value = self._controller.getChemicalTankCapacity()
  end

  return Volume:quantity(value, Volume["mB"])
end

--- Get content.
---@return Quantity, string
function DynamicTank:content()
  local stored = self._controller.getStored()
  return Volume:quantity(stored.amount, Volume["mB"]), stored.name
end
