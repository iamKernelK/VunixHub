local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local DragSlider = {}
function DragSlider:Init(bar, fill, lbl, text, min, max, default, cb)
    local drag = false
    local function Update(input)
        local percentage = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + ((max - min) * percentage))
        lbl.Text = text .. ": " .. tostring(val)
        TweenService:Create(fill, TweenInfo.new(0.05), {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
        pcall(cb, val)
    end
    bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true; Update(i) end end)
    UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Update(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)
end
return DragSlider

