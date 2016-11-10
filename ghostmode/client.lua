ghostVehicles = {}


addEvent("toggleGhostMode",true)

function toggleGhostMode(obj,mode)
	if mode == true then
		for theKey,theVehicle in ipairs(getElementsByType("vehicle")) do
			setElementCollidableWith(obj, theVehicle,false)
			setElementAlpha(obj, 200)
		end
		table.insert ( ghostVehicles, obj )
		
	end
	if mode == false then
		for theKey,theVehicle in ipairs(getElementsByType("vehicle")) do
			setElementCollidableWith(obj, theVehicle,true)
			setElementAlpha(obj, 255)
		end
		
		
		
		for index, vehicle in ipairs ( ghostVehicles ) do
			if ( obj == vehicle ) then
				table.remove ( ghostVehicles, index )
			end
		end
		
		
		
	end
end
addEventHandler("toggleGhostMode",root, toggleGhostMode,true)




function ghostmodeCheck()
	for theKey,theVehicle in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(theVehicle) then
			for theKey,theGhost in ipairs(ghostVehicles) do
				if isElementStreamedIn(theGhost) then
					setElementCollidableWith(theGhost,theVehicle,false)
				end
			end
		end
	end
end
setTimer(ghostmodeCheck,3000,0)