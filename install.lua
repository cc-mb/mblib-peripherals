local REPO = "https://raw.githubusercontent.com/cc-mb/lib/refs/heads"
local BRANCH = "master"

local TARGET_DIR = "/usr/lib"
local FILES = {
  "mb/algorithm/table.lua",
  "mb/peripheral/door.lua",
  "mb/peripheral/monitor.lua",
  "mb/peripheral/rs_device.lua"
}

for _, file in ipairs(FILES) do
  local local_file = "/" .. fs.combine(TARGET_DIR, file)
  local remote_file = REPO .. "/" .. fs.combine(BRANCH, file)
  shell.run("wget " .. remote_file .. " " .. local_file)
end
