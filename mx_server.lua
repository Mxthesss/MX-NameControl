local DISCORD_WEBHOOK = ""

local DISCORD_NAME = "Mxthess"

local STEAM_KEY = "" -- Steam Web API Key

local DISCORD_IMAGE = "https://pbs.twimg.com/profile_images/847824193899167744/J1Teh4Di_400x400.jpg" -- default is FiveM logo

local MXForbiddenNames = { -- forbidden words or chars (lowercase letters)
	"%^1",
	"%^2",
	"%^3",
	"%^4",
	"%^5",
	"%^6",
	"%^7",
	"%^8",
	"%^9",
	"%^%*",
	"%^_",
	"%^=",
	"%^%~",
	"admin",
    "nigga",
    "Nigga",
    "negr",
    "Negr",
    "Admin",
    "Owner",
    "Developer",
	"owner",
	"Hitler",
	"✞",
	"⁹⁹⁹⁺",
	"hitler",
    "developer"
}

AddEventHandler("playerConnecting", function(playerName, setKickReason)
	for name in pairs(MXForbiddenNames) do
		if(string.gsub(string.gsub(string.gsub(string.gsub(playerName:lower(), "-", ""), ",", ""), "%.", ""), " ", ""):find(MXForbiddenNames[name])) then
			print(playerName .. " has been kicked!")
			setKickReason("[MX_NameControl] Your name is not allowed!")
			CancelEvent()
			break
		end
	end
end)


PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "Discord Webhook is **ONLINE**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

AddEventHandler('playerDropped', function(reason) 
	local color = 16711680
	if string.match(reason, "Kicked") or string.match(reason, "Banned") then
		color = 16007897
	end
  sendToDiscord("Server Logout", "**" .. GetPlayerName(source) .. "** has left the server. \n Reason: " .. reason, color)
end)


function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message, color)
  local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made by Mxthess",
            },
        }
    }
  PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end





































print('^5Made By Mxthess^7: ^1'..GetCurrentResourceName()..'^7 started ^2successfully^7...') 