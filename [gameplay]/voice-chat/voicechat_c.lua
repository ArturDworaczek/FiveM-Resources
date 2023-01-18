local notificationID = 0
local holdingEnter = false
local holdingPlus = false
local holdingMinus = false
local talking = false

local voiceEnabled = true
local proxDistance = 500.01

function displayText(text, justification, red, green, blue, alpha, posx, posy)
    SetTextFont(4)
    SetTextWrap(0.0, 1.0)
    SetTextScale(1.0, 0.5)
    SetTextJustification(justification)
    SetTextColour(red, green, blue, alpha)
    SetTextOutline()

    BeginTextCommandDisplayText("STRING") -- old: SetTextEntry()
    AddTextComponentSubstringPlayerName(text) -- old: AddTextComponentString
    EndTextCommandDisplayText(posx, posy) -- old: DrawText()
end

function sendVoiceChatNotification(Subject, String)
    RemoveNotification(notificationID)

    SetNotificationTextEntry("STRING")
    AddTextComponentString(String)
    notificationID = SetNotificationMessage("CHAR_FLOYD", "voice", true, 8, "Voice Chat", Subject, String)
    DrawNotification(true, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if voiceEnabled then
            if IsControlPressed(0, 249) then
                if not talking then
                    talking = true

                    sendVoiceChatNotification("~g~Talking", "")
                end
            elseif not IsControlPressed(0, 249) then
                if talking then
                    talking = false

                    RemoveNotification(notificationID)
                else
                    if IsControlPressed(0, 96) then
                        if not holdingPlus then
                            holdingPlus = true
                            if proxDistance == 200.01 then
                                proxDistance = 500.01

                                sendVoiceChatNotification("Tone", "Casual")
                            elseif proxDistance == 500.01 then
                                proxDistance = 2500.01

                                sendVoiceChatNotification("Tone", "~r~Shouting")
                            else
                                proxDistance = 200.01

                                sendVoiceChatNotification("Tone", "~b~Whispering")
                            end
                        end
                    else
                        holdingPlus = false
                    end

                    if IsControlPressed(0, 97) then
                        if not holdingMinus then
                            holdingMinus = true
                            if proxDistance == 200.01 then
                                proxDistance = 2500.01

                                sendVoiceChatNotification("Tone", "~r~Shouting")
                            elseif proxDistance == 500.01 then
                                proxDistance = 200.01

                                sendVoiceChatNotification("Tone", "~b~Whispering")
                            else
                                proxDistance = 500.01
                                
                                sendVoiceChatNotification("Tone", "Casual")
                            end
                        end
                    else
                        holdingMinus = false
                    end
                end
            end
        end

        if not talking then
            if IsControlPressed(0, 201) then
                if not holdingEnter then
                    holdingEnter = true
                    if voiceEnabled then
                        sendVoiceChatNotification("Activation", "~r~Disabled")
                        voiceEnabled = false
                    else
                        sendVoiceChatNotification("Activation", "~g~Enabled")
                        voiceEnabled = true
                    end
                end
            else
                holdingEnter = false
            end
        end

        NetworkSetTalkerProximity(proxDistance)
        NetworkClearVoiceChannel()
        NetworkSetVoiceActive(voiceEnabled)
    end
end)