-- Place this LocalScript under StarterGui (or under a ScreenGui in StarterGui)
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Settings
local imageSource = "https://t.me/RBLX_Scripts_Myanmar/308" -- replace with rbxassetid://ID if needed
local telegramUrl = "https://t.me/RBLX_Scripts_Myanmar/308"
local dialogName = "RBLXScriptsDialog"

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = dialogName
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main black rectangle (Frame)
local frame = Instance.new("Frame")
frame.Name = "BlackRect"
frame.Size = UDim2.new(0, 520, 0, 220) -- width, height
frame.Position = UDim2.new(0.5, -260, 0.5, -110) -- center
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0 -- fully black
frame.BorderSizePixel = 0
frame.Parent = screenGui

-- Optional: subtle rounded corners (UICorner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

-- Photo at top-left (ImageLabel)
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "TopLeftImage"
imageLabel.Parent = frame
imageLabel.Size = UDim2.new(0, 120, 0, 120)
imageLabel.Position = UDim2.new(0, 12, 0, 12)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = imageSource
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.ClipsDescendants = true

-- If you want a border / small background under image
local imgBg = Instance.new("Frame")
imgBg.Name = "ImageBg"
imgBg.Size = UDim2.new(0, 120, 0, 120)
imgBg.Position = imageLabel.Position
imgBg.BackgroundColor3 = Color3.fromRGB(25,25,25)
imgBg.BorderSizePixel = 0
imgBg.Parent = frame
imgBg.ZIndex = imageLabel.ZIndex - 1
local imgBgCorner = Instance.new("UICorner", imgBg)
imgBgCorner.CornerRadius = UDim.new(0, 6)

-- Body text inside rectangle
local bodyText = Instance.new("TextLabel")
bodyText.Name = "BodyText"
bodyText.Parent = frame
bodyText.Size = UDim2.new(0, 360, 0, 120)
bodyText.Position = UDim2.new(0, 144, 0, 12)
bodyText.BackgroundTransparency = 1
bodyText.TextXAlignment = Enum.TextXAlignment.Left
bodyText.TextYAlignment = Enum.TextYAlignment.Top
bodyText.Font = Enum.Font.Gotham
bodyText.TextSize = 20
bodyText.TextWrapped = true
bodyText.RichText = true
bodyText.Text = "More Scripts On\n<t><b>t.me/RBLX_SCRIPTS_MYANMAR</b></t>"
bodyText.TextColor3 = Color3.fromRGB(255, 255, 255)
bodyText.ZIndex = 2

-- Transparent button overlay on the link text to open the Telegram URL
local linkButton = Instance.new("TextButton")
linkButton.Name = "LinkButton"
linkButton.Parent = frame
linkButton.Size = UDim2.new(0, 300, 0, 40)
linkButton.Position = UDim2.new(0, 144, 0, 64) -- sits over the second line
linkButton.BackgroundTransparency = 1
linkButton.Text = "" -- no visible text (we use the bodyText for visuals)
linkButton.ZIndex = 3

-- Tooltip-style small label to indicate clickable link
local linkLabel = Instance.new("TextLabel")
linkLabel.Name = "LinkLabel"
linkLabel.Parent = linkButton
linkLabel.Size = UDim2.new(1, 0, 1, 0)
linkLabel.BackgroundTransparency = 1
linkLabel.Text = "Open Link"
linkLabel.Font = Enum.Font.Gotham
linkLabel.TextSize = 14
linkLabel.TextColor3 = Color3.fromRGB(170, 170, 255)
linkLabel.TextTransparency = 0.6
linkLabel.TextXAlignment = Enum.TextXAlignment.Left
linkLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Click behavior: open external telegram link
linkButton.MouseButton1Click:Connect(function()
    -- Try using GuiService.OpenBrowserWindow, may be blocked in some contexts
    if GuiService and GuiService.OpenBrowserWindow then
        pcall(function()
            GuiService:OpenBrowserWindow(telegramUrl)
        end)
    else
        -- Fallback: try SetCore if available (some clients)
        local success, err = pcall(function()
            game:GetService("StarterGui"):SetCore("OpenBrowser", telegramUrl)
        end)
        if not success then
            -- Last fallback: show a small prompt with the URL
            local info = Instance.new("TextLabel")
            info.Name = "UrlInfo"
            info.Parent = frame
            info.Size = UDim2.new(0, 360, 0, 28)
            info.Position = UDim2.new(0, 144, 0, 112)
            info.BackgroundTransparency = 0.3
            info.BackgroundColor3 = Color3.fromRGB(30,30,30)
            info.TextColor3 = Color3.fromRGB(255,255,255)
            info.TextSize = 14
            info.Text = "Open this link in your browser:\n" .. telegramUrl
            info.TextWrapped = true
            wait(5)
            info:Destroy()
        end
    end
end)

-- OK button (top-right corner of the frame)
local okButton = Instance.new("TextButton")
okButton.Name = "OkButton"
okButton.Parent = frame
okButton.Size = UDim2.new(0, 64, 0, 32)
okButton.Position = UDim2.new(1, -76, 0, 12) -- top-right with padding
okButton.AnchorPoint = Vector2.new(0, 0)
okButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
okButton.TextColor3 = Color3.fromRGB(0, 0, 0)
okButton.Font = Enum.Font.GothamBold
okButton.TextSize = 18
okButton.Text = "OK"
okButton.AutoButtonColor = true
okButton.ZIndex = 4

local okCorner = Instance.new("UICorner", okButton)
okCorner.CornerRadius = UDim.new(0, 6)

okButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Small drop shadow (Frame) for nicer look (optional)
local shadow = Instance.new("ImageLabel")
shadow.Name = "DropShadow"
shadow.Parent = screenGui
shadow.Size = UDim2.new(0, 540, 0, 240)
shadow.Position = frame.Position + UDim2.new(0, 10, 0, 10)
shadow.AnchorPoint = frame.AnchorPoint
shadow.BackgroundTransparency = 1
shadow.Image = "rbxasset://textures/ui/Tooltip/tooltip_shadow.png"
shadow.ImageTransparency = 0.4
shadow.ZIndex = 0

-- Ensure the frame is front-most
frame.ZIndex = 5

local a = game.Lighting
a.Ambient = Color3.fromRGB(33, 33, 33)
a.Brightness = 5.69
a.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
a.ColorShift_Top = Color3.fromRGB(255, 247, 237)
a.EnvironmentDiffuseScale = 0.105
a.EnvironmentSpecularScale = 0.522
a.GlobalShadows = true
a.OutdoorAmbient = Color3.fromRGB(51, 54, 67)
a.ShadowSoftness = 0.18
a.GeographicLatitude = -15.525
a.ExposureCompensation = 0.75
b.Enabled = true
b.Intensity = 0.99
b.Size = 9999 
b.Threshold = 0
local c = Instance.new("ColorCorrectionEffect", a)
c.Brightness = 0.015
c.Contrast = 0.25
c.Enabled = true
c.Saturation = 0.2
c.TintColor = Color3.fromRGB(217, 145, 57)
if getgenv().mode == "Summer" then
   c.TintColor = Color3.fromRGB(255, 220, 148)
elseif getgenv().mode == "Autumn" then
   c.TintColor = Color3.fromRGB(217, 145, 57)
else
   warn("No mode selected!")
   print("Please select a mode")
   b:Destroy()
   c:Destroy()
end
local d = Instance.new("DepthOfFieldEffect", a)
d.Enabled = true
d.FarIntensity = 0.077
d.FocusDistance = 21.54
d.InFocusRadius = 20.77
d.NearIntensity = 0.277
local e = Instance.new("ColorCorrectionEffect", a)
e.Brightness = 0
e.Contrast = -0.07
e.Saturation = 0
e.Enabled = true
e.TintColor = Color3.fromRGB(255, 247, 239)
local e2 = Instance.new("ColorCorrectionEffect", a)
e2.Brightness = 0.2
e2.Contrast = 0.45
e2.Saturation = -0.1
e2.Enabled = true
e2.TintColor = Color3.fromRGB(255, 255, 255)
local s = Instance.new("SunRaysEffect", a)
s.Enabled = true
s.Intensity = 0.01
s.Spread = 0.146
