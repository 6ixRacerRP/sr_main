-----------------------------------------------------------
---                     NET EVENTS                      ---
-----------------------------------------------------------
RegisterNetEvent("sr:newcharacter")
AddEventHandler("sr:newcharacter", function(first_name, last_name, appearance)
    local first_name = first_name
    local last_name = last_name
    local appearance = appearance

    local phone_number = Config.phone_prefix .. tostring(math.random(0, 9999999))

    local bank = Config.money.bank
    local cash = Config.money.cash

    local owner = GetSteamID(source)

    MySQL.ready(function() 
        addNewCharacterToDB(first_name, last_name, appearance, phone_number, bank, cash, owner)
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