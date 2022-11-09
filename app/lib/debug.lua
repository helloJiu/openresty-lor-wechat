local pDebug = require("lor.lib.debug")
local appDebug = require("app.config.config").app_debug

local function debug(...)
    if not appDebug then
        return
    end
    pDebug(...)
end

return debug