local create_apclient = require("lua-apclientpp")

--constants
local game_name = "A Solitaire Mystery"
local version = { 0, 6, 5 }

append("love.update", function()
  if not AP._client then return end
  
  AP._client:poll()
  if AP.connected and #AP._loc_to_check ~= 0 then
    AP._client:LocationChecks(AP._loc_to_check)

    local file = filesys.ini.open("save.txt")
    local pattern = AP.options.win10 and AP.options.win5 and "win_10" or not AP.options.win10 and AP.options.win5 and "win_5" or "win_1"

    local id_to_loc = AP.get_id_to_loc()
    local finished_count = file:readnum("ap", "finished_count") or 0
    for _,id in ipairs(AP._loc_to_check) do
      if string.find(id_to_loc[id], "-" .. pattern) ~= nil then
        finished_count = finished_count+1
      end
    end
    
    file:update("ap", "finished_count", tostring(finished_count))

    if not AP.goal and finished_count >= AP.options.finished_modes then
      AP.goal = true
      AP._client:StatusUpdate(30)
    end

    AP._loc_to_check = {}
  end
end)

append("love.quit", function()
  AP._client:reset()
  AP._client = nil
end)

function AP.connect(server, slot, password)
  local reconnect = 5
  AP._client = create_apclient("", game_name, server)

  AP._client:set_socket_connected_handler(function ()
    AP.connected = true
  end)
  
  AP._client:set_socket_error_handler(function (msg)
    print("AP Error: " .. msg)
    if msg == "Connection refused" then
      reconnect = reconnect-1
      if reconnect <= 0 then
        error("Failed to connect to server: Is the server address and port valid?\n")
      end
    end
  end)
  
  AP._client:set_socket_disconnected_handler(function ()
    AP.connected = false
  end)
  
  AP._client:set_room_info_handler(function()
    AP._client:ConnectSlot(slot, password, 7, {"Lua-APClientPP", "NoText"}, version)
  end)
  
  AP._client:set_slot_connected_handler(function (slot_data)
    AP.options = slot_data

    if slot_data.death_link then AP._client:ConnectUpdate(nil, {"Lua-APClientPP", "NoText", "DeathLink"}) end
    AP._client:Get({"ASM-save-" .. AP._client:get_player_number()}, {client_data = "ASM-save"})
  end)

  AP._client:set_items_received_handler(function (items)
    local got_item = false
    for _, item in pairs(items) do
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
    if reason[1] == "IncompatibleVersion" then
      error("Connecting to AP slot refused: To play this slot, update the mod on this computer.\n")
    elseif reason[1] == "InvalidSlot" then
      error("Connecting to AP slot refused: Unknown Slot Name\n")
    elseif reason[1] == "InvalidPassword" then
      error("Connecting to AP slot refused: Invalid Slot Password\n")
    else
      error("Connecting to AP slot refused: Check slot name and/or password\n\nMore details: " .. table.concat(reason) .. "\n")
    end
  end)

  AP._client:set_retrieved_handler(function(data, keys, command)
    if command.client_data == "ASM-save" then
      AP.save = data["ASM-save-" .. AP._client:get_player_number()] or {}

      if filesys.ini.open("save.txt"):readnum("ap", "finished_count") >= AP.options.finished_modes then AP.goal = true end

      if menusys.current() == "ap_loading" then menusys.change("main") end
    end
  end)

  AP._client:set_data_package_changed_handler(function (dp)
    if not AP._client:is_data_package_valid() then return end
    dbg(dp)


  end)

end
