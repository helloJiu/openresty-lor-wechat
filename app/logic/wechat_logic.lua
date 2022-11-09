local setmetatable = setmetatable
local xmlParser = require("app.lib.xmlSimple"):newParser()
local helper = require("app.lib.helper")
local os = require("os")
local wechatUtil = require("app.lib.wechatUtil")
local debug = require("app.lib.debug")
local redis = require("app.lib.redis")

local logic = {}

function logic:New()
    local instance = {}
    setmetatable(instance, {
        __index = self
    })
    return instance
end

-- https://github.com/Cluain/Lua-Simple-XML-Parser

function logic:acceptMessage(input)
    debug("-------------", input)
    local doc = xmlParser:ParseXmlText(input)
    local ToUserName = helper.parseCDATA(doc.xml.ToUserName:value());
    local FromUserName = helper.parseCDATA(doc.xml.FromUserName:value());
    local CreateTime = helper.parseCDATA(doc.xml.CreateTime:value());
    local MsgType = helper.parseCDATA(doc.xml.MsgType:value());

    -- debug("ToUserName: ", ToUserName)
    -- debug("FromUserName: ", FromUserName)
    -- debug("CreateTime: ", CreateTime)
    -- debug("MsgType: ", MsgType)
    local content = "hello "
    if MsgType == "text" then
        content = content .. helper.parseCDATA(doc.xml.Content:value());
    end
    -- debug("Content: ", helper.parseCDATA(doc.xml.Content:value()))
    -- {
    --     "touser":"OPENID",
    --     "msgtype":"text",
    --     "text":
    --     {
    --          "content":"Hello World"
    --     }
    -- }
    wechatUtil.sendMessage({
        touser = FromUserName,
        msgtype = "text",
        text = {
            content = "tpl----" .. content,
        }
    })
    return {FromUserName=ToUserName, ToUserName=FromUserName, time=os.time(), content=content}
end

-- local doc = xmlParser:ParseXmlText(
--     [[<test one="two">
--     <three four="five" four="six"/>
--     <three>eight</three>
--     <nine ten="eleven">twelve</nine>
-- </test>]])
-- xml.test["@one"] == "two"
-- xml.test.nine["@ten"] == "eleven"
-- xml.test.nine:value() == "twelve"
-- xml.test.three[1]["@four"][1] == "five"
-- xml.test.three[1]["@four"][2] == "six"
-- xml.test.three[2]:value() == "eight"


return logic
