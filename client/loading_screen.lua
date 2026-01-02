menulist["ap_loading"] = {
  enter = function()
    menulist["main"].enter()
    audiosys.addevent("music_mystery", "changetrack")
    
    DEBUG.remove_all_units("icon")

    for _,b in ipairs(BUTTONS) do
      if b.id == "ui" and not (b.name == "setup" or b.name == "close") then
        b.disabled = true
      end
    end

    textsys.write("Loading AP data...", screenw / 2 - 35, screenh * 0.75, {font = "header", gap = 5})
  end,

  leave = function()
    DEBUG.remove_all()
  end
}
