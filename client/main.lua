AP = {
  ---@type table
  save = nil,
  ---@type APClient?
  _client = nil,
  id_to_item = {"babataire","babaex","eldritch","alchemy","wolf","poker","big","lock","thing","cheat","single","binary","limited","random","swap","hanoi","fork","solitairdle","stack","tear","fiftytwo","time","garden","solar","doubleside","murder","elec","quant","key","river", "trap-no undo"},
  loc_to_id = {
    ["tap solitaire - win 1"] = 1,
    ["tap solitaire - win 5"] = 2,
    ["tap solitaire - win 10"] = 3,
    ["tap solitaire - streak 2"] = 4,
    ["babataire - win 1"] = 5,
    ["babataire - win 5"] = 6,
    ["babataire - win 10"] = 7,
    ["babataire - streak 2"] = 8,
    ["eldritch invasion - win 1"] = 9,
    ["eldritch invasion - win 5"] = 10,
    ["eldritch invasion - win 10"] = 11,
    ["eldritch invasion - streak 2"] = 12,
    ["transmutation - win 1"] = 13,
    ["transmutation - win 5"] = 14,
    ["transmutation - win 10"] = 15,
    ["transmutation - streak 2"] = 16,
    ["council of secrets - win 1"] = 17,
    ["council of secrets - win 5"] = 18,
    ["council of secrets - win 10"] = 19,
    ["council of secrets - streak 2"] = 20,
    ["royal flush solitaire - win 1"] = 21,
    ["royal flush solitaire - win 5"] = 22,
    ["royal flush solitaire - win 10"] = 23,
    ["royal flush solitaire - streak 2"] = 24,
    ["megataire - win 1"] = 25,
    ["megataire - win 5"] = 26,
    ["megataire - win 10"] = 27,
    ["megataire - streak 2"] = 28,
    ["lock solitaire - win 1"] = 29,
    ["lock solitaire - win 5"] = 30,
    ["lock solitaire - win 10"] = 31,
    ["lock solitaire - streak 2"] = 32,
    ["uneven solitaire - win 1"] = 33,
    ["uneven solitaire - win 5"] = 34,
    ["uneven solitaire - win 10"] = 35,
    ["uneven solitaire - streak 2"] = 36,
    ["cheatdeck solitaire - win 1"] = 37,
    ["cheatdeck solitaire - win 5"] = 38,
    ["cheatdeck solitaire - win 10"] = 39,
    ["cheatdeck solitaire - streak 2"] = 40,
    ["single-card solitaire - win 1"] = 41,
    ["single-card solitaire - win 5"] = 42,
    ["single-card solitaire - win 10"] = 43,
    ["single-card solitaire - streak 2"] = 44,
    ["binary solitaire - win 1"] = 45,
    ["binary solitaire - win 5"] = 46,
    ["binary solitaire - win 10"] = 47,
    ["binary solitaire - streak 2"] = 48,
    ["limited move solitaire - win 1"] = 49,
    ["limited move solitaire - win 5"] = 50,
    ["limited move solitaire - win 10"] = 51,
    ["limited move solitaire - streak 2"] = 52,
    ["chaotic solitaire - win 1"] = 53,
    ["chaotic solitaire - win 5"] = 54,
    ["chaotic solitaire - win 10"] = 55,
    ["chaotic solitaire - streak 2"] = 56,
    ["swap-a-taire - win 1"] = 57,
    ["swap-a-taire - win 5"] = 58,
    ["swap-a-taire - win 10"] = 59,
    ["swap-a-taire - streak 2"] = 60,
    ["hanoi solitaire - win 1"] = 61,
    ["hanoi solitaire - win 5"] = 62,
    ["hanoi solitaire - win 10"] = 63,
    ["hanoi solitaire - streak 2"] = 64,
    ["fork solitaire - win 1"] = 65,
    ["fork solitaire - win 5"] = 66,
    ["fork solitaire - win 10"] = 67,
    ["fork solitaire - streak 2"] = 68,
    ["solitairdle - win 1"] = 69,
    ["solitairdle - win 5"] = 70,
    ["solitairdle - win 10"] = 71,
    ["solitairdle - streak 2"] = 72,
    ["single-stack solitaire - win 1"] = 73,
    ["single-stack solitaire - win 5"] = 74,
    ["single-stack solitaire - win 10"] = 75,
    ["single-stack solitaire - streak 2"] = 76,
    ["tear solitaire - win 1"] = 77,
    ["tear solitaire - win 5"] = 78,
    ["tear solitaire - win 10"] = 79,
    ["tear solitaire - streak 2"] = 80,
    ["52-card solitaire - win 1"] = 81,
    ["52-card solitaire - win 5"] = 82,
    ["52-card solitaire - win 10"] = 83,
    ["52-card solitaire - streak 2"] = 84,
    ["time travel solitaire - win 1"] = 85,
    ["time travel solitaire - win 5"] = 86,
    ["time travel solitaire - win 10"] = 87,
    ["time travel solitaire - streak 2"] = 88,
    ["garden solitaire - win 1"] = 89,
    ["garden solitaire - win 5"] = 90,
    ["garden solitaire - win 10"] = 91,
    ["garden solitaire - streak 2"] = 92,
    ["solartaire - win 1"] = 93,
    ["solartaire - win 5"] = 94,
    ["solartaire - win 10"] = 95,
    ["solartaire - streak 2"] = 96,
    ["double-sided solitaire - win 1"] = 97,
    ["double-sided solitaire - win 5"] = 98,
    ["double-sided solitaire - win 10"] = 99,
    ["double-sided solitaire - streak 2"] = 100,
    ["murder mystery - win 1"] = 101,
    ["murder mystery - win 5"] = 102,
    ["murder mystery - win 10"] = 103,
    ["murder mystery - streak 2"] = 104,
    ["circuit solitaire - win 1"] = 105,
    ["circuit solitaire - win 5"] = 106,
    ["circuit solitaire - win 10"] = 107,
    ["circuit solitaire - streak 2"] = 108,
    ["tabula rasa solitaire - win 1"] = 109,
    ["tabula rasa solitaire - win 5"] = 110,
    ["tabula rasa solitaire - win 10"] = 111,
    ["tabula rasa solitaire - streak 2"] = 112,
    ["lock-and-key solitaire - win 1"] = 113,
    ["lock-and-key solitaire - win 5"] = 114,
    ["lock-and-key solitaire - win 10"] = 115,
    ["lock-and-key solitaire - streak 2"] = 116,
    ["ferret rabbit carrot - win 1"] = 117,
    ["ferret rabbit carrot - win 5"] = 118,
    ["ferret rabbit carrot - win 10"] = 119,
    ["ferret rabbit carrot - streak 2"] = 120,
  },
  id_to_loc = nil,
  ---@type integer[]
  _loc_to_check = {},
  ---@type fun(str: string): status:boolean
  check = function(str)
    if not AP.loc_to_id[string.lower(str)] then print("no '" .. string.lower(str) .. "' in loc to id") return false end
    
    local id = AP._client:get_item_id(str)

    table.insert(AP._loc_to_check, AP.loc_to_id[str])
    return true
  end,
  trap = {},
}

require("ap.utils")
require("ap.textsys")
require("ap.debug")
require("ap.menu_setup")
require("ap.ap_connect")
require("ap.handle_save")
require("ap.trap.main")
require("ap.input")
require("ap.unithelp")
require("ap.cmd_args")

--Screens
require("ap.loading_screen")
require("ap.connection_screen")

achievement = function() print("No achievement when archipelago-ed :)") end

---@return table
function AP.get_id_to_loc()
  if AP.id_to_loc ~= nil then return AP.id_to_loc end

  local tbl = {}
  for k,v in pairs(AP.loc_to_id) do
    tbl[v] = k
  end

  AP.id_to_loc = tbl
  return tbl
end

local server = get_cmd_arg("ap_address")
local slot = get_cmd_arg("ap_slot")
local password = get_cmd_arg("ap_password") or ""

if not server or not slot then
  GAME.startmenu = "ap_connection"
else
  AP.connect(server, slot, password)
end
