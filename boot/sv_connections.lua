-----------------------------------------------------------
---                       EVENTS                        ---
-----------------------------------------------------------
RegisterNetEvent("RetrieveSteamID")
AddEventHandler("RetrieveSteamID", function(steamIdentifier)
    local identifiers = GetPlayerIdentifiers(source)

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            print("            " .. steamIdentifier)
            break
        end
    end

    if not steamIdentifier then
        CancelEvent()
        DropPlayer(source, "SteamID not found. Log into Steam prior to opening FiveM. Otherwise contact an admin on our Discord: https://Discord.gg/VkfD2")
    end
end)