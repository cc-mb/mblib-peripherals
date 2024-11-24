-- Imports
local Expect = require "cc.expect"

--- Helper for getting monitors from name.
---@class Monitor
local Monitor = {}

--- Pseudo-constructor
---@param name string? Name of the monitor. Passing nil results in any monitor.
function Monitor:new(name)
  Expect.expect(1, name, "string", "nil")
  
  local _object = peripheral.wrap(name or "monitor")
  if not _object and peripheral.hasType(_object, "monitor") then
    error("invalid monitor: " .. name, 2)
  end
  
  return _object
end

return Monitor
