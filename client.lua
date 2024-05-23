local transparencyLevel = 150 -- Transparency level (a value between 0-255) / Saydamlık seviyesi (0-255 arası bir değer)
local viewAngle = 20 -- Field of view angle for the player (e.g., 20 degrees) / Karakterin bakış açısı (örneğin, 20 derece)
local maxTransparencyDistance = 50 -- Maximum transparency distance (e.g., 50 units) / Maksimum saydamlık mesafesi (örneğin, 50 birim)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local playerForwardVector = GetEntityForwardVector(playerPed)

        local npcs = GetGamePool('CPed')
        for _, npc in ipairs(npcs) do
            if npc ~= playerPed then
                local npcCoords = GetEntityCoords(npc)
                local direction = npcCoords - playerCoords
                local distance = #(npcCoords - playerCoords)

                local dotProduct = DotProduct2D(direction, playerForwardVector)
                if dotProduct > math.cos(math.rad(viewAngle)) and distance <= maxTransparencyDistance then
                    SetEntityAlpha(npc, 255, false)
                else
                    SetEntityAlpha(npc, transparencyLevel, false)
                end
            end
        end
    end
end)

function DotProduct2D(v1, v2)
    return v1.x * v2.x + v1.y * v2.y
end
