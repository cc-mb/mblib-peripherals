-- Imports
local Expect = require "cc.expect"

local Table = require "mb.algorithm.table"

--- Redstone wrapper.
---@class RsReader
---@field private _controller table Wrapped redstone controller.
---@field private _side string Side of the redstone controller to use.
---@field private _inverted boolean If set redstone signal will be inverted.
local RsReader = {}
RsReader.__index = RsReader

--- Constructor
---@param name string? Wrapped redstone controller name. Passing nil results in the computer being used.
---@param side string Side of the redstone controller to use.
---@param params table? Optional parameters.
function RsReader.new(name, side, params)
  Expect.expect(1, name, "string", "nil")
  Expect.expect(2, side, "string")
  Expect.expect(3, params, "table", "nil")
  
  if params then
    Expect.field(params, "inverted", "boolean", "nil")
  end
  
  local self = setmetatable({}, RsReader)
  
  local params = params or {}
  
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
  self._inverted = self.inverted or false
  
  return self
end

-- Check if input is active.
function RsReader:is_on()
  local state = self._controller.getInput(self._side)
  if self._inverted then
    return not state
  else
    return state
  end
end

return RsReader
