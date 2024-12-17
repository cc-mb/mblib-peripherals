-- Imports
local Power = require "mb.units.power"
local Temperature = require "mb.units.temperature"

--- Resistive heater.
---@class ResistiveHeater
---@field private _controller table Wrapped Resistive heater.
local ResistiveHeater = {}
ResistiveHeater.__index = ResistiveHeater

--- Resistive heater creation parameters.
---@class ResistiveHeaterCreationParameters
---@field name string? Wrapped resistive heater name. Passing nil results in any resistive heater.

--- Constructor
---@param params ResistiveHeaterCreationParameters
function ResistiveHeater.new(params)
  local self = setmetatable({}, ResistiveHeater)

  self._controller = peripheral.wrap(params.name or "resistiveHeater")
  if self._controller == nil or not peripheral.hasType(self._controller, "resistiveHeater") then
    error("invalid controller: " .. params.name, 2)
  end

  return self
end

--- Get energy consumption.
---@return Quantity
function ResistiveHeater:energy_consumption()
  return Power:quantity(self._controller.getEnergyUsage(), Power["J/t"])
end

--- Get temperature.
---@return Quantity
function ResistiveHeater:temperature()
  return Temperature:quantity(self._controller.getTemperature(), Temperature["K"])
end

--- Set energy consumption.
---@param value Quantity New energy consumption.
function ResistiveHeater:set_energy_consumption(value)
  self._controller.setEnergyUsage(value:get_value({unit = "J/t", precision = 1}))
end
