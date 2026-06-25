-- [[ DECKFLOW HUB - MODULES ENGINE ]]
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Atalho para o sistema de rede do jogo
local CommF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")

_G.Modules = {}

-- 1. SISTEMA PROFISSIONAL DE COMBATE (AUTO CLICK + EQUIP)
task.spawn(function()
    while true do
        task.wait()
        if _G.Config.AutoClick and _G.Config.AutoFarm then
            pcall(function()
                -- Equipar arma dinamicamente com base na escolha da GUI
                local ferramenta = Player.Backpack:FindFirstChild(_G.Config.AutoFarmType) or Player.Character:FindFirstChild(_G.Config.AutoFarmType)
                if ferramenta and ferramenta.Parent ~= Player.Character then
                    ferramenta.Parent = Player.Character
                end
                -- Dispara o clique nativo do motor do Roblox (Sem Lag)
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(850, 520))
            end)
        end
    end
end)

-- 2. ENGINE INTELIGENTE DE AUTO FARM E MAGNET
task.spawn(function()
    while true do
        task.wait(0.1)
        if _G.Config.AutoFarm then
            pcall(function()
                local nivel = Player.Data.Level.Value
                local nomeQuest, numeroQuest, nomeMonstro
                
                -- Tabela dinâmica de Quests (Estilo Azure/Hoho)
                if nivel >= 1 and nivel < 10 then
                    nomeQuest, numeroQuest, nomeMonstro = "BanditQuest", 1, "Bandit"
                elseif nivel >= 10 and nivel < 15 then
                    nomeQuest, numeroQuest, nomeMonstro = "MonkeyQuest", 1, "Monkey"
                -- Adicione os novos níveis aqui seguindo o padrão
                end
                
                -- Aceita a Quest se estiver sem nenhuma ativa
                if Player.PlayerGui.Main.Quest.Visible == false then
                    CommF:InvokeServer("StartQuest", nomeQuest, numeroQuest)
                end
                
                -- Magnet e Teleporte Seguro acima dos Mobs
                for _, monstro in pairs(workspace.Enemies:GetChildren()) do
                    if monstro.Name == nomeMonstro and monstro:FindFirstChild("HumanoidRootPart") and monstro.Humanoid.Health > 0 then
                        _G.Config.AutoClick = true
                        local meuRoot = Player.Character:FindFirstChild("HumanoidRootPart")
                        if meuRoot then
                            -- Fica flutuando ligeiramente acima do monstro para não tomar dano
                            meuRoot.CFrame = monstro.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                            -- Junta os outros monstros no mesmo lugar (Magnet)
                            monstro.HumanoidRootPart.CFrame = meuRoot.CFrame * CFrame.new(0, -5, 0)
                            monstro.HumanoidRootPart.CanCollide = false
                        end
                    end
                end
            end)
        else
            _G.Config.AutoClick = false
        end
    end
end)

-- 3. INTERFACES DE REDE (SERVER HOP SEM FALHAS)
function _G.ExecuteServerHop()
    local url = "https://roblox.com" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local resposta = request({Url = url, Method = "GET"})
    if resposta.Success then
        local dados = game:GetService("HttpService"):JSONDecode(resposta.Body)
        for _, servidor in pairs(dados.data) do
            if servidor.playing < servidor.maxPlayers and servidor.id ~= game.JobId then
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servidor.id, Player)
                break
            end
        end
    end
end
