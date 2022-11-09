-- https://segmentfault.com/a/1190000007207616
-- https://github.com/openresty/lua-resty-redis
local redis = require("resty/redis")
local config = require("app.config.config").redis
local log = ngx.log
local ERR = ngx.ERR
local setmetatable = setmetatable

local _M = {}

local mt = { __index = _M }

local function errlog(...)
    log(ERR, "Redis: ", ...)
end

function _M.exec(instance, func)
    local red = redis:new()
    red:set_timeout(instance.timeout)

    local ok, err = red:connect(instance.host, instance.port)
    if not ok then
        errlog("Cannot connect, host: " .. instance.host .. ", port: " .. instance.port)
        return nil, err
    end

    red:select(instance.database)

    local res, err = func(red)
    if res then
        local ok, err = red:set_keepalive(instance.max_idle_time, instance.pool_size)
        if not ok then
            red:close()
        end
    end
    return res, err
end

function _M.new()
    local instance = {
        host = config.host or "127.0.0.1",
        port = config.port or 6379,
        timeout = config.timeout or 5000,
        database = config.database or 0,
        max_idle_time = config.max_idle_time or 60000,
        pool_size = config.pool_size or 100
    }
    return setmetatable(instance, mt)
end

return _M