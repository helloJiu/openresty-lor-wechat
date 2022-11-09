local httpClient = require("resty.http").new()
local string = require("string")
local config = require("app.config.config")
local debug = require("app.lib.debug")
local json = require("cjson")
local redis = require("app.lib.redis")

local wechatUtil = {}

-- https://github.com/ledgetech/lua-resty-http
function wechatUtil.getAccessToken()
    local red = redis.new()
    local accessToken, err = red:exec(function(red)
        return red:get("wechat:access_token")
    end)

    if accessToken then 
        return accessToken
    end

    local appId = config.wechat.appId
    local appSecret = config.wechat.appSecret
    local url = string.format(
        "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s",appId, appSecret)
    local res, err = httpClient:request_uri(url, {
        method = "GET",
        headers = {["Content-Type"] = "application/json",},
        ssl_verify = false
    })
    if not res then
        ngx.log(ngx.ERR, "=============>request failed: ", err)
        return ""
    end
    -- At this point, the entire request / response is complete and the connection
    -- will be closed or back on the connection pool.
    -- The `res` table contains the expeected `status`, `headers` and `body` fields.
    local status = res.status
    local length = res.headers["Content-Length"]
    local body   = res.body
    debug("body----------- ", body)
    httpClient:close()
    local accessToken = json.decode(body).access_token
    local ok, err = red:exec(function(red)
        return red:set("wechat:access_token", accessToken)
    end)

    return accessToken
end

function wechatUtil.sendMessage(body)
    local accessToken = wechatUtil.getAccessToken()
    debug("------------getAccessToken: ", accessToken)
    local url = string.format(
        "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=%s",accessToken)
    debug("========================", url)
    local res, err = httpClient:request_uri(url, {
        method = "POST",
        body = json.encode(body),
        headers = {["Content-Type"] = "application/json",},
        ssl_verify = false
    })
    if not res then
        ngx.log(ngx.ERR, "=============>request failed: ", err)
    end
    -- debug(res)
end

return wechatUtil