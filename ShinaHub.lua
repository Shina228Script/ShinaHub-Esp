-- // Shina ESP Script v2.2
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- // Anti-detection
local GUI = Instance.new("ScreenGui")
GUI.Name = "ShinaESP_" .. math.random(1000, 9999)
GUI.Parent = (syn and syn.protect_gui and syn.protect_gui(GUI)) or CoreGui
GUI.ResetOnSpawn = false

-- // Variables
local espColor = Color3.fromRGB(255, 0, 0)
local espEnabled = true
local showNames = true
local showDistance = true
local playerESP = {}
local menuMinimized = false

-- // Main Menu
local Menu = Instance.new("Frame")
Menu.Size = UDim2.new(0, 220, 0, 260)
Menu.Position = UDim2.new(0.3, 0, 0.2, 0)
Menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Menu.BorderSizePixel = 0
Menu.BackgroundTransparency = 0.1
Menu.Active = true
Menu.Draggable = true
Menu.Parent = GUI

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Menu

-- // Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Menu

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 8)
UICornerTitle.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Shina ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Position = UDim2.new(1, -25, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
MinimizeBtn.TextSize = 14
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

local UICornerMin = Instance.new("UICorner")
UICornerMin.CornerRadius = UDim.new(0, 4)
UICornerMin.Parent = MinimizeBtn

-- // Content container
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -40)
Content.Position = UDim2.new(0, 10, 0, 35)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
Content.CanvasSize = UDim2.new(0, 0, 0, 230)
Content.Parent = Menu

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = Content

-- // ESP Toggle
local ToggleFrame = Instance.new("Frame")
ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleFrame.BorderSizePixel = 0
ToggleFrame.Parent = Content

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 6)
UICornerToggle.Parent = ToggleFrame

local ToggleLabel = Instance.new("TextLabel")
ToggleLabel.Size = UDim2.new(0, 100, 1, 0)
ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
ToggleLabel.BackgroundTransparency = 1
ToggleLabel.Text = "Shina ESP"
ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleLabel.TextSize = 13
ToggleLabel.Font = Enum.Font.Gotham
ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
ToggleLabel.Parent = ToggleFrame

local ToggleESP = Instance.new("TextButton")
ToggleESP.Size = UDim2.new(0, 50, 0, 22)
ToggleESP.Position = UDim2.new(1, -60, 0.5, -11)
ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ToggleESP.BorderSizePixel = 0
ToggleESP.Text = "ON"
ToggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESP.TextSize = 12
ToggleESP.Font = Enum.Font.GothamBold
ToggleESP.AutoButtonColor = false
ToggleESP.Parent = ToggleFrame

local UICornerToggleBtn = Instance.new("UICorner")
UICornerToggleBtn.CornerRadius = UDim.new(0, 4)
UICornerToggleBtn.Parent = ToggleESP

-- // Color Section
local ColorSection = Instance.new("Frame")
ColorSection.Size = UDim2.new(1, 0, 0, 120)
ColorSection.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ColorSection.BorderSizePixel = 0
ColorSection.Parent = Content

local UICornerColor = Instance.new("UICorner")
UICornerColor.CornerRadius = UDim.new(0, 6)
UICornerColor.Parent = ColorSection

local ColorTitle = Instance.new("TextLabel")
ColorTitle.Size = UDim2.new(1, -20, 0, 20)
ColorTitle.Position = UDim2.new(0, 10, 0, 5)
ColorTitle.BackgroundTransparency = 1
ColorTitle.Text = "🎨 ESP Color"
ColorTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorTitle.TextSize = 13
ColorTitle.Font = Enum.Font.GothamBold
ColorTitle.TextXAlignment = Enum.TextXAlignment.Left
ColorTitle.Parent = ColorSection

-- // Current color preview
local ColorPreview = Instance.new("Frame")
ColorPreview.Size = UDim2.new(0, 30, 0, 30)
ColorPreview.Position = UDim2.new(1, -40, 0, 3)
ColorPreview.BackgroundColor3 = espColor
ColorPreview.BorderSizePixel = 0
ColorPreview.Parent = ColorSection

local UICornerPreview = Instance.new("UICorner")
UICornerPreview.CornerRadius = UDim.new(0, 6)
UICornerPreview.Parent = ColorPreview

