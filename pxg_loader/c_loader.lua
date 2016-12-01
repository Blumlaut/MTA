
-- A Small downloader that i rushed to make as a request for a friend, might be buggy, feel free to edit and re-release
-- just credit me please


localPlayer = getLocalPlayer()


GUIEditor = {
	dlwin = {},
	dllabel = {}
}

local screenWidth, screenHeight = guiGetScreenSize ( )
--addEvent("showdlstatus", true )
--addEventHandler("showdlstatus", localPlayer, statustext )

rroot = getResourceRootElement(getThisResource())
addEventHandler('onClientResourceStart', rroot,
function()
	
	downloadTXDs()
	
	
end
)




function downloadTXDs( )
	
	dlwin = guiCreateWindow(1072, 484, 290, 80, "Phoenix Gaming Downloader V1.2", false)
	guiWindowSetSizable(dlwin, false)
	
	dllabel = guiCreateLabel(23, 33, 257, 30, "Waiting..", false, dlwin)
	sizelabel = guiCreateLabel(5, 53, 93, 20, "", false, dlwin) 
	
	
	
	-- download the skins
	downloadFile("2.txd") 
	downloadFile("2.dff") 
	
end


function replaceTXDs(file, success)
	if ( source == resourceRoot ) then
		if ( success ) then
			
			guiSetText(dllabel, "Lade: "..file.." " )
			outputConsole("Downloaded "..file.." ", localPlayer )
			if ( file == "2.dff" ) then -- be sure to update this line
				
				-- Replace the downloaded files
				
				txd = engineLoadTXD ( "2.txd")
				engineImportTXD ( txd, 2)		
				dff = engineLoadDFF ( "2.dff", 2)
				engineReplaceModel ( dff, 2)
				
				
				
				
				
				--vanishgui(localPlayer)
				triggerEvent( "hidedlgui", getLocalPlayer())
				
			end
		else
			outputChatBox ( "Additional Textures Failed to Download, restarting.." )
			downloadTXDs()
		end
	end	
end
addEventHandler("onClientFileDownloadComplete", root, replaceTXDs )



function vanishgui()
	guiSetVisible( dlwin, false )
	if guiGetVisible( dlwin ) == true then guiSetVisible( dlwin ) end
	if guiGetVisible( dllabel ) == true then guiSetVisible( dllabel ) end
	guiSetVisible( dllabel, false )
	guiSetVisible( sizelabel, false )
end
addEvent("hidedlgui", true )

addEventHandler("hidedlgui", getRootElement(), vanishgui )