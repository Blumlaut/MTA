function enableSafeCLIENT()
playerBlood = getElementData(localPlayer, "blood")
playerTimer = setTimer(function()

toggleControl( "fire", false)
toggleControl( "zoom_in", false)
toggleControl( "vehicle_fire", false)
setElementData(localPlayer, "blood", playerBlood, true)
end, 500, 0 )



end
addEvent("enableSafeClient", true)
addEventHandler("enableSafeClient", root, enableSafeCLIENT)

function disableSafeCLIENT()
killTimer(playerTimer)
toggleControl("fire", true)
toggleControl("zoom_in", true)
toggleControl("aim_weapon", true)
toggleControl("vehicle_fire", true)
end
addEvent("disableSafeClient", true)
addEventHandler("disableSafeClient", root, disableSafeCLIENT)
