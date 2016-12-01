staffTeam = "Staff"


function toggleTeamSpy(source,cmd)
	if getTeamName(getPlayerTeam(source)) == staffTeam then -- if player is Staff
		if not getElementData(source, "teamSpyEnabled") then
			setElementData(source, "teamSpyEnabled", true)
			outputChatBox("Team Spy toggled ON", source, 255, 255, 255)
			return
		end
	elseif getElementData(source, "teamSpyEnabled") == true then
		setElementData(source, "teamSpyEnabled", false)
		outputChatBox("Team Spy toggled OFF", source, 255, 255, 255)
		
	end
end
addCommandHandler("TTS", toggleTeamSpy)




function getTeamChatTexts(msg,msgtype)
	if msgtype == 2 then -- if Msgtype == Teamchat
		hisTeam = getPlayerTeam(source)
		hisTeamName = getTeamName(hisTeam)
		if getTeamName(getPlayerTeam(source)) ~= staffTeam then
			players = getElementsByType("player")
			tcr,tcg,tcb = getTeamColor(getPlayerTeam(source))
			for theKey,thePlayer in ipairs(players) do -- basic loop
				if ( hasObjectPermissionTo ( thePlayer, "function.banIP",false ) ) then -- double checking because mta logic
					if hasObjectPermissionTo(thePlayer, "function.banIP",true) then -- double checking because mta logic
						
						if hisTeam == getPlayerTeam(thePlayer) then
							return
						end
						
						if getElementData(thePlayer, "teamSpyEnabled") == true then
							
							outputChatBox(""..getTeamName(getPlayerTeam(source)).."#FFFFFF:"..getPlayerName(source)..": "..msg.."", thePlayer, tcr,tcg,tcb, true )
						end
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerChat", root, getTeamChatTexts)