-- // Preset colors
local Presets = {"Red", "Green", "Blue", "Yellow", "Purple", "Cyan", "White", "Orange"}
local PresetColors = {
    Color3.fromRGB(255, 0, 0),      -- Red
    Color3.fromRGB(0, 255, 0),      -- Green
    Color3.fromRGB(0, 150, 255),    -- Blue
    Color3.fromRGB(255, 255, 0),    -- Yellow
    Color3.fromRGB(170, 0, 255),    -- Purple
    Color3.fromRGB(0, 255, 255),    -- Cyan
    Color3.fromRGB(255, 255, 255),  -- White
    Color3.fromRGB(255, 150, 0)     -- Orange
}

-- // Create preset buttons in 2 rows
for i = 1, 4 do
    local preset = Instance.new("TextButton")
    preset.Size = UDim2.new(0, 48, 0, 20)
    preset.Position = UDim2.new(0, 8 + (i-1)*50, 0, 30)
    preset.BackgroundColor3 = PresetColors[i]
    preset.BorderSizePixel = 0
    preset.Text = Presets[i]
    preset.TextColor3 = Color3.fromRGB(0, 0, 0)
    preset.TextSize = 9
    preset.Font = Enum.Font.GothamBold
    preset.AutoButtonColor = false
    preset.Parent = ColorSection
    
    local UICornerPreset = Instance.new("UICorner")
    UICornerPreset.CornerRadius = UDim.new(0, 3)
    UICornerPreset.Parent = preset
    
    local colorIndex = i
    preset.MouseButton1Click:Connect(function()
        espColor = PresetColors[colorIndex]
        ColorPreview.BackgroundColor3 = espColor
        updateAllESPColors()
        print("Shina ESP - Color changed to:", Presets[colorIndex])
    end)
end

for i = 5, 8 do
    local preset = Instance.new("TextButton")
    preset.Size = UDim2.new(0, 48, 0, 20)
    preset.Position = UDim2.new(0, 8 + (i-5)*50, 0, 55)
    preset.BackgroundColor3 = PresetColors[i]
    preset.BorderSizePixel = 0
    preset.Text = Presets[i]
    preset.TextColor3 = Color3.fromRGB(0, 0, 0)
    preset.TextSize = 9
    preset.Font = Enum.Font.GothamBold
    preset.AutoButtonColor = false
    preset.Parent = ColorSection
    
    local UICornerPreset = Instance.new("UICorner")
    UICornerPreset.CornerRadius = UDim.new(0, 3)
    UICornerPreset.Parent = preset
    
    local colorIndex = i
    preset.MouseButton1Click:Connect(function()
        espColor = PresetColors[colorIndex]
        ColorPreview.BackgroundColor3 = espColor
        updateAllESPColors()
        print("Shina ESP - Color changed to:", Presets[colorIndex])
    end)
end

-- // Custom RGB inputs
local RLabel = Instance.new("TextLabel")
RLabel.Size = UDim2.new(0, 20, 0, 20)
RLabel.Position = UDim2.new(0, 10, 0, 85)
RLabel.BackgroundTransparency = 1
RLabel.Text = "R:"
RLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
RLabel.TextSize = 11
RLabel.Font = Enum.Font.Gotham
RLabel.TextXAlignment = Enum.TextXAlignment.Left
RLabel.Parent = ColorSection

local RSlider = Instance.new("TextBox")
RSlider.Size = UDim2.new(0, 40, 0, 20)
RSlider.Position = UDim2.new(0, 30, 0, 85)
RSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RSlider.BorderSizePixel = 0
RSlider.Text = "255"
RSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
RSlider.TextSize = 11
RSlider.Font = Enum.Font.Gotham
RSlider.Parent = ColorSection

local GLabel = Instance.new("TextLabel")
GLabel.Size = UDim2.new(0, 20, 0, 20)
GLabel.Position = UDim2.new(0, 80, 0, 85)
GLabel.BackgroundTransparency = 1
GLabel.Text = "G:"
GLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
GLabel.TextSize = 11
GLabel.Font = Enum.Font.Gotham
GLabel.TextXAlignment = Enum.TextXAlignment.Left
GLabel.Parent = ColorSection

local GSlider = Instance.new("TextBox")
GSlider.Size = UDim2.new(0, 40, 0, 20)
GSlider.Position = UDim2.new(0, 100, 0, 85)
GSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
GSlider.BorderSizePixel = 0
GSlider.Text = "0"
GSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
GSlider.TextSize = 11
GSlider.Font = Enum.Font.Gotham
GSlider.Parent = ColorSection

