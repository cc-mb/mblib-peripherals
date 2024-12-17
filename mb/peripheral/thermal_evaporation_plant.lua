-- Imports
local Flow = require "mb.units.flow"
local Length = require "mb.units.length"
local Temperature = require "mb.units.temperature"
local Volume = require "mb.units.volume"

--- Thermal evaporation plant.
---@class ThermalEvaporationPlant
---@field private _controller table Wrapped thermal evaporation valve.
local ThermalEvaporationPlant = {}
ThermalEvaporationPlant.__index = ThermalEvaporationPlant

--- Thermal evaporation plant creation parameters.
---@class ThermalEvaporationPlantCreationParameters
---@field name string? Wrapped thermal evaporation plant controller name. Passing nil results in any thermal evaporation plant.

--- Constructor
---@param params ThermalEvaporationPlantCreationParameters
function ThermalEvaporationPlant.new(params)
  local self = setmetatable({}, ThermalEvaporationPlant)

  self._controller = peripheral.wrap(params.name or "thermalEvaporationValve")
  if self._controller == nil or not peripheral.hasType(self._controller, "thermalEvaporationValve") then
    error("invalid controller: " .. params.name, 2)
  end

  if not self._controller.isFormed() then
    error("thermal evaporation plant is not formed", 2)
  end

  return self
end

--- Get length.
---@return Quantity
function ThermalEvaporationPlant:length()
  return Length:quantity(self._controller.getLength(), Length["m"])
end

--- Get width.
---@return Quantity
function ThermalEvaporationPlant:width()
  return Length:quantity(self._controller.getWidth(), Length["m"])
end

--- Get height.
---@return Quantity
function ThermalEvaporationPlant:height()
  return Length:quantity(self._controller.getHeight(), Length["m"])
end

--- Get input capacity.
---@return Quantity
function ThermalEvaporationPlant:input_capacity()
  return Volume:quantity(self._controller.getInputCapacity(), Volume["mB"])
end

--- Get input.
---@return Quantity, string
function ThermalEvaporationPlant:input()
  local content = self._controller.getInput()
  return Volume:quantity(content.amount, Volume["mB"]), content.name
end

--- Get output capacity.
---@return Quantity
function ThermalEvaporationPlant:output_capacity()
  return Volume:quantity(self._controller.getOutputCapacity(), Volume["mB"])
end

--- Get output.
---@return Quantity, string
function ThermalEvaporationPlant:output()
  local content = self._controller.getOutput()
  return Volume:quantity(content.amount, Volume["mB"]), content.name
end

--- Get temperature.
---@return Quantity
function ThermalEvaporationPlant:temperature()
  return Temperature:quantity(self._controller.getTemperature(), Temperature["K"])
end

--- Get production rate.
---@return Quantity
function ThermalEvaporationPlant:production_rate()
  return Flow:quantity(self._controller.getProductionAmount(), Flow["mB/t"])
end
