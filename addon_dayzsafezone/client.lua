function enableSafeCLIENT()
	playerBlood = getElementData(localPlayer, "blood")
	setElementData(localPlayer, "god", true)
	playerTimer = setTimer(function()
		
		toggleControl( "fire", false)
		toggleControl( "zoom_in", false)
		toggleControl( "vehicle_fire", false)
		toggleControl( "action", false)
		setElementData(localPlayer, "blood", playerBlood, true)
	end, 500, 0 )
	
	
	
end
addEvent("enableSafeClient", true)
addEventHandler("enableSafeClient", root, enableSafeCLIENT)

function disableSafeCLIENT()
	killTimer(playerTimer)
	toggleControl("fire", true)
	setElementData(localPlayer, "god", false)
	toggleControl("zoom_in", true)
	toggleControl("aim_weapon", true)
	toggleControl("vehicle_fire", true)
	toggleControl("action", true)
end
addEvent("disableSafeClient", true)
addEventHandler("disableSafeClient", root, disableSafeCLIENT)

if devmode == 1 then
	setDevelopmentMode(true)
else
	setDevelopmentMode(false)
	
end

function checkGodMode()
	if getElementData(localPlayer, "god") then
		outputChatBox("God Active")
	else
		outputChatBox("Got Inactive")
	end
	addCommandHandler("godCheck", checkGodMode)
end