-- [[ DECKFLOW HUB - CORE ENGINE ]]
if not game:IsLoaded() then game.Loaded:Wait() end

-- Impedir dupla execução (Anti-Lag)
if _G.DeckflowLoaded then 
    print("[DECKFLOW] Já está executando!") 
    return 
end
_G.DeckflowLoaded = true

-- Inicialização Global de Variáveis e Configurações
_G.Config = {
    AutoFarm = false,
    AutoFarmType = "Melee", -- Melee, Sword, Fruit
    AutoClick = false,
    FruitSniper = false,
    ServerHopTime = 15,
    AutoHop = false,
    DistribuirStatus = false,
    StatusAlvo = "Melee"
}

-- Sistema de Salvamento em Nuvem Local (JSON)
local HttpService = game:GetService("HttpService")
local NomeArquivo = "deckflow_pro_config.json"

function _G.SalvarConfig()
    if writefile then writefile(NomeArquivo, HttpService:JSONEncode(_G.Config)) end
end

function _G.CarregarConfig()
    if readfile and isfile and isfile(NomeArquivo) then
        local sucesso, dados = pcall(function() return HttpService:JSONDecode(readfile(NomeArquivo)) end)
        if sucesso and dados then _G.Config = dados end
    end
end
_G.CarregarConfig()

-- Carrega os Módulos de Função e depois a Interface Visual de forma Assíncrona
task.spawn(function()
    loadstring(game:HttpGet("https://githubusercontent.com"))()
    loadstring(game:HttpGet("https://githubusercontent.com"))()
end)
