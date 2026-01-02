function AP.store_save()
  print("AP: STORE SAVE")
  
  if AP.save == nil then return end
end

local file_fun = {
  close = function(self)
    --No close required :)
  end,

  ---@param group string
  ---@param item string
  ---@return any
  read = function(self,group,item)
    print("read: ")
    print("- group: " .. tostring(group))
    print("- item: " .. tostring(item))

    if not AP.save then return end

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
  ---@return boolean
  readbool = function(self,group,item)
    return self:readnum(group, item) == 1
  end,

  ---@param group string
  ---@param item string
  ---@param val any
  write = function(self,group,item,val)
    print("write")
    print("- group: " .. tostring(group))
    print("- item: " .. tostring(item))
    print("- val: " .. tostring(val))

    if AP.save[group] == nil then AP.save[group] = {} end

    AP.save[group][item] = val
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
