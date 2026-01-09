local player = game.Players.LocalPlayer
local workspace = game.Workspace
loadstring("")
-- Function to create ESP for a model
local function createESP(model)
    if not model or not model:IsA("Model") then return end
    
    -- Check if ESP already exists
    if model:FindFirstChild("ESP_Billboard") then return end
    
    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart") 
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0) 
    billboard.AlwaysOnTop = true
    
    -- Create a Frame for outline
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0) 
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = billboard
    
    -- Create TextLabel for name
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.5, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Плоть"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = frame
    
    -- Parent the BillboardGui to the model
    billboard.Parent = model
end

-- Function to find all models with a specific name in Workspace (recursive search)
local function findAllModels(name)
    local models = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == name then
            table.insert(models, obj)
        end
    end
    return models
end

-- Apply ESP to all existing models with the name
local targetName = 'Артефакт "Плоть"'  -- Используем имя из вашего исправления
local existingModels = findAllModels(targetName)
for _, model in ipairs(existingModels) do
    createESP(model)
end

-- Continuously check for new models and apply ESP
while true do
    wait(1) -- Check every second
    local allModels = findAllModels(targetName)
    for _, model in ipairs(allModels) do
        createESP(model)  -- Will skip if ESP already exists
    end
end
