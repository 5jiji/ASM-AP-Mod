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
    elseif type(v) == "string" then
      str = str .. "\"" .. tostring(v) .. "\""
    else
      str = str .. tostring(v)
    end
  end

  str = str .. "\n}"

  if str == "{\n}" then return "{}" end
  return str
end

DEBUG = {
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
  end,

  get_from_file = function(group, item)
    local file = filesys.ini.open("save.txt")
    return file:read(group, item)
  end
}

if not love.filesystem.isFused() then
  append("love.keypressed", function(_, key)
    if key == "rctrl" then
      debug.debug()
    end
  end)
end
