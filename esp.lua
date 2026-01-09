-- Объединенный скрипт: GUI (watermark) + ESP для "Артефакт 'Плоть'"
-- Скрипт сделан @fourli
local player = game.Players.LocalPlayer
local workspace = game.Workspace

-- Функция для создания GUI (watermark с переливанием цветов)
local function createGUI()
-- Отладка
    local playerGui = player:WaitForChild("PlayerGui", 10)  -- Ждем до 10 сек
    if not playerGui then
 
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
    
    
    -- Цикл для переливания цветов в отдельном потоке
    local running = true
    task.spawn(function()
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
    
    -- Останавливаем цикл при удалении GUI
    screenGui.Destroying:Connect(function()
        running = false
        
    end)
end

-- Функция для создания ESP для модели
local function createESP(model)
    if not model or not model:IsA("Model") then return end
    
    -- Проверяем, есть ли уже ESP
    if model:FindFirstChild("ESP_Billboard") then return end
    
    -- Создаем BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    billboard.Size = UDim2.new(0, 110, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    
    -- Создаем Frame для контура
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = billboard
    
    -- Создаем TextLabel для имени
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Артефакт Плоть"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = frame
    
    -- Привязываем к модели
    billboard.Parent = model

end

-- Функция для поиска всех моделей с именем
local function findAllModels(name)
    local models = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == name then
            table.insert(models, obj)
        end
    end
    return models
end

-- Инициализация: Создаем GUI и применяем ESP к существующим моделям

createGUI()
local targetName = 'Артефакт "Плоть"'
local existingModels = findAllModels(targetName)

for _, model in ipairs(existingModels) do
    createESP(model)
end

-- Пересоздаем GUI при новом персонаже (после смерти)
player.CharacterAdded:Connect(function()
    
    wait(1)
    createGUI()
end)

-- Циклы в отдельных потоках для стабильности
task.spawn(function()
    -- Цикл для проверки GUI (каждые 5 сек)
    while true do
        wait(5)
        if not player.PlayerGui:FindFirstChild("MyScreenGui") then
            
            createGUI()
        end
    end
end)

task.spawn(function()
    -- Цикл для ESP (каждую секунду)
    while true do
        wait(1)
        local allModels = findAllModels(targetName)
        for _, model in ipairs(allModels) do
            createESP(model)
        end
    end
end)

