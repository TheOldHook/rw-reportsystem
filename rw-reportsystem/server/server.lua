local QBCore = exports['qb-core']:GetCoreObject()

local discord_webhook = {
    url = "", -- Your Discord webhook url
    image = "https://i.imgur.com/oULfkE6.png"
}


function GetPlayerNeededIdentifiers(source)
	local ids = GetPlayerIdentifiers(source)
	for i,theIdentifier in ipairs(ids) do
		if string.find(theIdentifier,"license:") or -1 > -1 then
			license = theIdentifier
		elseif string.find(theIdentifier,"steam:") or -1 > -1 then
			steam = theIdentifier
		elseif string.find(theIdentifier,"discord:") or -1 > -1 then
			discord2 = theIdentifier
		end
	end
	if not steam then
		steam = "Not found"
	end
	if not discord2 then
		discord2 = "Not found"
	end
	return license, steam, discord2
end



RegisterServerEvent('sendDiscord')
AddEventHandler("sendDiscord", function(data)

	title = data['title'][1]
	description = data['description'][2]

		local license, steam, discord2 = GetPlayerNeededIdentifiers(source)
	PerformHttpRequest(discord_webhook.url, function(err, text, headers) end, 'POST', json.encode(
		{
			username = "RW TicketSystem",
			avatar_url = discord_webhook.image,
			embeds = {
			{
				title = data.title,
				color = 16754176,
				description = "**Bruker:** ".. GetPlayerName(source) .. " **[ID:** ".. source .."**]**\n**Beskrivelse:** ".. data.description .."\n**Steam:** ".. steam:gsub('steam:', '') .."\n**GameLicense:** ".. license:gsub('license:', '') .."\n**Discord UID:** ".. discord2:gsub('discord:', '') .."\n**Discord Tag:** <@!"..  discord2:gsub('discord:', '') .. ">",
			}
		},
	}), { ['Content-Type'] = 'application/json' })
end)


































--- Database øving
--[[
RegisterServerEvent('rw:info')
AddEventHandler('rw:info', function(name, deferrals)

	-- Variabler 
	local source = source
	local identifiers = GetPlayerIdentifiers(source)
	local steamid
	local license
	local discord
	local ip
	local data = {
		name = Player.PlayerData.charinfo.firstname.." "..Player.PlayerData.charinfo.lastname,
		dob = Player.PlayerData.charinfo.dob
	}
	
	-- Definere variabler som brukerens identifiers

	for k, v in ipairs(identifiers) do 
		if string.match(v, 'steam') then
			steamid = v
			print('steamid grabbed:' v)
		elseif string.match(v, 'license:') then
			license = v 
		elseif string.match(v, 'discord') then
			discord = v 
		elseif string.match(v, 'fivem') then
			fivem = v 
		elseif string.match(v, 'ip') then
			ip = v 
		end
	end
end)
]]--
