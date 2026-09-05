local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InfiniteLoading"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = PlayerGui

local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1, 1)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 60)
Title.Position = UDim2.new(0, 20, 0.38, 0)
Title.BackgroundTransparency = 1
Title.Text = "CARREGANDO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 32
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = Background

local Message = Instance.new("TextLabel")
Message.Size = UDim2.new(1, -40, 0, 40)
Message.Position = UDim2.new(0, 20, 0.47, 0)
Message.BackgroundTransparency = 1
Message.Text = "Iniciando..."
Message.TextColor3 = Color3.fromRGB(170, 170, 170)
Message.TextSize = 18
Message.Font = Enum.Font.Gotham
Message.TextXAlignment = Enum.TextXAlignment.Center
Message.Parent = Background

local BarBackground = Instance.new("Frame")
BarBackground.Size = UDim2.new(0.65, 0, 0, 8)
BarBackground.Position = UDim2.new(0.175, 0, 0.56, 0)
BarBackground.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BarBackground.BorderSizePixel = 0
BarBackground.Parent = Background

local BarBackgroundCorner = Instance.new("UICorner")
BarBackgroundCorner.CornerRadius = UDim.new(1, 0)
BarBackgroundCorner.Parent = BarBackground

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(0, 0, 1, 0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Bar.BorderSizePixel = 0
Bar.Parent = BarBackground

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = Bar

local Percentage = Instance.new("TextLabel")
Percentage.Size = UDim2.new(1, -40, 0, 30)
Percentage.Position = UDim2.new(0, 20, 0.59, 0)
Percentage.BackgroundTransparency = 1
Percentage.Text = "0%"
Percentage.TextColor3 = Color3.fromRGB(120, 120, 120)
Percentage.TextSize = 14
Percentage.Font = Enum.Font.Gotham
Percentage.TextXAlignment = Enum.TextXAlignment.Center
Percentage.Parent = Background

local Messages = {
	"Iniciando sistema...",
	"Carregando configurações...",
	"Verificando arquivos...",
	"Carregando recursos...",
	"Preparando interface...",
	"Sincronizando dados...",
	"Verificando conexão...",
	"Carregando módulos...",
	"Inicializando funções...",
	"Otimizando recursos...",
	"Verificando dependências...",
	"Preparando ambiente...",
	"Quase pronto..."
}

task.spawn(function()
	local index = 1

	while ScreenGui.Parent do
		Message.Text = Messages[index]

		index += 1

		if index > #Messages then
			index = 1
		end

		task.wait(1.5)
	end
end)

task.spawn(function()
	local progress = 0
	local maxProgress = 99.99

	while ScreenGui.Parent and progress < maxProgress do
		local remaining = maxProgress - progress

		local increment

		if progress < 50 then
			increment = 0.35
		elseif progress < 80 then
			increment = 0.12
		elseif progress < 95 then
			increment = 0.035
		elseif progress < 99 then
			increment = 0.008
		else
			increment = 0.001
		end

		progress = math.min(progress + increment, maxProgress)

		Bar.Size = UDim2.new(progress / 100, 0, 1, 0)
		Percentage.Text = string.format("%.2f%%", progress)

		task.wait(0.08)
	end

	if ScreenGui.Parent then
		progress = maxProgress
		Bar.Size = UDim2.new(0.9999, 0, 1, 0)
		Percentage.Text = "99.99%"
		Message.Text = "Finalizando carregamento..."

		while ScreenGui.Parent do
			task.wait(1)
		end
	end
end)
