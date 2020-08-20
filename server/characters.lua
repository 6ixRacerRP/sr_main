-----------------------------------------------------------
---                     NET EVENTS                      ---
-----------------------------------------------------------
RegisterNetEvent("sr:newcharacter")
AddEventHandler("sr:newcharacter", function(first_name, last_name, appearance)
    local first_name = first_name
    local last_name = last_name
    local appearance = appearance

    local phone_number = Config.phone_prefix .. tostring(math.random(0, 9999999))

    --[[
        TODO:
        - Make sure nobody can have the same phone number.
    ]]

    local bank = Config.money.bank
    local cash = Config.money.cash

    local owner = GetSteamID(source)

    MySQL.ready(function()
        addNewCharacterToDB(first_name, last_name, appearance, phone_number, bank, cash, owner)
    end)
end)

RegisterNetEvent("sr:sv_loadcharacters")
AddEventHandler("sr:sv_loadcharacters", function()
    local steamid = GetSteamID(source)
    local player = source

    MySQL.ready(function()
        MySQL.Async.fetchAll("SELECT * FROM characters WHERE owner = @steamid", {
            ['@steamid'] = steamid
        }, function(result)
            local playerCharacters = {}

            for _, entry in ipairs(result) do
                table.insert(playerCharacters, entry)
            end

            TriggerClientEvent("sr:cl_loadcharacters", player, playerCharacters)
        end)
    end)
end)

RegisterNetEvent("sr:sv_numcharacters")
AddEventHandler("sr:sv_numcharacters", function()
    local steamid = GetSteamID(source)
    local player = source
    local numCharacters = 0;

    MySQL.ready(function()
        MySQL.Async.fetchAll("SELECT * FROM characters WHERE owner LIKE @steamid",
        {
            ['@steamid'] = steamid
        }, function(result)
            for _, entry in ipairs(result) do
                numCharacters = numCharacters + 1
            end

            TriggerClientEvent("sr:cl_numcharacters", player, numCharacters)
        end)
    end)
end)

-----------------------------------------------------------
---                     FUNCTIONS                       ---
-----------------------------------------------------------
function addNewCharacterToDB(first_name, last_name, appearance, phone_number, bank, cash, owner) 
    MySQL.Async.execute('INSERT INTO characters (first_name, last_name, appearance, phone_number, bank, cash, owner) VALUES (@first_name, @last_name, @appearance, @phone_number, @bank, @cash, @owner)',
    { 
        ['first_name'] = first_name, 
        ['last_name'] = last_name, 
        ['appearance'] = appearance,
        ['phone_number'] = phone_number,
        ['bank'] = bank,
        ['cash'] = cash,
        ['owner'] = owner
    }, 
    function(result)
        print("Added new character: " .. first_name .. " " .. last_name .. " " .. phone_number)
    end)
end