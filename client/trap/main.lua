require("ap.trap.undo")

---@param name string
---@param item NetworkItem
function handle_trap(name, item)
  if name == "trap-no undo" then
    AP.no_undo = true
  end
end