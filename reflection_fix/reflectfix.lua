local lightRadius = 3 * getElementRadius(localPlayer)
local light1 = createLight(0, 0,0,0, lightRadius, 140, 140, 140, 0, 0, 0,true )
local light2 = createLight(0, 0,0,0, lightRadius, 140, 140, 140, 0, 0, 0,true )
local light3 = createLight(0, 0,0,0, lightRadius, 140, 140, 140, 0, 0, 0,true )
local light4 = createLight(0, 0,0,0, lightRadius, 140, 140, 140, 0, 0, 0,true )
local light5 = createLight(0, 0,0,0, lightRadius, 140, 140, 140, 0, 0, 0,true )


 

local function updateLightPositions()
if isPedInVehicle(localPlayer) then
theVeh = getPedOccupiedVehicle(localPlayer)
if theVeh then
vx,vy,vz = getElementPosition(theVeh)
attachElements(light1, theVeh, 2, 0, 0)
attachElements(light2, theVeh, -2, 0, 0)
attachElements(light3, theVeh, 0, 0, 2)
attachElements(light4, theVeh, 0, 3, 0)
attachElements(light5, theVeh, 0, -3, 0)
--setElementPosition(light1, vx,vy,vz+2)
--setElementPosition(light2, vx+2,vy,vz)
--setElementPosition(light3, vx-2,vy,vz)
--setElementPosition(light4, vx,vy+3,vz)
--setElementPosition(light5, vx,vy-3,vz)
end

end
end
addEventHandler("onClientRender", root, updateLightPositions)