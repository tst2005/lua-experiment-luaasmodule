local m = {} -- the module
--m.lua = m -- self link

local autoinstall = true

--local tostring = tostring
--local tonumber = tonumber
local assert = assert
local type = type
local _require = require

local functionsToImport = {
"assert", "collectgarbage", "dofile", "error", "getfenv",
"getmetatable", "ipairs", "load", "loadfile", "loadstring",
"module", "next", "pairs","pcall", "print", "rawequal", "rawget", "rawset",
"require",
"select", "setfenv", "setmetatable", "type",
"tonumber", "tostring",
"unpack", "xpcall",
"gcinfo", "newproxy"
}

local stickyGlobalFunctions = {
["require"]=true,
--["tonumber"]=true,
--["tostring"]=true,
--["print"]=true,
}


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
m.rint = rint


local function copy()
	local lua = m
	for i,f in ipairs(functionsToImport) do
		assert(f, "f !!")
		assert(type(f)=="string", "f is not a string")
--		if not _G[f] then
--			print("global function not exists")
--		else
			lua[f] = _G[f]
--		end
	end
end

local function removeorig()
	for i,f in ipairs(functionsToImport) do
		if not stickyGlobalFunctions[f] then
			assert(f, "f !!")
			_G[f] = nil
		end
	end
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
		--local lua = m
		copy()
		--lua = m -- install the module to global space
		removeorig()
		removemodule()
		installed = true
	end
	return installed
end

if autoinstall then
	install()
else
	m._install = install
end
return m
