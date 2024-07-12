--!strict
-- type to mirror Roblox's native RBXScriptConnection
-- https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection
export type ScriptConnection = {
	Disconnect : (ScriptConnection)->(),
	Connected : boolean,
}
return function(onDisconnect : ()->()) : ScriptConnection
	local connection : ScriptConnection = {
		Connected = true,

		Disconnect = function(self)
			if not self.Connected then
				return
			end

			onDisconnect()
			self.Connected = false
		end
	}

	return connection
end