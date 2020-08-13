-----------------------------------------------------------
---                     VARIABLES                       ---
-----------------------------------------------------------
local cam = nil
local campos = vector3(-316.741, -80.428, 140.174)

-- Preset spawns:
local airport_spawn = exports.spawnmanager:addSpawnPoint({
    x = -1044.849,
    y = -2750.284,
    z = 21.363,
    heading = 335.336,
    model = 'a_m_m_hillbilly_02',
    idx = 1
})

local hospital_spawn = exports.spawnmanager:addSpawnPoint({
    x = 297.756,
    y = -584.471,
    z = 43.261,
    heading = 84.678,
    model = GetEntityModel(GetPlayerPed(-1)), -- Gets what the model looks like at time of death
    idx = 3
})

-----------------------------------------------------------
---                   NUI CALLBACKS                     ---
-----------------------------------------------------------
RegisterNUICallback('NUIFocusOff', function(data)
    show_nui(false)
end)

RegisterNUICallback('new_character', function(data)
    exports.spawnmanager:spawnPlayer(1, function() 
        SetNuiFocus(false, false)
        toggle_cam(false)
    end)
    
    TriggerServerEvent("sr:newcharacter", data.first_name, data.last_name, data.appearance) -- Data is passed in through callback
end)

RegisterNUICallback('invalid_input', function(data, cb)
    TriggerEvent("chat:addMessage", {
        color = {255, 0, 255},
        multiline = true,
        args = {'[6ixRP]', "Invalid Input!\nMake sure that all inputs are filled!"}
    })
    SetNuiFocus(true, true)
end)

-----------------------------------------------------------
---                        MAIN                         ---
-----------------------------------------------------------
exports.spawnmanager:spawnPlayer(1, function(spawn) -- function when player spawns
    Citizen.CreateThread(function()
        toggle_cam(true)
        show_nui(true)
    end)
end)

-- Where to spawn on death
exports.spawnmanager:setAutoSpawnCallback(function()
    exports.spawnmanager:spawnPlayer(hospital_spawn)
end)

exports.spawnmanager:setAutoSpawn(true) -- Allow player to spawn when they are dead

-----------------------------------------------------------
---                     FUNCTIONS                       ---
-----------------------------------------------------------
function show_nui(bool) 
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        ui = "main_menu",
        status = bool,
    })
end

function toggle_cam(bool)
    if bool then
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", campos.x, campos.y, campos.z, 0, 0, 213.121, GetGameplayCamFov())
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, false)
        SetCamAffectsAiming(cam, false)
    else
        RenderScriptCams(false, false, 0, true, false)
    end
end