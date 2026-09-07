local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local CORRECT_PLACE_ID = 123997099105203
local GAME_URL = "https://www.roblox.com/tr/games/123997099105203"

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local introGui = Instance.new("ScreenGui")
introGui.Name = "IntroGui"
introGui.ResetOnSpawn = false
introGui.Parent = playerGui

local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(0, 300, 0, 80)
introFrame.Position = UDim2.new(0.5, -150, 0.4, -40)
introFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
introFrame.BorderSizePixel = 0
introFrame.Parent = introGui

local introCorner = Instance.new("UICorner")
introCorner.CornerRadius = UDim.new(0, 12)
introCorner.Parent = introFrame

local introStroke = Instance.new("UIStroke")
introStroke.Thickness = 2.5
introStroke.Parent = introFrame

local introLabel = Instance.new("TextLabel")
introLabel.Size = UDim2.new(1, 0, 1, 0)
introLabel.BackgroundTransparency = 1
introLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
introLabel.TextSize = 18
introLabel.Font = Enum.Font.GothamBold
introLabel.Text = "PRODUCED BY OZGR"
introLabel.Parent = introFrame

local introConnection
introConnection = RunService.RenderStepped:Connect(function()
    local hue = (tick() % 2) / 2
    local rainbowColor = Color3.fromHSV(hue, 0.9, 1)
    
    introStroke.Color = rainbowColor
    introLabel.TextColor3 = rainbowColor
end)

task.wait(2.5)
if introConnection then introConnection:Disconnect() end
introGui:Destroy()

if game.PlaceId ~= CORRECT_PLACE_ID then
    warn("Wrong game! Redirecting to the original game...")
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "WrongGameGui"
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 140)
    frame.Position = UDim2.new(0.5, -160, 0.4, -70)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 60, 60)
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 50)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.Text = "Wrong Game! Teleporting...\nIf it fails, copy the Game URL below."
    label.Parent = frame

    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(1, -30, 0, 35)
    copyBtn.Position = UDim2.new(0, 15, 1, -45)
    copyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.TextSize = 13
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.Text = "COPY GAME LINK"
    copyBtn.AutoButtonColor = false
    copyBtn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = copyBtn

    copyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(GAME_URL)
            copyBtn.Text = "LINK COPIED!"
            copyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            task.wait(2)
            copyBtn.Text = "COPY GAME LINK"
            copyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        else
            copyBtn.Text = "COPY FAILED"
        end
    end)

    task.wait(1)
    pcall(function()
        TeleportService:Teleport(CORRECT_PLACE_ID, player)
    end)
    return
end

local mainGui = Instance.new("ScreenGui")
mainGui.Name = "DestroyHaystackGui"
mainGui.ResetOnSpawn = false
mainGui.Parent = playerGui

local destroyBtn = Instance.new("TextButton")
destroyBtn.Name = "DestroyButton"
destroyBtn.Size = UDim2.new(0, 170, 0, 45)
destroyBtn.Position = UDim2.new(0, 20, 0.5, -22)
destroyBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
destroyBtn.BorderSizePixel = 0
destroyBtn.Text = "DESTROY HAYSTACK"
destroyBtn.TextSize = 12
destroyBtn.Font = Enum.Font.GothamBold
destroyBtn.AutoButtonColor = false
destroyBtn.Parent = mainGui

local btnUiCorner = Instance.new("UICorner")
btnUiCorner.CornerRadius = UDim.new(0, 10)
btnUiCorner.Parent = destroyBtn

local btnUiStroke = Instance.new("UIStroke")
btnUiStroke.Thickness = 2.5
btnUiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
btnUiStroke.Parent = destroyBtn

local isCustomStatus = false
RunService.RenderStepped:Connect(function()
    if not isCustomStatus then
        local hue = (tick() % 2) / 2
        local rainbowColor = Color3.fromHSV(hue, 0.9, 1)
        
        btnUiStroke.Color = rainbowColor
        destroyBtn.TextColor3 = rainbowColor
    end
end)

local function highlightNeedle(needle)
    if not needle then return end

    if not needle:FindFirstChild("CleanHighlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "CleanHighlight"
        highlight.FillColor = Color3.fromRGB(0, 230, 255)
        highlight.FillTransparency = 0.1
        highlight.OutlineTransparency = 1
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = needle
    end

    if not needle:FindFirstChild("NeedleRing") then
        local ring = Instance.new("CylinderHandleAdornment")
        ring.Name = "NeedleRing"
        ring.Adornee = needle
        ring.AlwaysOnTop = true
        ring.CFrame = CFrame.Angles(math.rad(90), 0, 0)
        ring.Height = 0.2
        ring.Radius = 3
        ring.InnerRadius = 2.6
        ring.Color3 = Color3.fromRGB(0, 230, 255)
        ring.Transparency = 0.2
        ring.Parent = needle
    end

    if not needle:FindFirstChild("NeedleText") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "NeedleText"
        billboard.Size = UDim2.new(0, 150, 0, 40)
        billboard.Adornee = needle
        billboard.AlwaysOnTop = true
        billboard.ExtentsOffset = Vector3.new(0, 3.5, 0)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "İĞNE BURADA!"
        label.TextColor3 = Color3.fromRGB(0, 255, 220)
        label.TextSize = 15
        label.Font = Enum.Font.GothamBold

        local textStroke = Instance.new("UIStroke")
        textStroke.Thickness = 2
        textStroke.Color = Color3.fromRGB(0, 0, 0)
        textStroke.Parent = label

        label.Parent = billboard
        billboard.Parent = needle
    end
end

destroyBtn.MouseButton1Click:Connect(function()
    local haystack = workspace:FindFirstChild("Haystack")
    if haystack then
        local deletedCount = 0
        for _, descendant in ipairs(haystack:GetDescendants()) do
            if descendant.Name == "HayPiece" then
                descendant:Destroy()
                deletedCount = deletedCount + 1
            end
        end
        
        isCustomStatus = true
        if deletedCount > 0 then
            destroyBtn.Text = "DESTROYED!"
            destroyBtn.TextColor3 = Color3.fromRGB(0, 255, 120)
            btnUiStroke.Color = Color3.fromRGB(0, 255, 120)
        else
            destroyBtn.Text = "NOTHING TO DESTROY"
            destroyBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
            btnUiStroke.Color = Color3.fromRGB(255, 200, 0)
        end
        
        task.wait(1.5)
        destroyBtn.Text = "DESTROY HAYSTACK"
        isCustomStatus = false
    else
        isCustomStatus = true
        destroyBtn.Text = "NOT FOUND"
        destroyBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
        btnUiStroke.Color = Color3.fromRGB(255, 60, 60)
        task.wait(1.5)
        destroyBtn.Text = "DESTROY HAYSTACK"
        isCustomStatus = false
    end
end)

local existingNeedle = workspace:FindFirstChild("Haystack") and workspace.Haystack:FindFirstChild("Needle")
if existingNeedle then
    highlightNeedle(existingNeedle)
end

workspace.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "Needle" then
        highlightNeedle(descendant)
    end
end)
