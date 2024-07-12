--!strict
local createScriptConnectionToken = require(script.Parent.createScriptConnectionToken)

local Players = game:GetService("Players")

type playerWhoTouchedCallback = (player:Player)->()

return function(part : BasePart, onTouchStarted : playerWhoTouchedCallback, onTouchEnded : playerWhoTouchedCallback?) : createScriptConnectionToken.ScriptConnection
	local playersTouching : { [Player]:number } = {}

	local onTouchStartedConnection = part.Touched:Connect(function(otherPart : BasePart)
		if otherPart.Parent and not otherPart.Parent:IsA("Model") then
			return
		end

		local player = Players:GetPlayerFromCharacter(otherPart.Parent)
		if not player then
			return
		end

		if not playersTouching[player] then
			playersTouching[player] = 1
			onTouchStarted(player)
		else
			playersTouching[player] += 1
		end
	end)

	local onTouchEndedConnection = part.TouchEnded:Connect(function(otherPart : BasePart)
		if otherPart.Parent and not otherPart.Parent:IsA("Model") then
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
				if onTouchEnded then
					onTouchEnded(player)
				end
            end
		end
	end)

	local onDisconnect = function()
		onTouchStartedConnection:Disconnect()
		onTouchEndedConnection:Disconnect()
	end
	return createScriptConnectionToken(onDisconnect)
end