local version = require("lor.version")
local Group = require("lor.lib.router.group")
local Router = require("lor.lib.router.router")
local Request = require("lor.lib.request")
local Response = require("lor.lib.response")
local Application = require("lor.lib.application")
local Wrap = require("lor.lib.wrap")

local createApplication = function(options)
    local app = Application:new()
    app:init(options)
    return app
end

local lor = Wrap:new(createApplication, Router, Group, Request, Response)
lor.version = version

return lor
