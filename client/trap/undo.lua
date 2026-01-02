prepend("undo", function()
  if AP.trap.no_undo == true then 
    menusys.button.disable("ui", nil, "hint")
    
    return false
  end
end)

append("victory", function()
  AP.trap.no_undo = false
end)

append("menulist[\"ingame\"].enter", function()
  menusys.button.disable("ui", nil, "hint")
end)
