local create_apclient = require("lua-apclientpp")

--constants
local game_name = "A Solitaire Mystery"
local version = { 0, 6, 5 }

append("love.update", function()
  if not AP._client then return end
  
  AP._client:poll()
  if AP.connected and #AP._loc_to_check ~= 0 then
    AP._client:LocationChecks(AP._loc_to_check)
    AP._loc_to_check = {}
  end
end)

append("love.quit", function()
  AP._client:reset()
  AP._client = nil
end)

function AP.connect(server, slot, password)
  AP._client = create_apclient("", game_name, server)

  AP._client:set_socket_connected_handler(function ()
    AP.connected = true
  end)
  
  AP._client:set_socket_error_handler(function (msg)
    print("AP Error: " .. msg)
  end)
  
  AP._client:set_socket_disconnected_handler(function ()
    AP.connected = false
  end)
  
  AP._client:set_room_info_handler(function()
    print("room info")
    AP._client:ConnectSlot(slot, password, 7, {"Lua-APClientPP", "NoText"}, version)
  end)
  
  AP._client:set_slot_connected_handler(function (slot_data)
    AP.options = slot_data
    if slot_data.death_link then AP._client:ConnectUpdate(nil, {"Lua-APClientPP", "NoText", "DeathLink"}) end
    
    menusys.change("main")
  end)

  AP._client:set_items_received_handler(function (items)
    dbg(items)
    local got_item = false
    for _, item in pairs(items) do
      print(item.player, AP._client:get_player_number())
      if item.player ~= AP._client:get_player_number() then goto continue end
      if not AP.id_to_item[item.item] or AP.id_to_item[item.item] == "nothing" then goto continue end

      local item_name = AP.id_to_item[item.item]

      if string.sub(item_name, 1, 5) == "trap-" then
        handle_trap(item_name, item)
      end

      alert("Obtained '" .. item_name .. "'")

      -- Check if we already have the mode unlocked
      for _, s in pairs(UNLOCKED_SCRIPT) do
        if s == item_name then goto continue end
      end

      table.insert(UNLOCKED_SCRIPT, item_name)
      got_item = true
      
      ::continue::
    end

    if got_item and menusys.current() == "main" then DEBUG.refresh() return end
  end)

  AP._client:set_slot_refused_handler(function(reason)
    error("Connecting to AP slot refused: Check slot name and/or password\n\n" .. reason)
  end)

  AP._client:set_retrieved_handler(function(data, keys, command)
    dbg(data)
    dbg(keys)
    dbg(command)
  end)
end
