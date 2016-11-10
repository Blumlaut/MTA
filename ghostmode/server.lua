ghostTable = {}

function GhostModeCMD(source)
	if getElementData(source, "hasMostWanted") then return end
	if getPedOccupiedVehicle(source) and source == getVehicleOccupant(getPedOccupiedVehicle(source), 0) then
		if getElementData(getPedOccupiedVehicle(source), "ghostmode") then
			toggleGhostModeS(getPedOccupiedVehicle(source),false)
			outputChatBox("Ghost Mode turned OFF",source, 120,120,0)
			setElementData(getPedOccupiedVehicle(source), "ghostmode", false)
			
			for index, vehicle in ipairs ( ghostTable ) do
				if ( getPedOccupiedVehicle(source) == vehicle ) then
					table.remove ( ghostTable, index )
				end
			end
			
		elseif getElementData(getPedOccupiedVehicle(source), "ghostmode") == false then
			toggleGhostModeS(getPedOccupiedVehicle(source),true)
			outputChatBox("Ghost Mode turned ON",source, 120,120,0)
			table.insert ( ghostTable, getPedOccupiedVehicle(source) )
			setElementData(getPedOccupiedVehicle(source), "ghostmode", true)
		end
	end
end
addCommandHandler("ghost",GhostModeCMD,false,false)


function toggleGhostModeS(obj,mode)
	triggerClientEvent(root, "toggleGhostMode",resourceRoot, obj,mode)
end


function elementDestroyHandler()
	if getElementType(source) == "vehicle" then
		toggleGhostModeS(source,false)
	end
end
addEventHandler("onElementDestroy", root, elementDestroyHandler)


function vehicleExitHandler(veh,seat)
	if seat == 0 and getElementData(veh, "ghostmode") then
		toggleGhostModeS(veh,false)
	end
end
addEventHandler("onPlayerVehicleExit", root, vehicleExitHandler)