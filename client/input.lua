AP.input = {
  button = nil
}

local tbl = {

}

setmetatable(AP.input, {__index = tbl})

function love.textinput(t)
  if AP.input.button == nil then return end
  textsys.append(AP.input.button.name .. "_text", t, "header")
end

append("love.keypressed", function(_, key, u)
  if AP.input.button ~= nil then
    if key == "backspace" then
      local text = textsys.getone(AP.input.button.name .. "_text")
      table.remove(text, #text)
    end
  end
end)
