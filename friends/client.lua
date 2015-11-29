addEventHandler("onClientResourceStart", resourceRoot,
    function()
	
	if not xmlLoadFile("friends.xml") then
	friendsXML = xmlCreateFile("friends.xml", "friends")
	xmlSaveFile(friendsXML)
	xmlUnloadFile(friendsXML)
	end
        main_window = guiCreateWindow(0.08, 0.10, 0.25, 0.54, "", true)
        guiWindowSetSizable(main_window, false)

        gridlist = guiCreateGridList(21, 35, 160, 355, false, main_window)
        collumn = guiGridListAddColumn(gridlist, "Friends", 0.9)
        addFriend_openGUI = guiCreateButton(181, 38, 123, 48, "Add Friend", false, main_window)
        guiSetProperty(addFriend_openGUI, "NormalTextColour", "FFAAAAAA")
        removeFriend_btn = guiCreateButton(181, 95, 123, 45, "Remove Friend", false, main_window)
        guiSetProperty(removeFriend_btn, "NormalTextColour", "FFAAAAAA")


        addFriend_main = guiCreateWindow(531, 270, 280, 171, "Add Friend", false)
        guiWindowSetSizable(addFriend_main, false)

        friendName_edit = guiCreateEdit(18, 50, 237, 30, "", false, addFriend_main)
        addFriend_confirm = guiCreateButton(86, 102, 118, 36, "Add", false, addFriend_main)
        guiSetProperty(addFriend_confirm, "NormalTextColour", "FFAAAAAA")    
		username_label = guiCreateLabel(19, 26, 133, 18, "Username:", false, addFriend_main)    
				
        closebtn = guiCreateButton(273, 361, 54, 31, "x", false, main_window)
        guiSetFont(closebtn, "default-bold-small")
        guiSetProperty(closebtn, "NormalTextColour", "FFAAAAAA")    
		
		
		
		guiSetVisible(main_window,false)
		guiSetVisible(addFriend_main,false)
		
		addEventHandler("onClientGUIClick", main_window, clickHandler)
		addEventHandler("onClientGUIClick", addFriend_main, clickHandler)
		
		
		
		drawMessage("Friendslist Loaded!", "online", 18000)
		
		
		
		
    end
)


function playerMatch()
local playerName = getPlayerName(source)

local xml = xmlLoadFile("friends.xml")



thecount = -1
  for _ in pairs(xmlNodeGetChildren(xml)) do
thecount = thecount + 1
  local friendnode = xmlFindChild(xml, "friend",thecount)
  local friendname  = xmlNodeGetValue(xmlFindChild(friendnode, "name",0))
  if friendname == playerName then
  
  drawMessage(""..friendname.." is now Online", "online", 18000)
  
  end

end
xmlUnloadFile(xml)
end
addEventHandler("onClientPlayerJoin", root, playerMatch)


function playerQuitMatch()
local playerName = getPlayerName(source)


local xml = xmlLoadFile("friends.xml")

thecount = -1
  for _ in pairs(xmlNodeGetChildren(xml)) do

thecount = thecount + 1
  local friendnode = xmlFindChild(xml, "friend",thecount)
  local friendname  = xmlNodeGetValue(xmlFindChild(friendnode, "name",0))
  if friendname == playerName then
  
  drawMessage(""..friendname.." is now offline", "offline", 18000)
  
  end


end
xmlUnloadFile(xml)
end
addEventHandler("onClientPlayerQuit", root, playerQuitMatch)




function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function clientGetPlayerSerialCallBack(serial)
serial = serial 
xmlNodeSetValue(xmlserial, serial)
xmlSaveFile(xml)
xmlUnloadFile(xml)
updateGridList()
end
addEvent("clientGetPlayerSerialCallBack", true)
addEventHandler("clientGetPlayerSerialCallBack", root, clientGetPlayerSerialCallBack)

function updateGridList()
guiGridListClear(gridlist)
local xml = xmlLoadFile("friends.xml")



thecount = -1
  for _ in pairs(xmlNodeGetChildren(xml)) do
