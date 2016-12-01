

function fileRecieve(responseData,errno)
	dlDone(responseData)
	
end
winvis = 0


function closeWin()
	if source == acceptbtn then
		guiSetVisible(newswin, false)
		winvis = 0
		showCursor(false,false)
		removeEventHandler("onClientFileDownloadComplete", root, dlDone)
		
	end
end

function showNews()
	if winvis == 0 then
		dlDone()
	end
	
end
addCommandHandler("news", showNews,false,false)



function dlDone()
	if winvis == 0 then
		loadedFile = fileOpen("news.txt")
		content = fileRead(loadedFile, 99999 )
		fileClose(loadedFile)
		guiSetText(newsmemo, content)
		guiSetVisible(newswin, true)
		showCursor(true,true)
	elseif winvis == 1 then
		guiSetVisible(newswin, false)
		showCursor(false,false)
	end
end

function showEditNews()
	
	loadedFile = fileOpen("news.txt")
	cnews = fileRead(loadedFile, 99999 )
	fileClose(loadedFile)
	guiSetText(newsEdit,cnews)
	guiSetVisible(editnewsgui,true)
	
	showCursor(true,true)
	addEventHandler ( "onClientGUIClick", confirmnewsbtn, setNews, false )
	
end


function setNews()
	news = guiGetText(newsEdit)
	triggerServerEvent("updateNewsText", localPlayer, news)
	guiSetVisible(editnewsgui,false)
	showCursor(false,false)
	removeEventHandler ( "onClientGUIClick", confirmnewsbtn, setNews, false )
end
addCommandHandler("setnews", showEditNews,true,false)





addEventHandler("onClientResourceStart", resourceRoot,
function()
	newswin = guiCreateWindow(16, 198, 255, 376, "", false)
	guiWindowSetSizable(newswin, false)
	guiSetAlpha(newswin, 0.66)
	
	newsmemo = guiCreateMemo(9, 23, 236, 261, "", false, newswin)
	guiMemoSetReadOnly(newsmemo, true)
	acceptbtn = guiCreateButton(9, 294, 236, 72, "Got it!", false, newswin)
	guiSetFont(acceptbtn, "default-bold-small")
	guiSetProperty(acceptbtn, "NormalTextColour", "FFAAAAAA") 
	guiSetVisible(newswin,false)
	addEventHandler ( "onClientGUIClick", acceptbtn, closeWin, false )
	
	-- edit news GUI
	
	
	editnewsgui = guiCreateWindow(444, 195, 457, 426, "", false)
	guiWindowSetSizable(editnewsgui, false)
	
	newsEdit = guiCreateMemo(9, 29, 438, 214, "", false, editnewsgui)
	confirmnewsbtn = guiCreateButton(28, 301, 409, 82, "Let's Ro-oll", false, editnewsgui)
	guiSetProperty(confirmnewsbtn, "NormalTextColour", "FFAAAAAA") 
	guiSetVisible(editnewsgui,false)
	
end
)