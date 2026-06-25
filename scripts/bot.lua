print("🤖 Modulo Bot Ativado!")

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local lugarId = game.PlaceId
local webhook = _G.WebhookUrl

-- Função para trocar de servidor rapidamente se não achar nada
local function serverHop()
    -- URL corrigida para a API de servidores públicos do Roblox
    local url = "https://roblox.com" .. lugarId .. "/servers/Public?sortOrder=Asc&limit=100"
    local resposta = request({Url = url, Method = "GET"})
    if resposta.Success then
        local dados = HttpService:JSONDecode(resposta.Body)
        for _, servidor in pairs(dados.data) do
            if servidor.playing < servidor.maxPlayers and servidor.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(lugarId, servidor.id, game.Players.LocalPlayer)
                break
            end
        end
    end
end

-- Varredura rápida do mapa
local frutaEncontrada = false
for _, objeto in pairs(workspace:GetChildren()) do
    if objeto:IsA("Tool") and (string.find(objeto.Name, "Fruit") or objeto:FindFirstChild("Handle")) then
        frutaEncontrada = true
        if webhook and webhook ~= "SUA_WEBHOOK_DO_DISCORD_AQUI" then
            local dados = {
                ["content"] = "🍓 Fruta no chão encontrada por um Bot!",
                ["embeds"] = {{
                    ["title"] = "Entre na partida usando o Delta:",
                    ["description"] = "```lua\ngame:GetService('TeleportService'):TeleportToPlaceInstance(" .. lugarId .. ", '" .. game.JobId .. "', game.Players.LocalPlayer)\n```"
                }}
            }
            request({Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(dados)})
        end
        break
    end
end

if not frutaEncontrada then
    task.wait(1)
    serverHop()
end
