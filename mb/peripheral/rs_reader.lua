-- Imports
local Table = require "mb.algorithm.table"

--- Redstone wrapper.
---@class RsReader
---@field private _controller table Wrapped redstone controller.
---@field private _side string Side of the redstone controller to use.
---@field private _inverted boolean If set redstone signal will be inverted.
local RsReader = {}
RsReader.__index = RsReader

--- Redstone reader creation parameters.
---@class RsReaderCreationParameters
---@field name string? Wrapped redstone controller name. Passing nil results in the computer being used.
---@field side string Side of the redstone controller to use.
---@field inverted boolean? If set, signals will be inverted.

--- Constructor
---@param params RsReaderCreationParameters
function RsReader.new(params)
  local self = setmetatable({}, RsReader)

  if params.name then
    self._controller = peripheral.wrap(params.name)
    if self._controller == nil or not peripheral.hasType(self._controller, "redstoneIntegrator") then
      error("invalid controller: " .. params.name, 2)
    end
  else
    self._controller = redstone
  end

  if not Table.contains_value(redstone.getSides(), params.side) then
    error("invalid side: " .. params.side, 2)
  end

  self._side = params.side
  self._inverted = self.inverted or false

  return self
end

--- Check if input is active.
---@return boolean
function RsReader:is_on()
  local state = self._controller.getInput(self._side)
  if self._inverted then
    return not state
  else
    return state
  end
end

return RsReader
