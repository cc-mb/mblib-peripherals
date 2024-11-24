-- Imorts
local Expect = require "cc.expect"

--- Algorithms manipulating tables.
---@class Table
---@export
local Table = {}

--- Checks whether the given table contains the given value.
--- @param table table Table to search in.
--- @param value any Value to search for.
--- @return boolean True if given value found, false otherwise.
function Table.contains_value(table, value)
  for _, v in pairs(table) do
    if v == value then
      return true
    end
  end
  
  return false
end

return Table
