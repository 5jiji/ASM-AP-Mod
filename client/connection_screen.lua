AP.screen = true

menulist["ap_connection"] = {
  enter = function()
    audiosys.addevent("music_mystery", "changetrack")
    
    if #MENU == 1 then
      menulist["main"].enter()
    end

    DEBUG.remove_all_units("icon")

    for _,b in ipairs(BUTTONS) do
      if b.id == "ui" and not (b.name == "setup" or b.name == "close") then
        b.disabled = true
      end
    end

    --[[
    ORDER[3] = {}
    local o = ORDER[3]
    local c = getrgb(BACKCOL,0.45,0.9)
    o.effect = function() love.graphics.setColor(c) love.graphics.rectangle("fill", 0, 0, screenw * scaling, screenh * scaling) love.graphics.setColor(1, 1, 1, 1) end
    ]]--

    --        scaling * (0.5 * screenw - (142 * 0.5)) -- Centered input boxes
    local x = scaling * (0.5 * screenw)
    
    unitsys.create("input", "address", x, scaling * (0.75 * screenh - 40))
    unitsys.create("input", "slot", x, scaling * (0.75 * screenh))
    unitsys.create("input", "password", x, scaling * (0.75 * screenh + 40))

    local buttons = {}

    table.insert(buttons, menusys.button.create("address_input", x / scaling + 70, 0.75 * screenh - 30, nil, {w = 142, h = 20}))
    table.insert(buttons, menusys.button.create("slot_input", x / scaling + 70, 0.75 * screenh + 10, nil, {w = 142, h = 20}))
    table.insert(buttons, menusys.button.create("password_input", x / scaling + 70, 0.75 * screenh + 50, nil, {w = 142, h = 20}))
    
    textsys.write("", x / scaling + 2, 0.75 * screenh - 37, "address_input_text", {font = "header", gap = 5})
    textsys.write("", x / scaling + 2, 0.75 * screenh + 3, "slot_input_text", {font = "header", gap = 5})
    textsys.write("", x / scaling + 2, 0.75 * screenh + 43, "password_input_text", {font = "header", gap = 5})

    local x_text = x / scaling - 90
    textsys.write("address:port", x_text, 0.75 * screenh - 37, nil, {font = "header", gap = 5})
    textsys.write("slot", x_text, 0.75 * screenh + 3, nil, {font = "header", gap = 5})
    textsys.write("password", x_text, 0.75 * screenh + 43, nil, {font = "header", gap = 5})
  end,

  
  update = function()
    for i,unit in pairs(unitsys.findall("input")) do
      if not unit.dbg then
        --dbg(unit)
        unit.dbg = true
      end
    end
  end,
  

  leave = function()
    unitsys.remove_byclass("thumbnail", "thumb");
  end,

  button_setup = function(button, mousebutton, key)
    if mousebutton ~= 1 then return end

    menusys.sub("setup")
		audiosys.play("beep2")
  end,

  button_close = function(...)
    menulist["main"].button_close(...)
  end,

  button_address_input = function(button, mousebutton, key)
    print("address_input")
    AP.input.button = button
  end,

  button_slot_input = function(button, mousebutton, key)
    print("slot_input")
    AP.input.button = button
  end,

  button_password_input = function(button, mousebutton, key)
    print("password_input")
    AP.input.button = button
  end,
}

