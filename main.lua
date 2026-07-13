-- Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local MarketPlaceService = game:GetService("MarketplaceService")

-- --- CONFIGURATION ---
-- If set to "AUTO", it will automatically fetch the current game's actual name!
local GameNameSetting = "AUTO" 
-- ---------------------

-- Resolve Game Name automatically if set to AUTO
local actualGameName = GameNameSetting
if GameNameSetting == "AUTO" then
    local success, info = pcall(function()
        return MarketPlaceService:GetProductInfo(game.PlaceId)
    end)
    actualGameName = (success and info and info.Name) or "unknown universe"
end

-- 1. Create Container inside CoreGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoconutFullScreen_Loader"
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

-- 2. Advanced Cinematic Blur Setup
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 24
blurEffect.Parent = Lighting

local dofEffect = Instance.new("DepthOfFieldEffect")
dofEffect.FarIntensity = 1
dofEffect.FocusDistance = 10
dofEffect.InFocusRadius = 5
dofEffect.NearIntensity = 0.8
dofEffect.Parent = Lighting

-- 3. Fullscreen Matte Vignette Overlay
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "Background"
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
backgroundFrame.BackgroundTransparency = 1 -- Starts hidden for intro fade
backgroundFrame.BorderSizePixel = 0
backgroundFrame.Parent = screenGui

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})
uiGradient.Rotation = 45
uiGradient.Parent = backgroundFrame

-- 4. Safe Center Content Canvas
local canvas = Instance.new("Frame")
canvas.Name = "CenterCanvas"
canvas.Size = UDim2.new(0, 600, 0, 250)
canvas.Position = UDim2.new(0.5, 0, 0.5, 0)
canvas.AnchorPoint = Vector2.new(0.5, 0.5)
canvas.BackgroundTransparency = 1
canvas.Parent = backgroundFrame

-- Layout structure to handle spacing automatically
local uiListLayout = Instance.new("UIListLayout")
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 8) -- Tweaked slightly for better visual breathing room
uiListLayout.Parent = canvas

-- 5. Premium "coconut.xyz" Text Splash Logo
local logoText = Instance.new("TextLabel")
logoText.Name = "LogoText"
logoText.LayoutOrder = 1
logoText.Size = UDim2.new(1, 0, 0, 60)
logoText.BackgroundTransparency = 1
logoText.Text = "coconut.xyz"
logoText.Font = Enum.Font.GothamBold
logoText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Pure Crisp White
logoText.TextSize = 54
logoText.TextTransparency = 1 -- Hidden initially
logoText.Parent = canvas

-- 6. Clean Muted Gray Game Name Subtitle
local gameLabel = Instance.new("TextLabel")
gameLabel.Name = "GameLabel"
gameLabel.LayoutOrder = 2
gameLabel.Size = UDim2.new(1, 0, 0, 24)
gameLabel.BackgroundTransparency = 1
gameLabel.Text = string.lower(actualGameName) -- Modern lowercase look
gameLabel.Font = Enum.Font.Code -- Clean developer/tech style font
gameLabel.TextColor3 = Color3.fromRGB(160, 160, 160) -- Muted silver gray contrast
gameLabel.TextSize = 18 
gameLabel.TextTransparency = 1 -- Hidden initially
gameLabel.Parent = canvas

-- 7. Dedicated Wife Dedication Label + Native Neon Glow
local wifeLabel = Instance.new("TextLabel")
wifeLabel.Name = "WifeLabel"
wifeLabel.LayoutOrder = 3
wifeLabel.Size = UDim2.new(1, 0, 0, 30) -- Matches layout width perfectly
wifeLabel.BackgroundTransparency = 1
wifeLabel.Text = "I LOVE MY WIFE ZEE"
wifeLabel.Font = Enum.Font.GothamBold
wifeLabel.TextColor3 = Color3.fromRGB(211, 170, 50) -- Utilizing your preferred accent color (#aeab89)
wifeLabel.TextSize = 16
wifeLabel.TextTransparency = 1 -- Hidden initially
wifeLabel.ZIndex = 2
wifeLabel.Parent = canvas

-- --- SPEED TIMELINE (Exact 2-Second Sequence) ---

local introTime = 0.5
local holdTime = 1.0
local outroTime = 0.5

local introInfo = TweenInfo.new(introTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local outroInfo = TweenInfo.new(outroTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

-- [0.0s to 0.5s]: Fast Premium Intro Splash
TweenService:Create(backgroundFrame, introInfo, {BackgroundTransparency = 0.45}):Play()
TweenService:Create(logoText, introInfo, {TextTransparency = 0}):Play()
TweenService:Create(gameLabel, introInfo, {TextTransparency = 0}):Play()

-- Fading in your dedication text and glow smoothly here!
TweenService:Create(wifeLabel, introInfo, {TextTransparency = 0}):Play()
task.wait(introTime)

-- [0.5s to 1.5s]: Screen Static Hold
task.wait(holdTime)

-- [1.5s to 2.0s]: Smooth Cinematic Dissolve
TweenService:Create(logoText, outroInfo, {TextTransparency = 1}):Play()
TweenService:Create(gameLabel, outroInfo, {TextTransparency = 1}):Play()

-- Fading out your dedication text and glow smoothly here!
TweenService:Create(wifeLabel, outroInfo, {TextTransparency = 1}):Play()
TweenService:Create(blurEffect, outroInfo, {Size = 0}):Play()
TweenService:Create(dofEffect, outroInfo, {FarIntensity = 0, NearIntensity = 0}):Play()

local finalFade = TweenService:Create(backgroundFrame, outroInfo, {BackgroundTransparency = 1})
finalFade:Play()
finalFade.Completed:Wait()

-- Complete Cleanup
blurEffect:Destroy()
dofEffect:Destroy()
screenGui:Destroy()

-- Parents the UI to the Player's screen
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Create the ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernVersionSelectUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. Create the Main Frame (Modern Dark Glass style)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 200)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -100) -- Centered
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 23) -- Dark obsidian
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

