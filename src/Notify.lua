local TweenService = game:GetService("TweenService")
local NotifySystem = {}
function NotifySystem:Create(screenGui, theme, title, desc, duration)
    local Holder = screenGui:FindFirstChild("VunixNotifHolder") or Instance.new("Frame", screenGui)
    Holder.Name = "VunixNotifHolder"; Holder.Size = UDim2.new(0, 280, 1, -20); Holder.Position = UDim2.new(1, -20, 0, 10); Holder.AnchorPoint = Vector2.new(1, 0); Holder.BackgroundTransparency = 1
    if not Holder:FindFirstChildOfClass("UIListLayout") then
        local L = Instance.new("UIListLayout", Holder); L.VerticalAlignment = Enum.VerticalAlignment.Bottom; L.HorizontalAlignment = Enum.HorizontalAlignment.Right; L.Padding = UDim.new(0, 10)
    end
    local Card = Instance.new("CanvasGroup", Holder); Card.Size = UDim2.new(1, 0, 0, 75); Card.BackgroundColor3 = theme.ElementBG; Card.GroupTransparency = 1
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 8); Instance.new("UIStroke", Card).Color = theme.Accent1
    local TTitle = Instance.new("TextLabel", Card); TTitle.Size = UDim2.new(1, -20, 0, 25); TTitle.Position = UDim2.new(0, 10, 0, 5); TTitle.BackgroundTransparency = 1; TTitle.Text = title; TTitle.TextColor3 = theme.Text; TTitle.Font = Enum.Font.GothamBold; TTitle.TextSize = 14; TTitle.TextXAlignment = Enum.TextXAlignment.Left
    local TDesc = Instance.new("TextLabel", Card); TDesc.Size = UDim2.new(1, -20, 0, 35); TDesc.Position = UDim2.new(0, 10, 0, 25); TDesc.BackgroundTransparency = 1; TDesc.Text = desc; TDesc.TextColor3 = Color3.fromRGB(180, 180, 180); TDesc.Font = Enum.Font.GothamMedium; TDesc.TextSize = 11; TDesc.TextXAlignment = Enum.TextXAlignment.Left; TDesc.TextWrapped = true
    local Progress = Instance.new("Frame", Card); Progress.Size = UDim2.new(1, 0, 0, 3); Progress.Position = UDim2.new(0, 0, 1, -3); Progress.BackgroundColor3 = theme.Accent1; Progress.BorderSizePixel = 0
    TweenService:Create(Card, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {GroupTransparency = 0.05}):Play()
    TweenService:Create(Progress, TweenInfo.new(duration or 4, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 3)}):Play()
    task.delay(duration or 4, function() if Card then local t = TweenService:Create(Card, TweenInfo.new(0.4), {GroupTransparency = 1}); t:Play(); t.Completed:Connect(function() Card:Destroy() end) end end)
end
return NotifySystem

