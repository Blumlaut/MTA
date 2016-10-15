local lightRadius = 3 * getElementRadius(localPlayer) -- dont touch this
local lightBrightness = 90 -- the brightness, 0 = Black, 255 = Completely white, see code below 


function table.removeValue(theTable,value)
	for index, tableVal in ipairs(theTable) do
		if tableVal == value then
			table.remove(theTable,index)
		end
	end
end
function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element ) -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1] -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z -- Return the transformed point
end

local streamedInCars = {}
function onCarStreamIn()
	if getElementType(source) ~= "vehicle" then return end
	if getVehicleType(source) ~= "Automobile" then return end
	table.removeValue(streamedInCars,source)
	table.insert(streamedInCars,source)
end
addEventHandler("onClientElementStreamIn",root,onCarStreamIn)

function onCarStreamOut()
	if getElementType(source) ~= "vehicle" then return end
	destroyDataElement(source,"light1")
	destroyDataElement(source,"light2")
	destroyDataElement(source,"light3")
	destroyDataElement(source,"light4")
	destroyDataElement(source,"light5")
	table.removeValue(streamedInCars,source)
end
addEventHandler("onClientElementStreamOut",root,onCarStreamOut)
addEventHandler("onClientElementDestroy",root,onCarStreamOut)



function addAllStreamedInCars()
	for _, veh in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(veh) and getVehicleType(veh) == "Automobile" then
			table.insert(streamedInCars,veh)
		end
	end
end
addAllStreamedInCars()

function destroyDataElement(element,data)
	if not element or not isElement(element) then return end
	if not getElementData(element,data) then return end
	if isElement(getElementData(element,data)) then
		destroyElement(getElementData(element,data))
	end
	setElementData(element,data,false,false)
end

function destroyCoronaElement(element,data)
	if not element or not isElement(element) then return end
	if not getElementData(element,data) then return end
	if isElement(getElementData(element,data)) then
		exports.custom_coronas:destroyCorona(getElementData(element,data))
	end
	setElementData(element,data,false,false)
end



function handleAllVehicles()
	for _, veh in ipairs(streamedInCars) do
		lightingFix(veh)
	end
end
addEventHandler("onClientPreRender",root,handleAllVehicles)



function lightingFix(veh)
	
	if veh and not getElementData(veh, "light1") then
		vx,vy,vz = getElementPosition(veh)
		
		setElementData(veh, "light1", createLight(0, 0,0,0, lightRadius, lightBrightness, lightBrightness, lightBrightness, 0, 0, 0,true ),false)
		setElementData(veh, "light2", createLight(0, 0,0,0, lightRadius, lightBrightness, lightBrightness, lightBrightness, 0, 0, 0,true ),false)
		setElementData(veh, "light3", createLight(0, 0,0,0, lightRadius, lightBrightness, lightBrightness, lightBrightness, 0, 0, 0,true ),false)
		setElementData(veh, "light4", createLight(0, 0,0,0, lightRadius, lightBrightness, lightBrightness, lightBrightness, 0, 0, 0,true ),false)
		setElementData(veh, "light5", createLight(0, 0,0,0, lightRadius, lightBrightness, lightBrightness, lightBrightness, 0, 0, 0,true ),false)
		
		
		attachElements(getElementData(veh, "light1"), veh, 2, 0, 0)
		attachElements(getElementData(veh, "light2"), veh, -2, 0, 0)
		attachElements(getElementData(veh, "light3"), veh, 0, 0, 2)
		attachElements(getElementData(veh, "light4"), veh, 0, 3, 0)
		attachElements(getElementData(veh, "light5"), veh, 0, -3.3, 0)
	end
end