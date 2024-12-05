local appid = '' -- Discord APP ID 
local image1 = 'image' --name Discord IMAGE
local image2 = 'image' --name Discord IMAGE
local prevtime = GetGameTimer()
local prevframes = GetFrameCount()
local fps = -1

CreateThread(function()
  while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do
    Wait(500)
    prevframes = GetFrameCount()
    prevtime = GetGameTimer()
  end

  while true do
    curtime = GetGameTimer()
    curframes = GetFrameCount()
        
    if((curtime - prevtime) > 1000) then
      fps = (curframes - prevframes) - 1
      prevtime = curtime
      prevframes = curframes
    end

    Wait(350)
  end
end)

function players()
  local players = {}

  for i = 0, 62 do
      if NetworkIsPlayerActive(i) then
          table.insert(players, i)
      end
  end

  return players
end

function SetRP()
  local name = GetPlayerName(PlayerId())
  local id = GetPlayerServerId(PlayerId())

  SetDiscordAppId(appid)
  SetDiscordRichPresenceAsset(image1)
  SetDiscordRichPresenceAssetSmall(image2)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(700)
    SetRP()
    SetDiscordRichPresenceAssetText('discord.gg/FPt45Zd74F')

    local activePlayers = #players()
    local maxPlayers = GetConvarInt("sv_maxclients", 64) 


    SetRichPresence("FPS: " ..fps.. " | Nick: " ..GetPlayerName(PlayerId()) .. " | ID: " ..GetPlayerServerId(PlayerId()) .. " | Players: " .. activePlayers .. "/" .. maxPlayers)

    SetDiscordRichPresenceAction(0, "Discord!", "")
    SetDiscordRichPresenceAction(1, "FiveM!", "fivem://connect/127.0.0.1:30120")
  end
end)
