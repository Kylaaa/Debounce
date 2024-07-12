--[[
    Debounce - A library for debouncing events by player.


    -- EXAMPLE
    local part = game.Workspace.Part

    local onTouch = function(player : Player)
        print(string.format("%s began touching %s", player.Name, part.Name))
    end

    local onTouchEnded = function(player : Player)
        print(string.format("%s stopped touching %s", player.Name, part.Name))
    end

    Debounce.Touched(part, onTouch, onTouchEnded)
]]


return {
    Touched = require(script.Touched),
}