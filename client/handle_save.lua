function AP.store_save()
  if AP.save == nil then return end

  AP._client:Set("ASM-save-" .. AP._client:get_player_number(), {}, false, {
    {operation = "replace", value = AP.save}
  })
end

local file_fun = {
  close = function(self)
    --No close required :)
  end,

  ---@param group string
  ---@param item string
  ---@return string
  read = function(self,group,item)
    if AP.save[group] == nil then AP.save[group] = {} end

    return AP.save[group][item]
  end,

  ---@param group string
  ---@param item string
  ---@return number
  readnum = function(self,group,item)
    return tonumber(self:read(group, item)) or 0
  end,

  ---@param group string
  ---@param item string
  ---@return boolean?
  readbool = function(self,group,item)
    return self:readnum(group, item) == 1
  end,

  ---@param group string
  ---@param item string
  ---@param val string
  write = function(self,group,item,val)
    if AP.save[group] == nil then AP.save[group] = {} end

    AP.save[group][item] = val

    if group == "wins" then
      if val == "1" then AP.check(item .. "-win_1") end
      if val == "5" then AP.check(item .. "-win_5") end
      if val == "10" then AP.check(item .. "-win_10") end
    end

    if group == "mstreak" then
      if val == "2" then AP.check(item .. "-streak_2") end
    end
  end,

  ---@param group string
  ---@param item string
  ---@param val boolean
  writebool = function(self,group,item,val)
    self:write(group, item, not not val)
  end,

  ---@param group string
  ---@param item string
  ---@param val any
  update = function(self,group,item,val)
    self:write(group,item,val)
    self:store(self.file,false)
  end,

  store = function(self,name_,closeafter_)
    AP.store_save()
  end,

  erase = function()
    -- Why would we erase ap data?
  end,
}

prepend("filesys.ini.open", function (filename)
  if filename ~= "save.txt" then return true end

  local file = {
    file = filename,
  }

  setmetatable(file, {__index = file_fun})

  return false, file, true
end)
