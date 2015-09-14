-- Markers and blips
local LSEM1 = createMarker( 2036.75208, -1408.23230, 16.16406, "cylinder", 2.0, 255, 0, 0, 220 )
local LSEM1BLIP = createBlip( 2036.75208, -1408.23230, 16.16406, 22, 1.0 )

local LSEM2 = createMarker( 1758.83533, -1704.66174, 12.80335, "cylinder", 2.0, 255, 0, 0, 220 )
local LSEM1BLIP = createBlip( 1758.83533, -1704.66174, 13.00335, 22, 1.0 )

local LVEM1 = createMarker( 1600.02771, 1818.82935, 10.12031, "cylinder", 2.0, 255, 0, 0, 220 )
local LVEM1BLIP = createBlip( 1600.02771, 1818.82935, 10.82031, 22, 1 )


local LANDEM1 = createMarker( -315.44632, 1052.51367, 19.84026, "cylinder", 2.0, 255, 0, 0, 220 )
local LVEM1BLIP = createBlip(-315.44632, 1052.51367, 19.84026, 22, 1 )

local SFEM1 = createMarker( -2654.59839, 637.10657, 13.55313, "cylinder", 2.0, 255, 0, 0, 220 )
local SFEM1BLIP = createBlip(-2654.59839, 637.10657, 14.45313, 22, 1 )

local curmoney = getPlayerMoney()


-- ===================== IMPORTANT!!!! CHANGE THE VALUES!!!! ==========================
local money = 800

local armor = 100 

-- armor not over 100!!!

-- ===================== IMPORTANT!!!! CHANGE THE VALUES!!!! ==========================

function LSEM(hitElement)
	if(isElement(hitElement) and getElementType(hitElement) == "player") then
--	local who = getPlayerFromName(who)
--	if getPlayerTeam(player) == getTeamFromName("Area-62") then --]]
		outputChatBox("MEDICAL CENTRE: Youre healed, it costs "..money.." Dollars!", hitElement, 0, 255, 0 )
		outputChatBox("MEDICAL CENTRE: For security reasons you got Armor! ("..armor.." Percent)", hitElement, 0, 255, 0 )
		setElementHealth( hitElement, 50 )
		setElementHealth( hitElement, 75 )
		setElementHealth( hitElement, 99 )
		setElementHealth( hitElement, 100 ) -- Experimental, sets health to 50,75,99 and then 100%
		setPedArmor( hitElement, armor )
		takePlayerMoney( hitElement, money ) -- Its not getting checked if user has enouth money!
		end
	end
addEventHandler("onMarkerHit", LSEM1, LSEM )
addEventHandler("onMarkerHit", LVEM1, LSEM )
addEventHandler("onMarkerHit", LANDEM1, LSEM )
addEventHandler("onMarkerHit", SFEM1, LSEM )
addEventHandler("onMarkerHit", LSEM2, LSEM )
