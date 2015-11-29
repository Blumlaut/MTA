function clientGetPlayerSerial(client, thePlayer)
local serial = getPlayerSerial(thePlayer)
triggerClientEvent(client, "clientGetPlayerSerialCallBack", client, serial)

end
addEvent("clientGetPlayerSerial",true)
addEventHandler("clientGetPlayerSerial", root, clientGetPlayerSerial)
