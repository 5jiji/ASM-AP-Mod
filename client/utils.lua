local append_count = 1
local prepend_count = 1

---@param replace string The lua path to the function to replace
---@param fun fun(values: table, ...): override_output: boolean?, ...: any? The function to append
function append(replace, fun)
  local chunk, err = loadstring("return " .. replace)
  if chunk == nil then print("Append failed: " .. err) end

  loadstring([[return function (fun)
    local old_fun = ]] .. replace .. [[
    if type(old_fun) ~= "function" then return print("]].. string.gsub(replace, "\"", "\\\"") ..[[ is not a function") end
        
    local new_fun = function(...)
      local values = {old_fun(...)}
      local override_values = {fun(values, ...)}
      if override_values[1] == true then
        table.remove(override_values, 1)
        return unpack(override_values)
      end
          
      return unpack(values)
    end
  ]] .. replace .. " = new_fun end", "append_" .. append_count)()(fun)
  
  append_count = append_count + 1
end

---@param replace string The lua path to the function to replace
---@param fun fun(...: any): continue: boolean?, ...: any? The function to append
function prepend(replace, fun)
  local c, err = loadstring("return " .. replace)
  if c == nil then error(err) end

  loadstring([[return function (fun)
    local old_fun = ]] .. replace .. [[
    if type(old_fun) ~= "function" then return print("]].. string.gsub(replace, "\"", "\\\"") ..[[ is not a function") end
    
    local new_fun = function(...)
      local results = {fun(...)}
      if results[1] == false then
        table.remove(results, 1)
        return unpack(results)
      end

      return old_fun(...)
    end
  ]] .. replace .. " = new_fun end", "prepend_" .. prepend_count)()(fun)

  prepend_count = prepend_count + 1
end
