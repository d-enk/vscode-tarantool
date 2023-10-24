---@meta
--luacheck: ignore

---@class boxCtl
box.ctl = {}

---Wait until box.info.ro is false.
---@async
---@param timeout? number
function box.ctl.wait_rw(timeout) end

---Wait until box.info.ro is true.
---@async
---@param timeout? number
function box.ctl.wait_ro(timeout) end

---Define a trigger for execution before shutdown
---@param trigger_func? fun() function which will become the trigger function
---@param old_trigger_func? fun() existing trigger function which will be replaced by trigger-function
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.ctl.on_shutdown(trigger_func, old_trigger_func) end

---Set a timeout for the on_shutdown trigger.
---@param timeout? number
function box.ctl.set_on_shutdown_timeout(timeout) end

---Check whether the recovery process has finished.
---Until it has finished, space changes such as `insert` or `update` are not possible.
---@return boolean
function box.ctl.is_recovery_finished() end

---Wait, then choose new replication leader.
function box.ctl.promote() end
---Wait, then choose new replication leader.
function box.ctl.clear_synchro_queue() end

---Revoke the leader role from the instance.
function box.ctl.demote() end

---Create a trigger executed every time the current state of a replica set node in regard to leader election changes.
---The current state is available in the box.info.election table.
---@param trigger_func? fun() function which will become the trigger function
---@param old_trigger_func? fun() existing trigger function which will be replaced by trigger-function
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.ctl.on_election(trigger_func, old_trigger_func) end

---Create a “schema_init trigger”. The trigger-function will be executed when `box.cfg{}` happens for the first time.
---That is, the `schema_init` trigger is called before the server’s configuration and recovery begins,
---and therefore `box.ctl.on_schema_init` must be called before `box.cfg` is called.
---@param trigger_func? fun() function which will become the trigger function
---@param old_trigger_func? fun() existing trigger function which will be replaced by trigger-function
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.ctl.on_schema_init(trigger_func, old_trigger_func) end

---Create a trigger executed on different stages of a node recovery or initial configuration.
---Note that you need to set the box.ctl.on_recovery_state trigger before the initial box.cfg call.
---@param trigger_func? fun(state: string) function which will become the trigger function
---@param old_trigger_func? fun(state: string) existing trigger function which will be replaced by trigger-function
---@return fun()? removed_trigger If the parameters are (nil, old-trigger-function), then the old trigger is deleted.
function box.ctl.on_recovery_state(trigger_func, old_trigger_func) end
