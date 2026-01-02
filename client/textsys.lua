---@param id string
textsys.getone = function(id)
  for _, t in ipairs(TEXT) do
    if t.id == id then
      return t
    end
  end
end

---@param id string
---@param text string
---@param font string?
textsys.append = function(id, text, font)
  local text_obj = textsys.getone(id)
  if text_obj == nil then print("no text with id '" .. id .. "'") return end

  -- Modified extract from textsys.handle
  do
    local d = font and IMGFONTS[font] or IMGFONTS[IMGFONT]

    local x = 0
    local g = d.gap or 1

    for _,c in ipairs(text_obj) do
      if c[1] == " " then x = x + 5
      else x = x + d.letters[c[1]].w + g
      end
    end

    local i = 1
    while (i <= #text) do
      local l = string.sub(text, i, i)

      if (l ~= " ") and (d.letters[l] ~= nil) then
        local letter = d.letters[l]
        local w = letter.w

        table.insert(text_obj, { l, x, 0, 0xffffff })
        x = x + w + g
      elseif l == " " then
        local letter = d.letters[l] or {}
        local w = letter.w or d.w

        table.insert(text_obj, { l, x, 0, 0xffffff })

        x = x + w
      end

      i = i + 1
    end
  end

end
