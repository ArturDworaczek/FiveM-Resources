function printSpeedText(Speed) 
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(0.4,0.4)
    SetTextEntry("STRING")
    AddTextComponentString(Speed .. " kmph")
    DrawText(0.175,0.9)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        DisplayAreaName(true)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            DisplayRadar(true)
            printSpeedText(math.floor(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6))
        else
            DisplayRadar(false)
        end
    end
end)