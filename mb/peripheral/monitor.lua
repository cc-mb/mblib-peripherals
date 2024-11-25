-- Imports
local Expect = require "cc.expect"

--- Helper for getting monitors from name.
---@class Monitor
local Monitor = {}
Monitor.__index = Monitor

--- Pseudo-constructor
---@param name string? Name of the monitor. Passing nil results in any monitor.
function Monitor.new(name)
  Expect.expect(1, name, "string", "nil")

  local self = peripheral.wrap(name or "monitor")
  if not self and peripheral.hasType(self, "monitor") then
    error("invalid monitor: " .. name, 2)
  end
  
  return self
end

return Monitor
