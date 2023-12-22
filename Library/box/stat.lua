---@meta
--luacheck: ignore

---@class boxStat
---@field reset fun() # resets current statistics
---@field net fun(): boxStatNet # shows network activity
---@field sql fun(): boxStatSql
---@field vinyl fun(): boxStatVinyl # shows vinyl-storage-engine activity
---@field memtx boxStatMemtx
---@overload fun(): boxStatInfo
box.stat = {}

---@class boxStatDefault
---@field total number
---@field rps number

---@class boxStatDefaultWithCurrent:boxStatDefault
---@field current number

---@class boxStatNet
---@field SENT boxStatDefault sent bytes to iproto
---@field RECEIVED boxStatDefault received bytes from iproto
---@field CONNECTIONS boxStatDefaultWithCurrent iproto connections statistics
---@field REQUESTS boxStatDefaultWithCurrent iproto requests statistics

---@class boxStatSql
-- TODO

---@class boxStatVinyl
-- TODO

---@class boxStatMemtxTx
--  TODO

---@class boxStatMemtx
---@field tx boxStatMemtxTx

---@class boxStatInfo
---@field INSERT boxStatDefault
---@field DELETE boxStatDefault
---@field SELECT boxStatDefault
---@field REPLACE boxStatDefault
---@field UPDATE boxStatDefault
---@field UPSERT boxStatDefault
---@field CALL boxStatDefault
---@field EVAL boxStatDefault
---@field AUTH boxStatDefault
---@field ERROR boxStatDefault
