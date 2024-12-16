--- Helper for getting monitors from name.
---@class Monitor
local Monitor = {}
Monitor.__index = Monitor

--- Monitor creation parameters.
---@class MonitorCreationParameters
---@field name string? Monitor name. Passing nil results in any monitor.

--- Pseudo-constructor
---@param params MonitorCreationParameters
function Monitor.new(params)
  local self = peripheral.wrap(params.name or "monitor")
  if not self and peripheral.hasType(self, "monitor") then
    error("invalid monitor: " .. params.name, 2)
  end

  return self
end

return Monitor
