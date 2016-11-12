ghostVehicles = {}


addEvent("toggleGhostMode",true)

function toggleGhostMode(obj,mode)
	if not obj then return end
	if mode == true then
		for theKey,theVehicle in ipairs(getElementsByType("vehicle")) do
			if not theVehicle or not obj then return end
			setElementCollidableWith(obj, theVehicle,false)
			setElementAlpha(obj, 200)
		end
		table.insert ( ghostVehicles, obj )
		
	end
	if mode == false then
		for theKey,theVehicle in ipairs(getElementsByType("vehicle")) do
			if not theVehicle or not obj then return end
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

addEvent("recieveGhostList",true)

function recieveGhostList(list)
	
	
	ghostVehicles = list
	
end
addEventHandler("recieveGhostList", root, recieveGhostList)

function resourceStartHandler(resource)
	if resource == getThisResource() then
		
		
		triggerServerEvent("requestGhostList", resourceRoot, localPlayer)
		
	end
end
addEventHandler("onClientResourceStart",root, resourceStartHandler)

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