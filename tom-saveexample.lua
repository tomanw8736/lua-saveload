local SaveLoad = require('tom-saveload')
local myData = {
    name = 'Hero',
    level = 1,
    skills = {
        -- blah blah
    },
    inventory = {
        -- items
    }
}
-- save the data
SaveLoad:saveData('save.lua', myData)