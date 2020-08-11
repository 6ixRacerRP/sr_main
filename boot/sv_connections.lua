-----------------------------------------------------------
---                       EVENTS                        ---
-----------------------------------------------------------
RegisterNetEvent("AddSteamIDToDB")
AddEventHandler("AddSteamIDToDB", function()
    local steamIdentifier = GetSteamID(source)

    if not steamIdentifier then
        CancelEvent()
        DropPlayer(source, "SteamID not found. Log into Steam prior to opening FiveM. Otherwise contact an admin on our Discord: https://Discord.gg/VkfD2")
    else
        addToConnectionDB(steamIdentifier)
    end
end)

-----------------------------------------------------------
---                      FUNCTIONS                      ---
-----------------------------------------------------------
function addToConnectionDB(steamIdentifier)
    MySQL.Async.fetchAll('SELECT 1 FROM connections WHERE steamid=\"' .. steamIdentifier .. "\"", {}, function(result)
        encoded_result = json.encode(result)
        if (encoded_result == "[]") then -- The steamid does not exist
            MySQL.Async.execute('INSERT INTO connections (steamid) VALUES ("' .. steamIdentifier .. '")', {}, function(result) 
                print("New Connection: " .. steamIdentifier)
            end)
        else
            print("Already Registered Connection: " .. steamIdentifier)
        end
    end)
end

function GetSteamID(source)
    local identifiers = GetPlayerIdentifiers(source)

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            return v
        end
    end
end