thecount = thecount + 1
  local friendnode = xmlFindChild(xml, "friend",thecount)
  local friendserial = xmlNodeGetValue(xmlFindChild(friendnode, "serial",0))
  local friendname  = xmlNodeGetValue(xmlFindChild(friendnode, "name",0))
  local row = guiGridListAddRow(gridlist)
  guiGridListSetItemText(gridlist, row, collumn, friendname, false,false)
  
  end
xmlUnloadFile(xml)





end



visible = 0

function showFriendGUI()
if visible == 0 then
visible = 1
updateGridList()
guiSetVisible(main_window,true)
showCursor(true, true)
else
visible = 0
guiSetVisible(main_window,false)
showCursor(false,false)

end
end
addCommandHandler("friends",showFriendGUI)

function removeFriend_func()
if not guiGridListGetSelectedItem(gridlist) then return end
local selectedItem = guiGridListGetSelectedItem(gridlist)
local xml = xmlLoadFile("friends.xml")
  local friendnode = xmlFindChild(xml, "friend",selectedItem)
  local friendserial = xmlNodeGetValue(xmlFindChild(friendnode, "serial",0))
  local friendname  = xmlNodeGetValue(xmlFindChild(friendnode, "name",0))
  xmlDestroyNode(friendnode)
  outputChatBox("Successfully removed "..friendname.." from your Friends!")
  xmlSaveFile(xml)
  xmlUnloadFile(xml)
  updateGridList()


end


function addFriend_func()
if guiGetText(friendName_edit) == "" or not getPlayerFromName(guiGetText(friendName_edit)) then
outputChatBox("You have to enter a valid and online Player!")
guiSetVisible(addFriend_main,false)

else
local friend = getPlayerFromName(guiGetText(friendName_edit))
xml = xmlLoadFile("friends.xml")
xmlchild = xmlCreateChild(xml, "friend" )
xmlserial = xmlCreateSubNode(xmlchild, "serial")
xmlname = xmlCreateSubNode(xmlchild, "name")
xmlNodeSetValue(xmlname, guiGetText(friendName_edit))
triggerServerEvent("clientGetPlayerSerial", localPlayer, localPlayer, friend)
guiSetVisible(addFriend_main,false)

end

end

function clickHandler(btn, state, x,y)
if btn == "left" then

if source == main_window then
return
end

if source == addFriend_openGUI then
guiSetVisible(addFriend_main, true)
end

if source == removeFriend_btn then
removeFriend_func()
end

if source == addFriend_main then
return
end

if source == addFriend_confirm then
addFriend_func()
end

if source == username_label then 
return
end

if source == closebtn then
showFriendGUI()
end


end
end

function drawMessage(text,icon,duration)
DXDRAWMSG = text
DXDRAWICON = icon

addEventHandler("onClientRender", root, dxDrawMSG)

setTimer(function()

removeEventHandler("onClientRender", root, dxDrawMSG)

end, duration,1)



end



local screenW, screenH = guiGetScreenSize()
DXDRAWMSG = ""
DXDRAWICON = ""
    function dxDrawMSG()
        dxDrawLine((screenW * 0.7460) - 1, (screenH * 0.0898) - 1, (screenW * 0.7460) - 1, screenH * 0.1146, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.9780, (screenH * 0.0898) - 1, (screenW * 0.7460) - 1, (screenH * 0.0898) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.7460) - 1, screenH * 0.1146, screenW * 0.9780, screenH * 0.1146, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.9780, screenH * 0.1146, screenW * 0.9780, (screenH * 0.0898) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.7460, screenH * 0.0898, screenW * 0.2321, screenH * 0.0247, tocolor(26, 26, 26, 108), false)
        dxDrawText(DXDRAWMSG, screenW * 0.7638, screenH * 0.0898, screenW * 0.8927, screenH * 0.1146, tocolor(255, 255, 255, 255), 1.10, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawImage(screenW * 0.7485, screenH * 0.0911, screenW * 0.0081, screenH * 0.0234, "images/"..DXDRAWICON..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
