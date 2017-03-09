local m = {}

m.test = "testmod1"

local require = require or lua.require
local mod2 = require("testmod1b")

m.mod2 = mod2

return m
