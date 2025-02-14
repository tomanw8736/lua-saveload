--------------------------
---    💾 Save/Load    ---
--------------------------
-- TODO:
-- - Use logger.lua for logging!
-- - Rewrite for more simple/lightweight functionality

SaveLoad = {}
SaveLoad.__index = SaveLoad

-- saving
function SaveLoad:saveData(filename, data) -- filename = 'save.lua' | data = {data}
    local file = io.open(filename, 'w') -- open the file for writing the save data
    if not file then -- if any problems occur
        print('ERROR:  Error occured with saving file!')
        return false
    end

    -- convert 'data' to a string for saving
    local serializedData = "return" .. self:tableToString(data)

    -- save to the file and close file
    file:write(serializedData)
    file:close()
    print('SUCCESS:  Data saved successfully!')
    return true
end

-- tableToString method
function SaveLoad:tableToString(table, indent)
    indent = indent or "" -- setting the indent
    local str = "{\n" -- opening the table
    local nextIndent = indent .. '  ' -- indent after the original

    -- setting keys and values into the string from 'table'
    for k, v in pairs(table) do
        local key = type(k) == 'string' and string.format("[\"%s\"]", k) or "[" .. k .. ']' -- key for the table data

        if type(v) == 'table' then -- if the value is another table
            str = str .. nextIndent .. key .. ' = ' .. self:tableToString(v, nextIndent) .. ',\n'
        elseif type(v) == 'string' then -- if the value is a string
            str = str .. nextIndent .. key .. " = \"" .. v .. "\",\n"
        else -- any other situation :3
            str = str .. nextIndent .. key .. " = " .. tostring(v) .. ",\n"
        end
    end
    
    str = str .. indent .. "}" -- closing the table
    return str -- returning 'str' as the string format of the table
end

-- loading
function SaveLoad:loadData(filename)
    local file = io.open(filename, 'r')
    if not file then -- if the file can't be opened for X reason
        print('ERROR:  Save file not found!')
        return nil
    end

    -- read and execute the file
    local data = file:read('*a') -- read the ENTIRE file
    file:close()

    local chunk = load(data)
    if chunk then -- if the chunk loads successfully
        return chunk() -- returned the saved table
    else
        print('ERROR:  Failed to load the save file!')
        return nil
    end
end

return SaveLoad