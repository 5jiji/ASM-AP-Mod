---@param tbl table
---@param depth number?
function dbg(tbl, depth)
  print(deep_print(tbl, depth))
end

---Output a table as a string
---@param tbl table
---@param depth number?
---@return string
function deep_print(tbl, depth)
  if type(tbl) ~= "table" then return tostring(tbl) end

  depth = (depth or math.huge)-1
  if depth <= 0 then return "{ [table] }" end

  local str = "{"

  for k, v in pairs(tbl) do
    str = str .. "\n  [" .. tostring(k) .. "]: "

    if type(v) == "table" then
      str = str .. string.gsub(deep_print(v, depth), "\n", "\n  ")
    else
      str = str .. "\"" .. tostring(v) .. "\""
    end
  end

  str = str .. "\n}"

  if str == "{\n}" then return "{}" end
  return str
end

DEBUG = {
  remove_all_units = function(class, name)
    for _,e in ipairs(unitsys.findall(class, name)) do
      unitsys.remove(e.id)
    end
  end,

  remove_all = function()
    DEBUG.remove_all_units()
    textsys.erase()
    menusys.button.erase()
  end,

  refresh = function()
    DEBUG.remove_all()
    menusys.refresh()
  end,

  copy = function(tbl)
    local new_tbl = {}

    for k,v in pairs(tbl) do
      new_tbl[k] = v
    end

    return new_tbl
  end
}
