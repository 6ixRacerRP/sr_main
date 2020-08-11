-----------------------------------------------------------
---                        MAIN                         ---
-----------------------------------------------------------
TriggerServerEvent("SendSteamID")

RegisterNetEvent("GetSteamID")
AddEventHandler("GetSteamID", function(steamIdentifier)
    TriggerServerEvent("AddConnection", steamIdentifier)
end)