local BLabel = Instance.new("TextLabel")
BLabel.Size = UDim2.new(0, 20, 0, 20)
BLabel.Position = UDim2.new(0, 150, 0, 85)
BLabel.BackgroundTransparency = 1
BLabel.Text = "B:"
BLabel.TextColor3 = Color3.fromRGB(100, 100, 255)
BLabel.TextSize = 11
BLabel.Font = Enum.Font.Gotham
BLabel.TextXAlignment = Enum.TextXAlignment.Left
BLabel.Parent = ColorSection

local BSlider = Instance.new("TextBox")
BSlider.Size = UDim2.new(0, 40, 0, 20)
BSlider.Position = UDim2.new(0, 170, 0, 85)
BSlider.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
BSlider.BorderSizePixel = 0
BSlider.Text = "0"
BSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
BSlider.TextSize = 11
BSlider.Font = Enum.Font.Gotham
BSlider.Parent = ColorSection

-- // Apply custom color button
local ApplyCustomBtn = Instance.new("TextButton")
ApplyCustomBtn.Size = UDim2.new(1, -20, 0, 22)
ApplyCustomBtn.Position = UDim2.new(0, 10, 0, 110)
ApplyCustomBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ApplyCustomBtn.BorderSizePixel = 0
ApplyCustomBtn.Text = "Apply Custom Color"
ApplyCustomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyCustomBtn.TextSize = 11
ApplyCustomBtn.Font = Enum.Font.GothamBold
ApplyCustomBtn.Parent = ColorSection

local UICornerApply = Instance.new("UICorner")
UICornerApply.CornerRadius = UDim.new(0, 4)
UICornerApply.Parent = ApplyCustomBtn

-- // ESP Settings Section
local SettingsSection = Instance.new("Frame")
SettingsSection.Size = UDim2.new(1, 0, 0, 55)
SettingsSection.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SettingsSection.BorderSizePixel = 0
SettingsSection.Parent = Content

local UICornerSettings = Instance.new("UICorner")
UICornerSettings.CornerRadius = UDim.new(0, 6)
UICornerSettings.Parent = SettingsSection

local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, -20, 0, 20)
SettingsTitle.Position = UDim2.new(0, 10, 0, 5)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "⚙️ Settings"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 13
SettingsTitle.Font = Enum.Font.GothamBold
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = SettingsSection

local NamesToggle = Instance.new("TextButton")
NamesToggle.Size = UDim2.new(0, 85, 0, 18)
NamesToggle.Position = UDim2.new(0, 10, 0, 30)
NamesToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
NamesToggle.BorderSizePixel = 0
NamesToggle.Text = "Names: ON"
NamesToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NamesToggle.TextSize = 10
NamesToggle.Font = Enum.Font.GothamBold
NamesToggle.AutoButtonColor = false
NamesToggle.Parent = SettingsSection

local UICornerNames = Instance.new("UICorner")
UICornerNames.CornerRadius = UDim.new(0, 3)
UICornerNames.Parent = NamesToggle

local DistanceToggle = Instance.new("TextButton")
DistanceToggle.Size = UDim2.new(0, 100, 0, 18)
DistanceToggle.Position = UDim2.new(0, 105, 0, 30)
DistanceToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
DistanceToggle.BorderSizePixel = 0
DistanceToggle.Text = "Distance: ON"
DistanceToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
DistanceToggle.TextSize = 10
DistanceToggle.Font = Enum.Font.GothamBold
DistanceToggle.AutoButtonColor = false
DistanceToggle.Parent = SettingsSection

local UICornerDist = Instance.new("UICorner")
UICornerDist.CornerRadius = UDim.new(0, 3)
UICornerDist.Parent = DistanceToggle

-- // Functions
function updateAllESPColors()
    for player, espData in pairs(playerESP) do
        if espData.highlight and espData.highlight.Parent then
            espData.highlight.OutlineColor = espColor
        end
        if espData.label and espData.label.Parent then
            espData.label.TextColor3 = espColor
        end
    end
end

function formatDistance(distance)
    if distance >= 100 then
        return string.format("%.0f", distance) .. "m"
    else
        return string.format("%.1f", distance) .. "m"
    end
end

-- // Apply custom color
ApplyCustomBtn.MouseButton1Click:Connect(function()
    local r = tonumber(RSlider.Text) or 255
    local g = tonumber(GSlider.Text) or 0
    local b = tonumber(BSlider.Text) or 0
    
    r = math.clamp(math.floor(r), 0, 255)
    g = math.clamp(math.floor(g), 0, 255)
    b = math.clamp(math.floor(b), 0, 255)
    
    espColor = Color3.fromRGB(r, g, b)
    ColorPreview.BackgroundColor3 = espColor
    
    RSlider.Text = tostring(r)
    GSlider.Text = tostring(g)
    BSlider.Text = tostring(b)
    
    updateAllESPColors()
    print("Shina ESP - Custom color applied:", r, g, b)
end)

