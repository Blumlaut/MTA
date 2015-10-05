function getTeamChatTexts(msg,msgtype)
if msgtype == 2 then -- if Msgtype == Teamchat
hisTeam = getPlayerTeam(source)
hisTeamName = getTeamName(hisTeam)
if getTeamName(getPlayerTeam(source)) ~= "Staff" then -- replace "STAFF" With the Admin Group, the one that shouldnt be monitor-able
players = getElementsByType("player")
tcr,tcg,tcb = getTeamColor(getPlayerTeam(source))
for theKey,thePlayer in ipairs(players) do -- basic loop
if ( hasObjectPermissionTo ( thePlayer, "command.SuperSecretAdmin",false ) ) then -- double checking because mta logic
if hasObjectPermissionTo(thePlayer, "command.SuperSecretAdmin",true) then -- double checking because mta logic

if hisTeam == getPlayerTeam(thePlayer) then
return
end

outputChatBox(""..getTeamName(getPlayerTeam(source)).."#FFFFFF:"..getPlayerName(source)..": "..msg.."", thePlayer, tcr,tcg,tcb, true )
end
end
end
end
end
end
addEventHandler("onPlayerChat", root, getTeamChatTexts)
