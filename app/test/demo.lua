-- -- 创建一个元表
-- local mt = {}
-- mt.__add = function(s1, s2)
--     local result = ""
--     if s1.sex == "boy" and s2.sex == "girl" then
-- result = "完美的家庭。"
-- elseif s1.sex == "girl" and s2.sex == "girl" then
-- result = "不好"; 
-- else		result = "不好" end
--     return result;	end
-- mt.__sub = function (s1, s2)
--   return 1 - 2
-- end
-- -- 创建两个table,可以想象成是两个类的对象
-- local s1 = {name = "Hello",sex = "boy"}
-- local s2 = {name = "Good",sex = "girl"}
-- -- 给两个table设置新的元表
-- setmetatable(s1, mt); 
-- setmetatable(s2, mt); 
-- -- 进行加法操作
-- local result = s1 - s2; 
-- print(result);
-- local smartMan = {
--     name = "none",
--     age = 25,
--     money = 9000000,
--     sayHello = function() print("大家好,我是 聪明的豪。"); end
-- }

-- local t1 = {};
-- local t2 = {}
-- local mt = {__index = smartMan}
-- setmetatable(t1, mt);
-- setmetatable(t2, mt);
-- print(t1.money);

-- t2.sayHello();

-- local game = require("openresty_demo.app.game")
-- game.play({a="b"})

-- tableA = {}
-- --为这个table添加一个属性
-- tableA.keyA='valueA'
-- tableA.__index=tableA

-- function tableA.Print() 
--   print(tableA.keyA) 
-- end

-- --将tableA设置为tableB元表，然后调用一下Print()
-- tableB=setmetatable({},tableA)
-- tableB.Print()--输出valueA

-- --将tableA设置为tableB元表，然后调用一下Print()
-- tableB=setmetatable({ keyA = 'valueB' },tableA)
-- tableB.Print()--输出valueA
require("string")
local username = "<![CDATA[2]]>"
username, _ = string.gsub(username, "<!%[CDATA%[]]>", "")
username, _ = string.gsub(username, "", "")
print(username)
