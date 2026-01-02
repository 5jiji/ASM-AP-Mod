GAME.startmenu = "ap_loading"

---@type string[]
UNLOCKED_SCRIPT = {}
SCRIPT_MODS_BAK = SCRIPT_MODS
prepend("menulist[\"main\"].enter", function()
  SCRIPT_MODS = {}
  for _, e in ipairs(UNLOCKED_SCRIPT) do
    table.insert(SCRIPT_MODS, e)
  end
end)

append("menulist[\"main\"].enter", function()
  if #UNLOCKED_SCRIPT == 1 then
    local unit = unitsys.find("icon")
    --unit.x = 42
    unit.xp = -40
  end

  if menusys.current() == "main" and #UNLOCKED_SCRIPT == 0 then
    print(#UNLOCKED_SCRIPT)
    textsys.write("No modes unlocked :(", screenw / 2 - 35, screenh * 0.75, {font = "header", gap = 5})
  end
end)

local enabledPosition = true
prepend("love.mouse.getPosition", function()
  return enabledPosition, screenw * 0.5 * scaling, screenh * 0.5 * scaling
end)

prepend("menulist[\"main\"].update", function()
  if #SCRIPT_MODS < 10 then enabledPosition = false end
end)

append("menulist[\"main\"].update", function()
  enabledPosition = true
end)

append("menusys.change", function(_, menu)
  if AP.screen and menu ~= "ap_connection" then
    menusys.close()
    menusys.change("ap_connection")
  end
end)
