local ActionSystem = {
	actions = {},
}

function ActionSystem.registerAction(name, action)
	ActionSystem.actions[name] = action
end

function ActionSystem.executeAction(name, grid, ...)
	if ActionSystem.actions[name] then
		return ActionSystem.actions[name].execute(grid, ...)
	end
end

return ActionSystem
