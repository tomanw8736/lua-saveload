local SaveLoad = require('tom-saveload')

local loadedData = SaveLoad:loadData('save.lua')
if loadedData then
    print(loadedData.name)
    print(loadedData.level)
end