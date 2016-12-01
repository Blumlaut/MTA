local iTickCount

addEvent("onVehicleNitro", true)

function onVehicleNitro()
	if isPedInVehicle(localPlayer) then
		local pVehicle = getPedOccupiedVehicle(localPlayer)
		if pVehicle and getVehicleUpgradeOnSlot(pVehicle, 8) then 
			local fVelX, fVelY, fVelZ = getElementVelocity(pVehicle)
			if isVehicleNitroActivated(pVehicle) and fVelX ~= 0 and fVelY ~= 0 and fVelZ ~= 0 then 
				if not iTickCount or getTickCount() - iTickCount > 100 then
					iTickCount = getTickCount()
					triggerClientEvent(localPlayer, "onVehicleNitro", localPlayer,pVehicle )
				end
			end
		end
	end
end

addEventHandler("onClientRender", root, onVehicleNitro)