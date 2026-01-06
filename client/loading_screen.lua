menulist["ap_loading"] = {
  enter = function()
    menulist["main"].enter()
    
    AUDIOEVENTS = {}
    AUDIO["music_theme"].object:stop()

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
  end,

  button_setup = function(button, mousebutton, key)
    if mousebutton ~= 1 then return end

    menusys.sub("setup")
		audiosys.play("beep2")
  end,

  button_close = function(...)
    menulist["main"].button_close(...)
  end,
}
