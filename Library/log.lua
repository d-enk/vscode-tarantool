---@meta
--luacheck: ignore
---@module 'log'

---@class log: table
local log = {}

---@class logCfg
---@field level? log_level
---@field log? string
---@field log_nonblock? boolean
---@field too_long_threshold? number
---@field log_format? log_format
---@field logmodules? table

--
---@param opts? logCfg
function log.cfg(opts) end

---
---@param s any
---@param ... any
function log.warn(s, ...) end

---
---@param s any
---@param ... any
function log.info(s, ...) end

---
---@param s any
---@param ... any
function log.error(s, ...) end

---
---@param s any
---@param ... any
function log.verbose(s, ...) end

---
---@param s any
---@param ... any
function log.debug(s, ...) end

---sets log level
---@param lvl number
function log.level(lvl) end

return log
