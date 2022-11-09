local lor = require("lor.index")
local router = lor:Router()
local json = require("cjson")
local wechatLogic = require("app.logic.wechat_logic"):New()
local debug = require("app.lib.debug")
-- simple router: hello world!
-- app:get("/wechat/accept", function(req, res, next)
--     res:send(req.query.echostr)
-- end)

-- app:post("/wechat/accept", function(req, res, next)
--     ngx.log(ngx.ERR, "-------------------------", cjson.encode(req.body))
--     res:send("1234")
-- end)
router:get(
    "/accept",
    function(req, res, next)
        res:send(req.query.echostr)
    end
)

router:post(
    "/accept",
    function(req, res, next)
        local body = json.encode(req.body)
        local data = wechatLogic:acceptMessage(req.body)
        debug("finish...")
        res:render("wechat/text", data)
    end
)

return router
