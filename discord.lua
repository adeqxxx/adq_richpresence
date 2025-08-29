local appid = '1345435919200686100' -- ID aplikace na Discordu
local image1 = 'big' -- Klíč velkého obrázku
local maxPlayers = 64 -- Maximální počet hráčů na serveru

-- Funkce pro zjištění aktuálního počtu hráčů na serveru
function GetPlayerCount()
    local count = 0
    for i = 0, 128 do
        if NetworkIsPlayerActive(i) then
            count = count + 1
        end
    end
    return count
end

-- Funkce pro nastavení Rich Presence
function SetRP()
    local name = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    local playerCount = GetPlayerCount()

    SetDiscordAppId(appid)
    SetDiscordRichPresenceAsset(image1)

    -- Aktualizace Rich Presence s informacemi, počet hráčů na novém řádku
    SetRichPresence(("Nick: %s \nID: %d | Počet hráčů: %d/%d"):format(name, id, playerCount, maxPlayers))

    SetDiscordRichPresenceAssetText(("Počet hráčů: %d/%d"):format(playerCount, maxPlayers))

    SetDiscordRichPresenceAction(1, "Discord!", "https://discord.gg/ah2YuYy2kq")
    SetDiscordRichPresenceAction(2, "Instagram!", "https://www.instagram.com/projectnexus_rp")
end

-- Smyčka pro aktualizaci Rich Presence
Citizen.CreateThread(function()
    while true do
        SetRP()
        Citizen.Wait(60000) -- Aktualizace každých 60 sekund
    end
end)