---@meta
--luacheck: ignore

box.runtime = {}

---@class boxRuntimeInfo
---@field lua integer
---@field tuple integer
---@field maxalloc integer
---@field used integer

---@return boxRuntimeInfo
function box.runtime.info() end
