local function get_input(input)
  local text = textsys.getone(input .. "_input_text")

  local str = ""
  for _,v in ipairs(text) do
    str = str .. v[1]
  end

  return str
end

local toggle_write = false;
local settings;

---@param ip string
---@return boolean
local function is_valid_ip(ip)
  local tbl = {string.match(ip, "^[0-9]-%.?[0-9]-%.?[0-9]-%.?[0-9]-%.?$")}

  if #tbl == 0 then dbg(ip) return false end

  return true
end

---@param host string
local function is_valid_host(host)
  return not not string.find(host, ".")
end

---@param port string|number
local function is_valid_port(port)
  port = tonumber(port) or -1

  return port <= 65535 and port >= 1
end

menulist["ap_connection"] = {
  enter = function()
    settings = filesys.ini.open("ap_settings.txt")
    AP.screen = true

    if #MENU == 1 then
      menulist["main"].enter()
    end

    unitsys.remove_all_units("icon")
    textsys.erase("modes_unlocked")

    for _,b in ipairs(BUTTONS) do
      if b.id == "ui" and not (b.name == "setup" or b.name == "close") then
        b.disabled = true
      end
    end

    --        scaling * (0.5 * screenw - (142 * 0.5)) -- Centered input boxes
    local x = scaling * (0.45 * screenw)
    local base_y = (0.7 * screenh)

    menusys.button.create("address_input", x / scaling + 70, base_y - 30, nil, {w = 142, h = 20})
    menusys.button.create("slot_input", x / scaling + 70, base_y + 10, nil, {w = 142, h = 20})
    menusys.button.create("password_input", x / scaling + 70, base_y + 50, nil, {w = 142, h = 20})

    menusys.button.create("validate", x / scaling + 20, base_y + 90, nil, {w = 72, h = 20, _text = "Validate"})
    
    textsys.write(settings:read("ap", "address") or "", x / scaling + 2, base_y - 37, "address_input_text", {font = "header", gap = 5})
    textsys.write(settings:read("ap", "slot") or "", x / scaling + 2, base_y + 3, "slot_input_text", {font = "header", gap = 5})
    textsys.write(settings:read("ap", "password") or "", x / scaling + 2, base_y + 43, "password_input_text", {font = "header", gap = 5})
    
    local x_text = x / scaling - 90
    textsys.write("address:port", x_text, base_y - 37, nil, {font = "header", gap = 5})
    textsys.write("slot", x_text, base_y + 3, nil, {font = "header", gap = 5})
    textsys.write("password", x_text, base_y + 43, nil, {font = "header", gap = 5})
  end,

  update = function()
    if math.floor(love.timer.getTime() * 2) % 2 == 0 then
      toggle_write = not toggle_write;
    end
    
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.line(0, 0, screenw * scaling, screenh * scaling)

    if AP.input.button then
      local offset = #textsys.getone(AP.input.button.name .. "_text")
      --[[print(
        AP.input.button.x - 50 * scaling,
        AP.input.button.y - 50 * scaling,
        AP.input.button.x + AP.input.button.w - 50 * scaling,
        AP.input.button.y + AP.input.button.h - 50 * scaling
      );]]
      love.graphics.line(
        AP.input.button.x + 50 * scaling,
        AP.input.button.y + 50 * scaling,
        AP.input.button.x + AP.input.button.w,
        AP.input.button.y + AP.input.button.h
      );
    end

  --[[
    for _,v in ipairs(BUTTONS) do
      local _, fin = string.find(v.name, "_")
      if fin == nil or string.sub(v.name, fin+1) ~= "input" then goto continue end

      local text = textsys.getone(v.name .. "_text")
      if menusys.button.gethover(v.name) then
        for _,v in ipairs(text) do
          v[4] = 0x000000
        end
      else 
        for _,v in ipairs(text) do
          v[4] = 0xffffff
        end
      end

      ::continue::
    end
    ]]
  end,
  
  leave = function()
    unitsys.remove_byclass("thumbnail", "thumb")
    settings = nil
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
    AP.input.button = button
  end,

  button_slot_input = function(button, mousebutton, key)
    AP.input.button = button
  end,

  button_password_input = function(button, mousebutton, key)
    AP.input.button = button
  end,

  button_validate = function(button, mousebutton, key)
    AP.failed = nil
    AP.input.button = nil
    AP.reason = nil
    
    local address = get_input("address")
    local s,e = string.find(address, ":")
    local port = e ~= nil and string.sub(address, e) or nil
    local ip = s ~= nil and string.sub(address, 1, s-1) or nil

    if
      (ip == nil or not is_valid_ip(ip)) and
      (port == nil or not is_valid_port(port)) or
      not is_valid_host(address)
    then
      return
    end

    settings:write("ap", "address", address)
    settings:write("ap", "slot", get_input("slot"))
    settings:write("ap", "password", get_input("password"))
    settings:store()

    AP.connect(settings:read("ap", "address"), settings:read("ap", "slot"), settings:read("ap","password"))

    unitsys.remove_all_units()

    AP.screen = false
    menusys.change("ap_loading")
    menusys.refresh()
  end
}
