local ERROR_ARGUMENTWASNIL = "Attempt to pass a nil argument in function %s"
local ERROR_ARGUMENTWASROGIC = "Attempt to require a module already required in function %s"
local ERROR_MODULEDOESNTEXIST = "Module %s does not exist"

local Rogic = {}
Rogic.__index = Rogic
Rogic.__metatable = "Rogic"

function Rogic.requireModule(moduleName: string): any
	assert(typeof(moduleName) == "string", string.format(ERROR_ARGUMENTWASNIL, "requireModule"))
	assert(moduleName ~= "Rogic", string.format(ERROR_ARGUMENTWASROGIC, "requireModule"))

	local Module = nil

	for _, value in pairs(game:GetDescendants()) do
		if value:IsA("ModuleScript") and value.Name == moduleName then
			Module = value
			break
		end
	end

	if not Module then
		error(string.format(ERROR_MODULEDOESNTEXIST, moduleName), 2)
		return false
	end

	return require(Module) or false
end

function Rogic.getTypeOf(variable: any): any
	return typeof(variable)
end

function Rogic.isAFunction(variable: any): boolean
	return typeof(variable) == "function"
end

function Rogic.error(errorMessage)
		error(errorMessage)
end

function Rogic.getService(ServiceName): any
	return game:GetService(ServiceName) or false
end

function Rogic.createCoroutine<T>(executer: (any) -> T)
	return coroutine.create(executer)
end

return Rogic