-- // Toggle Functions
ToggleESP.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    
    if espEnabled then
        ToggleESP.Text = "ON"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        for player, espData in pairs(playerESP) do
            if espData.highlight then espData.highlight.Enabled = true end
            if espData.billboard then espData.billboard.Enabled = true end
        end
    else
        ToggleESP.Text = "OFF"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        
        for player, espData in pairs(playerESP) do
            if espData.highlight then espData.highlight.Enabled = false end
            if espData.billboard then espData.billboard.Enabled = false end
        end
    end
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    menuMinimized = not menuMinimized
    
    if menuMinimized then
        Content.Visible = false
        Menu.Size = UDim2.new(0, 220, 0, 30)
        MinimizeBtn.Text = "+"
    else
        Content.Visible = true
        Menu.Size = UDim2.new(0, 220, 0, 320)
        MinimizeBtn.Text = "-"
    end
end)

NamesToggle.MouseButton1Click:Connect(function()
    showNames = not showNames
    
    if showNames then
        NamesToggle.Text = "Names: ON"
        NamesToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        NamesToggle.Text = "Names: OFF"
        NamesToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
    
    for player, espData in pairs(playerESP) do
        if espData.label then
            espData.label.Visible = showNames
        end
    end
end)

DistanceToggle.MouseButton1Click:Connect(function()
    showDistance = not showDistance
    
    if showDistance then
        DistanceToggle.Text = "Distance: ON"
        DistanceToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        DistanceToggle.Text = "Distance: OFF"
        DistanceToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

-- // Update ESP text with distance
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end
    
    for player, espData in pairs(playerESP) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and 
           LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and
           espData.label and espData.label.Parent then
            
            local distance = (player.Character.HumanoidRootPart.Position - 
                            LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            
            if showDistance then
                espData.label.Text = player.Name .. " [" .. formatDistance(distance) .. "]"
            else
                espData.label.Text = player.Name
            end
        end
    end
end)

-- // Create ESP for player
local function createESP(player)
    if player == LocalPlayer then return end
    
    local function setupESP(character)
        if not character:FindFirstChild("HumanoidRootPart") then
            character:WaitForChild("HumanoidRootPart", 5)
        end
        
        if playerESP[player] then
            if playerESP[player].highlight then
                playerESP[player].highlight:Destroy()
            end
            if playerESP[player].billboard then
                playerESP[player].billboard:Destroy()
            end
        end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "ShinaESP"
        highlight.FillTransparency = 0.5
        highlight.OutlineColor = espColor
        highlight.OutlineTransparency = 0
        highlight.Enabled = espEnabled
        highlight.Parent = character
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ShinaESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 200, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.Enabled = espEnabled
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = player.Name
        label.TextColor3 = espColor
        label.TextStrokeTransparency = 0.5
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.Visible = showNames
        label.Parent = billboard
        
        billboard.Parent = character
        
        playerESP[player] = {
            highlight = highlight,
            billboard = billboard,
            label = label
        }
    end
    
    if player.Character then
        setupESP(player.Character)
    end
    
    player.CharacterAdded:Connect(function(character)
        setupESP(character)
    end)
end

-- // Remove ESP
local function removeESP(player)
    if playerESP[player] then
        if playerESP[player].highlight then
            playerESP[player].highlight:Destroy()
        end
        if playerESP[player].billboard then
            playerESP[player].billboard:Destroy()
        end
        playerESP[player] = nil
    end
end

-- // Initialize
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createESP(player)
    end
end

Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        createESP(player)
    end
end)

Players.PlayerRemoving:Connect(removeESP)

-- // Handle respawn
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    for player, _ in pairs(playerESP) do
        removeESP(player)
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createESP(player)
        end
    end
end)

-- // Keyboard shortcut (Right Shift to toggle ESP)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.RightShift then
        espEnabled = not espEnabled
        
        if espEnabled then
            ToggleESP.Text = "ON"
            ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        else
            ToggleESP.Text = "OFF"
            ToggleESP.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end
        
        for player, espData in pairs(playerESP) do
            if espData.highlight then espData.highlight.Enabled = espEnabled end
            if espData.billboard then espData.billboard.Enabled = espEnabled end
        end
    end
end)

print("Shina ESP Script loaded successfully!")
print("Created by Shina | Right Shift to toggle ESP")
