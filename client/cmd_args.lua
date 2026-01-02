---@param key string
---@return string?
function get_cmd_arg(key)
  for _,arg in ipairs(arg) do
    local _, iend = string.find(arg, key .. "=")
    if iend ~= nil then return string.sub(arg, iend + 1) end
  end

  local env = os.getenv(string.upper(key))
  return env
end

---@param key string
---@return string
function assert_cmd_arg(key)
  local value = get_cmd_arg(key)
  if value == nil then error("Missing cmd arg: '" .. key .. "' or environment '" .. string.upper(key) .. "'") end

  return value
end
