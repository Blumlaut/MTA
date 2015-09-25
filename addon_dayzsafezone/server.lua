safezone = createColSphere(2090.75049,  -112.47958, 7.04545, 90)
setElementData(safezone, "safezone", true )

function createSafeZone(fx,fy,fz,fradius)
setElementData(createColSphere(fx,fy,fz,fradius), "safezone", true)
end




setTimer(function()
peds = getElementsWithinColShape(safezone, "ped")
for theKey,thePed in ipairs(peds) do        
	if getElementData(thePed, "zombie") then
	killPed(thePed)

end
end
end, 30000, 0 )






function onSafeEnable(thePlayer, matchingdim)
if getElementType ( thePlayer ) == "player" and getElementData(source, "safezone") then 
playerName = getPlayerName(thePlayer)
outputChatBox("You entered the Safezone, report griefers at our Forums or Ingame!", thePlayer, 255, 255, 255, false)

setElementData(thePlayer, "safezone", "true")

--outputChatBox(playerTimer, thePlayer)

triggerClientEvent(thePlayer, "enableSafeClient", getResourceRootElement(getThisResource()))
else 
if getElementData(thePlayer, "zombie") then
setElementPosition(thePlayer, 0, 0, -10)
setTimer(function()
killPed(thePlayer)
end, 5000, 1 )
end

end

end
addEventHandler("onColShapeHit", root, onSafeEnable)


function onSafeDisable(thePlayer, matchingdim)
   if getElementType ( thePlayer ) == "player" and getElementData(source, "safezone") then 
   playerName = getPlayerName(thePlayer)
setElementData(thePlayer, "safezone", "false")
   outputChatBox("You left the Safezone, Watch out for Yourself!", thePlayer, 255, 255, 255, false)
	triggerClientEvent(thePlayer, "disableSafeClient", getResourceRootElement(getThisResource()))
   end
end
addEventHandler ( "onColShapeLeave", safezone, onSafeDisable )


