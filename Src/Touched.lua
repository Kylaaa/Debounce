local createScriptConnectionToken = require(script.Parent.createScriptConnectionToken)

local Players = game:GetService("Players")

return function(part : BasePart, onTouchStarted : (Player)->(), onTouchEnded : (Player)->()?) : ScriptConnection
	local playersTouching = {}

	local onTouchStartedConnection = part.Touched:Connect(function(otherPart : BasePart)
		if not otherPart.Parent:IsA("Model") then
			return
		end

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if not playersTouching[player] then
			playersTouching[player] = 1
			onTouchedStarted(player)
		else
			playersTouching[player] += 1
		end
	end)

	local onTouchEndedConnection = part.Touched:Connect(function(otherPart : BasePart)
		if not otherPart.Parent:IsA("Model") then
			return
		end

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if playersTouching[player] then
			playersTouching[player] -= 1

            if playersTouching[player] <= 0 then
            	playersTouching[player] = nil
            	onTouchEnded(player)
            end
		end
	end)

	local onDisconnect = function()
		onTouchStartedConnection:Disconnect()
		onTouchEndedConnection:Disconnect()
	end
	return createScriptConnectionToken(onDisconnect)
end