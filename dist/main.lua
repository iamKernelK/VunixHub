-- هذا الملف يعمل كمجمع لبقية الملفات في مستودعك
local src = script.Parent.Parent:WaitForChild("src")
local Lib = require(src:WaitForChild("Main"))
return Lib

