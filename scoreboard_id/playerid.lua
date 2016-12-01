local availableID = { } -- Create the table that specifies which id's are available.
local scoreboard
local _dxver
local _initp = true
local _loaded = false


function Init ()
	if ( getResourceFromName ( "scoreboard" ) and getResourceState ( getResourceFromName ( "scoreboard" ) ) == "running" ) then
		scoreboard = exports.scoreboard
		_dxver = false
	elseif ( getResourceFromName ( "dxscoreboard" ) and getResourceState ( getResourceFromName ( "dxscoreboard" ) ) == "running" ) then 
		scoreboard = exports.dxscoreboard
		_dxver = true
	else
		outputDebugString ( "No scoreboard resource has been started", 2 )
		_initp = false
	end 
	if _initp then
		scoreboard:addScoreboardColumn ( "ID", getRootElement(), 1, 0.05 ) -- Add the ID column
		sortScoreboard( "ID" )
	end 
	if not _loaded then
		loadID()
	end 
end
addEventHandler ( "onResourceStart", resourceRoot, Init )

function loadID ()
	_loaded = true
	local max_players = getMaxPlayers()
	for i = 1, max_players do
		table.insert ( availableID, i, true ) -- Populate the table.
	end
	for _, player in ipairs ( getElementsByType ( "player" ) ) do
		assignPlayerID ( player ) -- Assign an id to all players.
	end 
end 

function checkStoppedResource ( resource )
	local rname = getResourceName ( resource )
	local sres = tostring ( scoreboard ):gsub( "exports.","" )
	if ( rname:lower() == sres:lower() ) then
		outputChatBox ( "falsed" )
		_initp = false
	end
end
addEventHandler ( "onResourceStop", getRootElement(), checkStoppedResource )

function checkStartedResource ( resource )
	if ( getResourceName ( resource ) == "scoreboard" or "dxscoreboard" and source ~= getResourceRootElement() ) then
		Init()
	end
end
addEventHandler ( "onResourceStart", getRootElement(), checkStartedResource )--]]

function sortScoreboard( column )
	if _dxvera and _initp then
		scoreboard:scoreboardSetSortBy ( column, true, getRootElement() )
	end 
end 

function onJoin () -- Player joined --> assign ID.
	assignPlayerID ( source )
end
addEventHandler ( "onPlayerJoin", getRootElement(), onJoin) 

function assignPlayerID ( player )
	local s_id = 1 -- start at one
	while ( isIDAvailable ( s_id ) == false ) do -- is it available? if not, +1 & repeat.
		s_id = s_id + 1
	end
	setElementData ( player, "ID", s_id ) -- available -> assign the ID to the player.
	sortScoreboard( "ID" )
	availableID[ s_id ] = false -- set the id as not available.
end 

function isIDAvailable ( id ) -- checks if the id is used or not.
	return availableID[id]
end 

function onLeave () -- player left, remove ID, set as available.
	local s_id = getElementData ( source, "ID" )
	availableID[ s_id ] = true
	removeElementData ( source, "ID" ) 
end
addEventHandler ( "onPlayerQuit", getRootElement(), onLeave ) 

function removeData ( ) -- resource stopped, clear everything.
	for k, players in ipairs ( getElementsByType ( "player" )) do
		removeElementData ( players, "ID" )
	end
	availableID = { }
end 
addEventHandler ( "onResourceStop", resourceRoot, removeData )

function getNameMatches ( player_name )
	i = 1
	local matchingPlayers = { }
	if ( player_name ) then
		for k, player in ipairs ( getElementsByType ( "player" ) ) do
			local player_n = getPlayerName ( player )
			local match = string.find ( string.lower( player_n ), string.lower ( player_name ) )
			if ( match ) then
				table.insert ( matchingPlayers, i, player )
				i = i + 1
			end
		end
		if ( #matchingPlayers == 1 ) then
			return true, matchingPlayers[1]
		elseif ( #matchingPlayers > 1 ) then
			return true, matchingPlayers
		else
			return false, "None"
		end 
	else
		return false, "Please enter a player name"
	end 
end 

function getPlayerFromPartialName ( source, player_name, script )
	if ( player_name ) then
		local sucess, value = getNameMatches ( player_name )
		if ( sucess ) then
			local matches = ( type ( value ) == "table" ) and #value or 1
			if ( matches == 1 ) then
			if ( script ) then return value else
					local player_nick = getPlayerName ( value )
					local player_id = getElementData ( value, "ID" )
					outputChatBox ( "(" .. player_id .. ") " .. player_nick, source, 255, 255, 0 )
				end 
			else 
				outputChatBox ( "Players matching your search are: ", source, 255, 255, 0 )
				for k, player in ipairs ( value ) do
					local player_nick = getPlayerName ( value[k] )
					local player_id = getElementData ( value[k], "ID" )
					outputChatBox ( "(" .. player_id .. ") " .. player_nick, source, 255, 255, 0 )
				end
				return true, true
			end 
		else
		if ( script ) then return false else
				outputChatBox ( "Players matching your search are: ", source, 255, 255, 0 )
				outputChatBox ( value, source, 255, 0, 0 )
			end 
		end
	end
end 

function getPlayerFromID ( id )
	for k, player in ipairs ( getElementsByType ( "player" ) ) do
		local p_id = getElementData ( player, "ID" )
		if ( p_id == tonumber(id) ) then
			player_n = getPlayerName ( player )
			return player, player_n
		end
	end
	return false, "No player has been found with the ID " .. id .. "."
end 

function getPlayer ( source, input )
	if ( tonumber ( input ) ) then
		local player, playername = getPlayerFromID ( tonumber(input) )
		if ( player ) then
			return player
		else
			outputChatBox ( playername, source, 255, 0, 0 ) -- in this case, playername carries the error. It's just to minimize the amount of code if an error is ecountered.
			return false
		end
	else
		local player, multiple = getPlayerFromPartialName ( source, input, true )
		if ( player and not multiple ) then
			return player
		elseif ( player and multiple ) then
			return false 
		else
			outputChatBox ( "Player not found", source, 255, 0, 0 )
			return false
		end
	end
end

function processIDCommands ( source, command, input )
	if ( tonumber ( input ) ) then
		local player, playername = getPlayerFromID ( tonumber(input) )
		if ( player ) then
			outputChatBox ( "Player that matches that id: ", source, 255, 255, 0 )
			outputChatBox ( "(" .. input .. ") " .. playername, source, 255, 255, 0, true )
		else
			outputChatBox ( playername, source, 255, 0, 0 ) -- in this case, playername carries the error. It's just to minimize the amount of code if an error is ecountered.
		end
	else
		local player = getPlayer ( source, input )
		if ( player ) then
			outputChatBox ( "Player that matches that id: ", source, 255, 255, 0 )
			outputChatBox ( "(" .. tostring ( getElementData ( player, "ID" ) ) .. ") " .. getPlayerName ( player ), source, 255, 255, 0, true )
		end 
	end
end 
addCommandHandler ( "id", processIDCommands )