-- Rounded corners for the main frame
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = mainFrame

-- Subtle border stroke for a modern outline look
local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 1.5
frameStroke.Color = Color3.fromRGB(45, 45, 50)
frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
frameStroke.Parent = mainFrame

-- 3. Create Title Text (Clean & Minimalist)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Choose Version"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
titleLabel.Parent = mainFrame

-- Subtitle Text for extra polish
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 20)
subtitleLabel.Position = UDim2.new(0, 0, 0, 45)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Select your preferred environment to continue"
subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
subtitleLabel.Font = Enum.Font.GothamMedium
subtitleLabel.TextSize = 11
subtitleLabel.Parent = mainFrame

-- 4. Create the "New" Button (Sleek Gradient Blue)
local newButton = Instance.new("TextButton")
newButton.Name = "NewButton"
newButton.Size = UDim2.new(0, 130, 0, 48)
newButton.Position = UDim2.new(0.5, -145, 0.65, -10)
newButton.BackgroundColor3 = Color3.fromRGB(0, 132, 255) -- Vibrant Blue
newButton.Text = "New"
newButton.TextColor3 = Color3.fromRGB(255, 255, 255)
newButton.Font = Enum.Font.GothamBold
newButton.TextSize = 15
newButton.AutoButtonColor = false -- Disables default click darkening for custom tweening
newButton.Parent = mainFrame

local newCorner = Instance.new("UICorner")
newCorner.CornerRadius = UDim.new(0, 10)
newCorner.Parent = newButton

-- 5. Create the "Old" Button (Sleek Dark Slate)
local oldButton = Instance.new("TextButton")
oldButton.Name = "OldButton"
oldButton.Size = UDim2.new(0, 130, 0, 48)
oldButton.Position = UDim2.new(0.5, 15, 0.65, -10)
oldButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40) -- Dark Slate Grey
oldButton.Text = "Old"
oldButton.TextColor3 = Color3.fromRGB(200, 200, 210)
oldButton.Font = Enum.Font.GothamBold
oldButton.TextSize = 15
oldButton.AutoButtonColor = false
oldButton.Parent = mainFrame

local oldCorner = Instance.new("UICorner")
oldCorner.CornerRadius = UDim.new(0, 10)
oldCorner.Parent = oldButton

-- Subtle outline border for the Old Button to match modern dark aesthetics
local oldStroke = Instance.new("UIStroke")
oldStroke.Thickness = 1
oldStroke.Color = Color3.fromRGB(60, 60, 65)
oldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
oldStroke.Parent = oldButton


-- =========================================================
-- Animations & Functionality (Tweening)
-- =========================================================

local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Function to handle Hover and Leave animations
local function registerButtonEffects(button, defaultColor, hoverColor, defaultScale, hoverScale)
	button.MouseEnter:Connect(function()
		TweenService:Create(button, tweenInfo, {
			BackgroundColor3 = hoverColor,
			Size = hoverScale
		}):Play()
	end)

	button.MouseLeave:Connect(function()
		TweenService:Create(button, tweenInfo, {
			BackgroundColor3 = defaultColor,
			Size = defaultScale
		}):Play()
	end)
end

-- Assign modern hover physics to the buttons
registerButtonEffects(
	newButton, 
	Color3.fromRGB(0, 132, 255), Color3.fromRGB(25, 150, 255), 
	UDim2.new(0, 130, 0, 48), UDim2.new(0, 134, 0, 50)
)

registerButtonEffects(
	oldButton, 
	Color3.fromRGB(35, 35, 40), Color3.fromRGB(48, 48, 55), 
	UDim2.new(0, 130, 0, 48), UDim2.new(0, 134, 0, 50)
)

-- Function to smoothly fade out and destroy the UI
local function animateClose()
	local fadeInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	-- Fade out elements smoothly
	local fadeOut = TweenService:Create(mainFrame, fadeInfo, {
		Position = UDim2.new(0.5, -170, 0.55, -100), -- Subtle sink-down animation
		BackgroundTransparency = 1
	})
	
	-- Fade text and borders
	TweenService:Create(titleLabel, fadeInfo, {TextTransparency = 1}):Play()
	TweenService:Create(subtitleLabel, fadeInfo, {TextTransparency = 1}):Play()
	TweenService:Create(frameStroke, fadeInfo, {Transparency = 1}):Play()
	
	-- Hide buttons quickly
	TweenService:Create(newButton, fadeInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	TweenService:Create(oldButton, fadeInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
	TweenService:Create(oldStroke, fadeInfo, {Transparency = 1}):Play()

	fadeOut:Play()
	fadeOut.Completed:Connect(function()
		screenGui:Destroy()
	end)
end

-- Click Handlers
newButton.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sudoaptinstallopsec123/coconut/refs/heads/main/newui.lua"))()
	animateClose()
end)

oldButton.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/sudoaptinstallopsec123/coconut/refs/heads/main/old.lua"))()
	animateClose()
end)
