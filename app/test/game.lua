local game = {}
game.name = "lol"
function game:play(abc) print("start", abc, self.name) end

function game:quit() print("end") end

function game:new(create_app, Router, Group, Request, Response)
    local instance = {}
    instance.router = Router
    instance.group = Group
    instance.request = Request
    instance.response = Response
    instance.fn = create_app
    instance.app = nil

    setmetatable(instance, {__index = self, __call = self.create_app})

    return instance
end

return game
