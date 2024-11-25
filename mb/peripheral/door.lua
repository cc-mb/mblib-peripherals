-- Imports
local RsDevice = require "mb.peripheral.rs_device"

--- Redstone wrapper specialized for door control.
---@class Door
---@field private _rs_device RsDevice Wrapped redstone controller.
---@export
local Door = {}
Door.__index = Door

--- Constructor
---@param name string? Wrapped redstone controller name. Passing nil results in the computer being used.
---@param side string Side of the redstone controller to use.
---@param params table? Optional parameters.
function Door.new(name, side, params)
  local self = setmetatable({}, Door)
  self._rs_device = RsDevice.new(name, side, params)
  return self
end

-- Check if door is open.
function Door:is_open()
  return self._rs_device:is_on()
end

-- Open the door.
function Door:open()
  self._rs_device:set_on()
end

-- Close the door.
function Door:close()
  self._rs_device:set_off()
end

-- Toggle the door.
function Door:toggle()
  self._rs_device:toggle()
end

return Door
