local VunixLib = {}
local Themes = require(script.Parent.Themes)
local Icons = require(script.Parent.Icons)
local Elements = require(script.Parent.Elements)
local Notify = require(script.Parent.Notify)
function VunixLib:CreateWindow(hubName, selectedThemeName, logoIconName)
    local Theme = Themes[selectedThemeName] or Themes["Vunix Neon"]
    local TargetScreen = (gethui and gethui()) or game:GetService("CoreGui")
    if TargetScreen:FindFirstChild("VunixUI") then TargetScreen.VunixUI:Destroy() end
    local ScreenGui = Instance.new("ScreenGui", TargetScreen); ScreenGui.Name = "VunixUI"; ScreenGui.ResetOnSpawn = false
    local MainFrame = Instance.new("CanvasGroup", ScreenGui); MainFrame.Size = UDim2.new(0, 550, 0, 380); MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190); MainFrame.BackgroundColor3 = Theme.Background; Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10); local MainStroke = Instance.new("UIStroke", MainFrame); MainStroke.Color = Theme.Accent1; MainStroke.Thickness = 1.2
    local TopBar = Instance.new("Frame", MainFrame); TopBar.Size = UDim2.new(1, 0, 0, 40); TopBar.BackgroundTransparency = 1
    local Logo = Instance.new("ImageLabel", TopBar); Logo.Size = UDim2.new(0, 20, 0, 20); Logo.Position = UDim2.new(0, 12, 0.5, -10); Logo.BackgroundTransparency = 1; Logo.Image = Icons[logoIconName]
    local Title = Instance.new("TextLabel", TopBar); Title.Size = UDim2.new(1, -50, 1, 0); Title.Position = UDim2.new(0, 40, 0, 0); Title.BackgroundTransparency = 1; Title.Text = hubName; Title.TextColor3 = Theme.Text; Title.Font = Enum.Font.GothamBold; Title.TextSize = 14; Title.TextXAlignment = Enum.TextXAlignment.Left
    require(script.Parent.Dragging.Drag_Window):Apply(TopBar, MainFrame)
    local Sidebar = Instance.new("Frame", MainFrame); Sidebar.Size = UDim2.new(0, 130, 1, -50); Sidebar.Position = UDim2.new(0, 12, 0, 45); Sidebar.BackgroundTransparency = 1; local SideLayout = Instance.new("UIListLayout", Sidebar); SideLayout.Padding = UDim.new(0, 4)
    local ContentArea = Instance.new("Frame", MainFrame); ContentArea.Size = UDim2.new(1, -160, 1, -50); ContentArea.Position = UDim2.new(0, 150, 0, 45); ContentArea.BackgroundTransparency = 1
    local WindowObj = {FirstTab = nil, Tabs = {}}
    function WindowObj:Notify(title, msg, duration) Notify:Create(ScreenGui, Theme, title, msg, duration) end
    function WindowObj:CreateTab(tabName)
        local TabBtn = Instance.new("TextButton", Sidebar); TabBtn.Size = UDim2.new(1, 0, 0, 30); TabBtn.BackgroundTransparency = 1; TabBtn.Text = "  " .. tabName; TabBtn.TextColor3 = Color3.fromRGB(130,130,130); TabBtn.Font = Enum.Font.GothamBold; TabBtn.TextSize = 12; TabBtn.TextXAlignment = Enum.TextXAlignment.Left; Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 4)
        local Scroll = Instance.new("ScrollingFrame", ContentArea); Scroll.Size = UDim2.new(1, 0, 1, 0); Scroll.BackgroundTransparency = 1; Scroll.Visible = false; Scroll.ScrollBarThickness = 0
        local SLayout = Instance.new("UIListLayout", Scroll); SLayout.Padding = UDim.new(0, 6)
        SLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Scroll.CanvasSize = UDim2.new(0, 0, 0, SLayout.AbsoluteContentSize.Y + 10) end)
        WindowObj.Tabs[tabName] = TabBtn
        local function Show()
            for n, b in pairs(WindowObj.Tabs) do b.BackgroundTransparency = (n == tabName) and 0.9 or 1; b.TextColor3 = (n == tabName) and Theme.Accent1 or Color3.fromRGB(130,130,130) end
            for _, c in pairs(ContentArea:GetChildren()) do c.Visible = (c == Scroll) end
        end
        TabBtn.MouseButton1Click:Connect(Show)
        if not WindowObj.FirstTab then WindowObj.FirstTab = tabName; Show() end
        local TabObj = {}
        function TabObj:CreateButton(t, c) Elements:CreateButton(Scroll, Theme, t, c) end
        function TabObj:CreateToggle(t, s, c) Elements:CreateToggle(Scroll, Theme, t, s, c) end
        function TabObj:CreateSlider(t, mn, mx, d, c) Elements:CreateSlider(Scroll, Theme, t, mn, mx, d, c) end
        function TabObj:CreateTextbox(t, p, c) Elements:CreateTextbox(Scroll, Theme, t, p, c) end
        return TabObj
    end
    return WindowObj
end
return VunixLib

