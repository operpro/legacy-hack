-- Исправленный код с отладкой: GUI пересоздается после смерти
local player = game.Players.LocalPlayer

-- Функция для создания GUI
local function createGUI()
    print("Скрипт сделан @fourli")  -- Отладка
    local playerGui = player:WaitForChild("PlayerGui", 10)  -- Ждем до 10 сек
    if not playerGui then
        warn("Ошибка с нахождением GUI")
        return
    end
    
    -- Удаляем старый GUI, если есть
    local existingGui = playerGui:FindFirstChild("MyScreenGui")
    if existingGui then
        existingGui:Destroy()
        
    end
    
    -- Создаем ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MyScreenGui"
    screenGui.Parent = playerGui
   
    
    -- Создаем TextLabel
    local textLabel = Instance.new("TextLabel")
    textLabel.Text = "legacy hack v0.1"
    textLabel.Size = UDim2.new(0, 300, 0, 50)
    textLabel.Position = UDim2.new(0.5, -150, 0.5, -570)
    textLabel.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    textLabel.TextColor3 = Color3.fromRGB(0, 0, 255)
    textLabel.Font = Enum.Font.Jura
    textLabel.TextSize = 35
    textLabel.BackgroundTransparency = 0.3
    textLabel.BorderSizePixel = 5
    textLabel.BorderColor3 = Color3.fromRGB(56, 56, 56)
    textLabel.BorderMode = Enum.BorderMode.Inset
    textLabel.Parent = screenGui
   
    -- Цикл для переливания цветов
    local running = true
    task.spawn(function()  -- Запускаем в отдельном потоке, чтобы не блокировать
        while running do
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 210)
            wait(0.4)
            textLabel.TextColor3 = Color3.fromRGB(8, 255, 157)
            wait(0.4)
            textLabel.TextColor3 = Color3.fromRGB(7, 255, 61)
            wait(0.4)
            textLabel.TextColor3 = Color3.fromRGB(12, 255, 5)
            wait(0.4)
            textLabel.TextColor3 = Color3.fromRGB(3, 255, 106)
            wait(0.4)
            textLabel.TextColor3 = Color3.fromRGB(0, 255, 189)
            wait(0.4)
        end
    end)
    
    -- Функция для остановки цикла при удалении GUI
    screenGui.Destroying:Connect(function()
        running = false
        
    end)
end

-- Создаем GUI при первом запуске
createGUI()

-- Пересоздаем GUI при каждом новом персонаже
player.CharacterAdded:Connect(function(character)
    
    wait(1)  -- Небольшая задержка для загрузки
    createGUI()
end)

-- Дополнительный цикл для проверки (на случай проблем с CharacterAdded)
while true do
    wait(5)  -- Проверяем каждые 5 сек
    if not player.PlayerGui:FindFirstChild("MyScreenGui") then
        
        createGUI()
    end
end
