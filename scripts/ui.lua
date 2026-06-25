-- [[ DECKFLOW HUB - GUI INTERFACE ]]
local KavoUi = loadstring(game:HttpGet("https://githubusercontent.com"))()
local Janela = KavoUi.CreateLib("Deckflow Hub Premium v1 👑", "Midnight") -- Tema escuro de alta performance

-- ABAS ESTILO HOHO HUB
local AbaFarm = Janela:NewTab("Auto Farm")
local AbaSniper = Janela:NewTab("Fruit Sniper")
local AbaConfig = Janela:NewTab("Configurações")

-- SEÇÃO 1: AUTO FARM
local SecaoFarm = AbaFarm:NewSection("Farm de Níveis")
SecaoFarm:NewToggle("Ativar Auto Farm (Quests)", "Upa sua conta e faz missões automaticamente", function(estado)
    _G.Config.AutoFarm = estado
    _G.SalvarConfig()
end)

SecaoFarm:NewDropdown("Arma do Farm", "Escolha o tipo de item para atacar", {"Melee", "Sword", "Fruit"}, function(opcao)
    _G.Config.AutoFarmType = opcao
    _G.SalvarConfig()
end)

-- SEÇÃO 2: SNIPER
local SecaoSniper = AbaSniper:NewSection("Localizador de Frutas")
SecaoSniper:NewToggle("Auto Coletar Frutas do Chão", "Busca todas as frutas existentes no servidor atual", function(estado)
    _G.Config.FruitSniper = estado
    _G.SalvarConfig()
    if estado then
        loadstring(game:HttpGet("https://githubusercontent.com"))()
    end
end)

-- SEÇÃO 3: SERVER HOP CONFIG
local SecaoConfig = AbaConfig:NewSection("Configurações de Rede")
SecaoConfig:NewSlider("Tempo Limite de Espera (s)", "Tempo antes de pular de servidor", 120, 5, function(valor)
    _G.Config.ServerHopTime = valor
    _G.SalvarConfig()
end)

SecaoConfig:NewButton("Forçar Server Hop Agora", "Pula imediatamente para outra partida", function()
    _G.ExecuteServerHop()
end)
