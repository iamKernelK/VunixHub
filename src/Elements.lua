local TweenService = game:GetService("TweenService")
local Elements = {}
function Elements:CreateButton(scroll, theme, text, callback)
    local Btn = Instance.new("TextButton", scroll); Btn.Size = UDim2.new(1, -10, 0, 38); Btn.BackgroundColor3 = theme.ElementBG; Btn.Text = text; Btn.TextColor3 = theme.Text; Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Btn).Color = Color3.fromRGB(50, 50, 60)
    Btn.MouseEnter:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.Accent1, TextColor3 = Color3.fromRGB(0,0,0)}):Play() end)
    Btn.MouseLeave:Connect(function() TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.ElementBG, TextColor3 = theme.Text}):Play() end)
    Btn.MouseButton1Click:Connect(function() pcall(callback) end)
end
function Elements:CreateToggle(scroll, theme, text, state, callback)
    local Tog = Instance.new("TextButton", scroll); Tog.Size = UDim2.new(1, -10, 0, 38); Tog.BackgroundColor3 = theme.ElementBG; Tog.Text = ""
    Instance.new("UICorner", Tog).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Tog).Color = Color3.fromRGB(50, 50, 60)
    local Lbl = Instance.new("TextLabel", Tog); Lbl.Size = UDim2.new(0.7, 0, 1, 0); Lbl.Position = UDim2.new(0, 12, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Sw = Instance.new("Frame", Tog); Sw.Size = UDim2.new(0, 34, 0, 18); Sw.Position = UDim2.new(1, -46, 0.5, -9); Sw.BackgroundColor3 = state and theme.Accent1 or Color3.fromRGB(60,60,70); Instance.new("UICorner", Sw).CornerRadius = UDim.new(1, 0)
    local B = Instance.new("Frame", Sw); B.Size = UDim2.new(0, 14, 0, 14); B.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7); B.BackgroundColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", B).CornerRadius = UDim.new(1, 0)
    Tog.MouseButton1Click:Connect(function() state = not state; TweenService:Create(B, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play(); TweenService:Create(Sw, TweenInfo.new(0.2), {BackgroundColor3 = state and theme.Accent1 or Color3.fromRGB(60,60,70)}):Play(); pcall(callback, state) end)
end
function Elements:CreateSlider(scroll, theme, text, min, max, default, callback)
    local SFrame = Instance.new("Frame", scroll); SFrame.Size = UDim2.new(1, -10, 0, 46); SFrame.BackgroundColor3 = theme.ElementBG; Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 6)
    local Lbl = Instance.new("TextLabel", SFrame); Lbl.Size = UDim2.new(1, -24, 0, 20); Lbl.Position = UDim2.new(0, 12, 0, 4); Lbl.BackgroundTransparency = 1; Lbl.Text = text .. ": " .. default; Lbl.TextColor3 = theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 12; Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Bar = Instance.new("TextButton", SFrame); Bar.Size = UDim2.new(1, -24, 0, 4); Bar.Position = UDim2.new(0, 12, 1, -12); Bar.BackgroundColor3 = Color3.fromRGB(60, 60, 70); Bar.Text = ""; Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)
    local Fill = Instance.new("Frame", Bar); Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0); Fill.BackgroundColor3 = theme.Accent1; Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    require(script.Parent.Dragging.Drag_Slider):Init(Bar, Fill, Lbl, text, min, max, default, callback)
end
function Elements:CreateTextbox(scroll, theme, text, placeholder, callback)
    local BoxFrame = Instance.new("Frame", scroll); BoxFrame.Size = UDim2.new(1, -10, 0, 38); BoxFrame.BackgroundColor3 = theme.ElementBG; Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", BoxFrame).Color = Color3.fromRGB(50, 50, 60)
    local Lbl = Instance.new("TextLabel", BoxFrame); Lbl.Size = UDim2.new(0.4, 0, 1, 0); Lbl.Position = UDim2.new(0, 12, 0, 0); Lbl.BackgroundTransparency = 1; Lbl.Text = text; Lbl.TextColor3 = theme.Text; Lbl.Font = Enum.Font.GothamMedium; Lbl.TextSize = 13; Lbl.TextXAlignment = Enum.TextXAlignment.Left
    local Box = Instance.new("TextBox", BoxFrame); Box.Size = UDim2.new(0.5, 0, 0, 26); Box.Position = UDim2.new(1, -12, 0.5, -13); Box.AnchorPoint = Vector2.new(1, 0); Box.BackgroundColor3 = Color3.fromRGB(30, 30, 40); Box.Text = ""; Box.PlaceholderText = placeholder; Box.TextColor3 = Color3.fromRGB(255, 255, 255); Box.Font = Enum.Font.Gotham; Box.TextSize = 12; Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
    Box.FocusLost:Connect(function(enter) if enter then pcall(callback, Box.Text) end end)
end
return Elements

