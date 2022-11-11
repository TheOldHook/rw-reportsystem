local display = false
local QBCore = exports["qb-core"]:GetCoreObject()

--COMANDS
RegisterCommand("rapporter", function(source, args, rawCommand)
    SetDisplay(not display)
end)


--CALLBACKS
RegisterNUICallback("main", function(data)
    TriggerEvent('chatMessage', "SYSTEM", {229,217,45}, "Takk for din tilbakemelding " .. GetPlayerName(PlayerId())) --Chat message "Thank you for your feedback"
    title = data['title'][1]
    description = data['description'][2]
    TriggerServerEvent('sendDiscord', data)
    SetDisplay(false) 
end)


RegisterNUICallback("error", function(data)
    chat(data.error, {255,0,0})
    SetDisplay(false)
end)


RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)



Citizen.CreateThread(function() 
    while display do
        Citizen.Wait(0)

        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)


-- FUNCTIONS

function SetDisplay(bool)
    display = bool
    local Player = QBCore.Functions.GetPlayerData()
    local playerId = GetPlayerServerId(PlayerId())
    local playerName = GetPlayerName(PlayerId())
    local PlayerJob = Player.job.label
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type="ui",
        status = bool,
        playerName = playerName,
        playerId = playerId,
        PlayerJob = PlayerJob,
    })
end



function chat(str, color)
    TriggerEvent('chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end