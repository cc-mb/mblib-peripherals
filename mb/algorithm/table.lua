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

--- Merges all passed table into one table. In case there's conflicting key present in multiple tables, the latest one will be used.
---@param ... table Tables to merge.
---@return table Merged table.
function Table.merge(...)
  local result = {}
  for _, table in ipairs({...}) do
    for k, v in pairs(table) do
      result[k] = v
    end
  end

  return result
end

return Table
