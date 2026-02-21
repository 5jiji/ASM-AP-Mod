GAME.startmenu = "ap_connection"

-- Disable mouse scroll tool
local enabledPosition = true
prepend("love.mouse.getPosition", function()
  return enabledPosition, screenw * 0.5 * scaling, screenh * 0.5 * scaling
end)

append("menusys.change", function(_, menu)
  if AP.screen and menu ~= "ap_connection" then
    menusys.close()
    menusys.change("ap_connection")
  end
end)

--- Main Menu ---

-- Game mode blocker
---@type string[]
UNLOCKED_SCRIPT = {}
SCRIPT_MODS_BAK = SCRIPT_MODS
prepend("menulist[\"main\"].enter", function()
  SCRIPT_MODS = {}
  for _, e in ipairs(UNLOCKED_SCRIPT) do
    table.insert(SCRIPT_MODS, e)
  end
end)

-- Fixes on weird count of unlocked game modes --
append("menulist[\"main\"].enter", function()
  if #UNLOCKED_SCRIPT == 1 then -- Division by 0 is occured when only 1 game mode exists
    local unit = unitsys.find("icon")
    unit.xp = -40
  end

  if #UNLOCKED_SCRIPT == 0 then -- Nothing shows up when there is 0 game modes (duh)
    textsys.write("No modes unlocked :(", screenw / 2 - 35, screenh * 0.75, "modes_unlocked", {font = "header", gap = 5})
  end

  if AP.goal then
    audiosys.addevent("music_mystery", "changetrack")
  elseif not AP.goal and alternatemusic ~= 0 then
    audiosys.addevent("music_theme", "changetrack")
    alternatemusic = 0
  end
end)

-- Enable mouse scroll in main menu
prepend("menulist[\"main\"].update", function()
  if #SCRIPT_MODS < 10 then enabledPosition = false end
end)

append("menulist[\"main\"].update", function()
  enabledPosition = true
end)
