-- CONFIGURAÇÃO PRINCIPAL
local CONFIG = {
    ContaPrincipal = "NICK_DA_SUA_CONTA_PRINCIPAL",
    WebhookUrl = "SUA_WEBHOOK_DO_DISCORD_AQUI"
}

local nickAtual = game.Players.LocalPlayer.Name

-- Identifica o tipo de conta rodando o script
if nickAtual == CONFIG.ContaPrincipal then
    print("[LOG] Conta Principal detectada. Carregando funções de coleta...")
    -- ATENÇÃO: Altere SEU_USER e SEU_REPO após subir para o GitHub
    local principal = loadstring(game:HttpGet("https://githubusercontent.com"))
    if principal then principal() end
else
    print("[LOG] Conta Bot detectada. Iniciando farm em segundo plano...")
    -- Carrega o módulo do bot
    _G.WebhookUrl = CONFIG.WebhookUrl
    local bot = loadstring(game:HttpGet("https://githubusercontent.com"))
    if bot then bot() end
end
