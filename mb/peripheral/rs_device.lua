-- Imports
local Expect = require "cc.expect"

local Table = require "mb.algorithm.table"

--- Redstone wrapper.
---@class RsDevice
---@field private _controller table Wrapped redstone controller.
---@field private _side string Side of the redstone controller to use.
---@field private _inverted boolean If set redstone signal will be inverted.
local RsDevice = {}

--- Constructor
---@param name string? Wrapped redstone controller name. Passing nil results in the computer being used.
---@param side string Side of the redstone controller to use.
---@param params table? Optional parameters.
function RsDevice:new(name, side, params)
  Expect.expect(1, name, "string", "nil")
  Expect.expect(2, side, "string")
  Expect.expect(3, params, "table", "nil")

  if params then
    Expect.field(params, "inverted", "boolean", "nil")
  end

  local _object = setmetatable({}, self)
  self.__index = self
  
  local _params = params or {}
  
  if name then
    self._controller = peripheral.wrap(name)
    if type == nil or not peripheral.hasType(self._controller, "redstoneIntegrator") then
      error("invalid controller: " .. name, 2)
    end
  else
    self._controller = redstone
  end
  
  if not Table.contains_value(redstone.getSides(), side) then
    error("invalid side: " .. side, 2)
  end
  
  self._side = side
  self._inverted = _params.inverted or false
  
  return _object
end

-- Check if door is open.
function RsDevice:is_on()
  local state = self._controller.getOutput(self._side)
  return self._inverted and not state or state
end

-- Open the door.
function RsDevice:set_on()
  self._controller.setOutput(self._side, not self._inverted)
end

-- Close the door.
function RsDevice:set_off()
  self._controller.setOutput(self._side, self._inverted)
end

-- Toggle the door.
function RsDevice:toggle()
  self._controller.setOutput(self._size, not self:is_open())
end

return RsDevice
