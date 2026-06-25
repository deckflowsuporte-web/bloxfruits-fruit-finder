print("⚡ Modulo Principal Ativado!")

-- Lógica para voar até a fruta e guardar no inventário
local function coletarParaPrincipal()
    for _, objeto in pairs(workspace:GetChildren()) do
        if objeto:IsA("Tool") and (string.find(objeto.Name, "Fruit") or objeto:FindFirstChild("Handle")) then
            local rootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and objeto:FindFirstChild("Handle") then
                rootPart.CFrame = objeto.Handle.CFrame
                task.wait(1)
                -- Código para simular clique e armazenar fruta vai aqui
                return true
            end
        end
    end
    return false
end

coletarParaPrincipal()
