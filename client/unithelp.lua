function unitsys.remove_all_units(class, name)
  for _,e in ipairs(unitsys.findall(class, name)) do
    unitsys.remove(e.id)
  end
end

function remove_all()
  unitsys.remove_all_units()
  textsys.erase()
  menusys.button.erase()
end
