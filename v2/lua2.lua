local m = {} -- the module

local newenv = {}
newenv._VERSION = _G._VERSION
package.loaded["lua"] = _G
--newenv.lua = _G
newenv._G = newenv
newenv.require = require
newenv.assert = assert
newenv.error = error

--newenv.lua._G = nil


--local lua = newenv.lua
local lua = _G

local autoinstall = true

local _require = require
local _error = error
local _pcall = pcall
local _setfenv = setfenv

local function rint(...)
	local lua = _require("lua")
	local tostring = lua.tostring
	local ipairs = lua.ipairs
	local items = {}
	for i,v in ipairs({...}) do
		items[#items+1] = tostring(v)
	end
	local table = _require("table")
	local text = table.concat(items, "\t")
	local io = _require("io")
	io.stdout:write(text.."\n")
end
lua.rint = rint
--newenv.print = print

local function ecall(env, cmd, ...)
	local env = env or newenv
	local f = _setfenv(cmd, newenv)
	local status, ret = _pcall(f, ...)
	if not status then
		_error(ret)
	end
	return ret
end

local function removemodule()
	coroutine = nil
	debug = nil
	file = nil
	io = nil
	math = nil
	os = nil
	package = nil
	string = nil
	table = nil
end

local installed = false

local function install()
	if not installed then
		removemodule()
		installed = true
	end
	return installed
end
local function init()
	install()
	return true
end

if autoinstall then
	install()
end
m.ecall = ecall
m.env   = newenv
m.init  = init

-- allow to call directly the module like the ecall function (with autoinstall)
local mt = getmetatable(m) or {}
mt.__call = function(...)
	init()
	return ecall(...)
end
setmetatable(m, mt)

return m
