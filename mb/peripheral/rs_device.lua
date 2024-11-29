-- Imports
local Expect = require "cc.expect"

local Table = require "mb.algorithm.table"

--- Redstone wrapper.
---@class RsDevice
---@field private _controller table Wrapped redstone controller.
---@field private _side string Side of the redstone controller to use.
---@field private _inverted boolean If set redstone signal will be inverted.
local RsDevice = {}
RsDevice.__index = RsDevice

--- Redstone device creation parameters.
---@class RsDeviceCreationParameters
---@field name string? Wrapped redstone controller name. Passing nil results in the computer being used.
---@field side string Side of the redstone controller to use.
---@field inverted boolean? If set, signals will be inverted.

--- Constructor
---@param params RsDeviceCreationParameters
function RsDevice.new(params)
  Expect.field(params, "name", "string", "nil")
  Expect.field(params, "side", "string")
  Expect.field(params, "inverted", "boolean", "nil")

  local self = setmetatable({}, RsDevice)

  if params.name then
    self._controller = peripheral.wrap(params.name)
    if type == nil or not peripheral.hasType(self._controller, "redstoneIntegrator") then
      error("invalid controller: " .. params.name, 2)
    end
  else
    self._controller = redstone
  end

  if not Table.contains_value(redstone.getSides(), params.side) then
    error("invalid side: " .. params.side, 2)
  end

  self._side = params.side
  self._inverted = params.inverted or false

  return self
end

-- Check if the output is active.
function RsDevice:is_on()
  local state = self._controller.getOutput(self._side)
  if self._inverted then
    return not state
  else
    return state
  end
end

-- Set the output active.
function RsDevice:set_on()
  self._controller.setOutput(self._side, not self._inverted)
end

-- Set the output inactive.
function RsDevice:set_off()
  self._controller.setOutput(self._side, self._inverted)
end

-- Toggle the output.
function RsDevice:toggle()
  self._controller.setOutput(self._size, not self:is_open())
end

return RsDevice
