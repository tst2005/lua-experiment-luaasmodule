print("avant", io)

--[[

local A = {}
print("A", A)
local mt = getmetatable(A) or {}
setmetatable(A, mt)

lua = {}
lua.tostring = tostring
print(type(lua.tostring), "XX", tostring, lua.tostring)
tostring = nil
assert(lua.tostring)

setfenv(print, lua)

local function TS(a)
	local b = a
	setmetatable(b, nil)
	print(">>", type(a))
	local tostr = setfenv(function(a) return tostring(a) end, lua)
//		return "AAA"
//	return lua.tostring(b)
	return tostr(a)
end


mt.__tostring=TS
print("TS?", A)
os.exit()

]]--

local lua = require("lua")
local require = lua.require
local print = lua.rint

--lua._install()
print("apres", io)
local io = require("io")
print("apres", io)

local tm1 = require("testmod1")
print(tm1.test)
print(tm1.mod2.test)

print("=======")
for k,v in lua.pairs(_G) do
	print(k)
end
print("=======")
local package = require("package")

for k,v in lua.pairs(package.loaded) do
	print(k, v)
end
print("=======")

