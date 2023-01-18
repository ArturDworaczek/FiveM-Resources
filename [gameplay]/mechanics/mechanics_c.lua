local IsInsideBlip = false
local ClosestVehicle = nil

local MechanicLocations = {
    {x = -1156.18, y = -2000.9, z = 13.25},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        for Index, Value in pairs(MechanicLocations) do
            local DistanceToMarker = Vdist2(GetEntityCoords(PlayerPedId(), false), Value.x, Value.y, Value.z)

            if DistanceToMarker < 2000 then
                DrawMarker(36, Value.x, Value.y, Value.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 0, 255, 100, false, true, 2, false, nil, false)
                DrawMarker(27, Value.x, Value.y, Value.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 50, 0, 255, 100, false, true, 2, true, nil, false)
                
                if DistanceToMarker < 0.28 then
                    for Index, Player in ipairs(GetActivePlayers()) do
                        local Ped = GetPlayerPed(Player)

                        if IsPedInAnyVehicle(Ped, false) then
                            ClosestVehicle = GetVehiclePedIsIn(Ped, false)

                            if Vdist2(GetEntityCoords(PedVehicle, false), Value.x, Value.y, Value.z) < 50 then 
                                if not IsInsideBlip then
                                    IsInsideBlip = true
                                    exports["interaction-notifications"]:sendInteractionNotification("Mechanic", "Press 'E' to interact")
                                end
                            end
                        end
                    end
                else 
                    IsInsideBlip = false
                end
            end
        end
	end
end)