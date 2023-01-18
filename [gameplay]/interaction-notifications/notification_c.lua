local latestNotificationId = nil

function sendInteractionNotification(Subject, String)
    if latestNotificationId ~= nil then
        RemoveNotification(latestNotificationId)
    end

    SetNotificationTextEntry("STRING")
    AddTextComponentString(String)
    latestNotificationId = SetNotificationMessage("CHAR_FLOYD", "interaction", true, 8, "Interaction", Subject, String)
    DrawNotification(true, false)
end
