local lua = lua or require("lua")

local assert = lua.assert
local error = lua.error

local pairs = lua.pairs
local print = lua.print
local rint = lua.rint


assert(require)
assert(_G)
assert(print)
assert(rint)

local tm1 = require("testmod1")

print(tm1.test)
print(tm1.mod2.test)

print("apres os=", os)
print("apres io=", io)
local io = require("io")
print("apres io=", io)

local tm1 = require("testmod1")
print(tm1.test)
print(tm1.mod2.test)

print("=======")
print("_G:")
for k,v in pairs(_G) do
        print("   ", v, k)
end
print("=======")
local package = require("package")
print("package.loaded:")
for k,v in pairs(package.loaded) do
	print("   ", v, k)
end
print("=======")

