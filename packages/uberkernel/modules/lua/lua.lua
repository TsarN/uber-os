--Lua functions

lua = {}
local libPaths = {".", "/lib"}
local loaded = {}

function lua.include(lib)
  for i = 1, #loaded do
    if loaded[i] == lib then
      return true
    end
  end
  for i = 1, #libPaths do
    if fs.exists(libPaths[i] .. "/" .. lib .. ".lua") then
      status = shell.run(libPaths[i] .. "/" .. lib .. ".lua")
      if status then
        table.insert(loaded, lib)
        kernel.log("Loaded library: " .. lib .. ".lua")
        return true
      else
        kernel.log("Failed to load library: " .. lib .. ".lua")
        printError("Failed to load library: " .. lib .. ".lua")
      end
    end
  end
end

lua = applyreadonly(lua) _G["lua"] = lua
