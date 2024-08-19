local TweenService = game:GetService("TweenService")

local Window = {}

function Window:AddWindow(Title)
    local MarkLibrary = Instance.new("ScreenGui")
    local Window = Instance.new("Frame")
    local windowframe = Instance.new("ScrollingFrame")
    local UICorner = Instance.new("UICorner")
    local MinimizeWindow = Instance.new("TextButton")

    -- Properties:
    MarkLibrary.Name = "MarkLibrary"
    MarkLibrary.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MarkLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Window.Parent = MarkLibrary
    Window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Window.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Window.BorderSizePixel = 0
    Window.Position = UDim2.new(0.5, -75, 0.5, -15)
    Window.Size = UDim2.new(0, 150, 0, 30)
    Window.Font = Enum.Font.SourceSans
    Window.Text = Title
    Window.TextColor3 = Color3.fromRGB(255, 255, 255)
    Window.TextSize = 14.000

    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Window

    windowframe.Name = "windowframe"
    windowframe.Parent = Window
    windowframe.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
    windowframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
    windowframe.BorderSizePixel = 0
    windowframe.Position = UDim2.new(0, 0, 1, 0)
    windowframe.Size = UDim2.new(0, 150, 0, 36)
    windowframe.ScrollBarThickness = 3

    MinimizeWindow.Name = "MinimizeWindow"
    MinimizeWindow.Parent = Window
    MinimizeWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeWindow.BackgroundTransparency = 1.000
    MinimizeWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeWindow.BorderSizePixel = 0
    MinimizeWindow.Position = UDim2.new(0.8, 0, 0, 0)
    MinimizeWindow.Size = UDim2.new(0, 30, 0, 30)
    MinimizeWindow.Font = Enum.Font.SourceSans
    MinimizeWindow.Text = "-"
    MinimizeWindow.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeWindow.TextScaled = true
    MinimizeWindow.TextSize = 14.000
    MinimizeWindow.TextWrapped = true

    -- Dragging functionality
    local function dragWindow()
        local UIS = game:GetService('UserInputService')
        local dragToggle = nil
        local dragSpeed = 0.25
        local dragStart = nil
        local startPos = nil

        local function updateInput(input)
            local delta = input.Position - dragStart
            local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            TweenService:Create(Window, TweenInfo.new(dragSpeed), {Position = position}):Play()
        end

        Window.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1) then 
                dragToggle = true
                dragStart = input.Position
                startPos = Window.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if dragToggle then
                    updateInput(input)
                end
            end
        end)
    end
    dragWindow()

    -- Minimize functionality
    local function MinimizeWindowScript()
        local isMinimized = false
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local minimizeTween = TweenService:Create(windowframe, tweenInfo, {Size = UDim2.new(0, 1, 0, 1)})
        local restoreTween = TweenService:Create(windowframe, tweenInfo, {Size = UDim2.new(0, 150, 0, 36)})

        MinimizeWindow.MouseButton1Click:Connect(function()
            if not isMinimized then
                minimizeTween:Play()
                MinimizeWindow.Text = "+"
                isMinimized = true
            else
                restoreTween:Play()
                MinimizeWindow.Text = "-"
                isMinimized = false
            end
        end)
    end
    MinimizeWindowScript()

    local Section = {}
    local Elements = {}

    function Section:AddSection(Name)
        local section = Instance.new("Frame")
        section.Parent = windowframe
        section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        section.BorderSizePixel = 0
        section.Position = UDim2.new(0, 0, 0, 30)
        section.Size = UDim2.new(0, 150, 0, 30)
        section.Font = Enum.Font.SourceSans
        section.Text = Name
        section.TextColor3 = Color3.fromRGB(255, 255, 255)
        section.TextSize = 14.000

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = section

        local MinimizeSection = Instance.new("TextButton")
        MinimizeSection.Name = "MinimizeSection"
        MinimizeSection.Parent = section
        MinimizeSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeSection.BackgroundTransparency = 1.000
        MinimizeSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
        MinimizeSection.BorderSizePixel = 0
        MinimizeSection.Position = UDim2.new(0.8, 0, 0, 0)
        MinimizeSection.Size = UDim2.new(0, 30, 0, 30)
        MinimizeSection.Font = Enum.Font.SourceSans
        MinimizeSection.Text = "-"
        MinimizeSection.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeSection.TextScaled = true
        MinimizeSection.TextSize = 14.000
        MinimizeSection.TextWrapped = true

        local SectionFrame = Instance.new("ScrollingFrame")
        SectionFrame.Parent = section
        SectionFrame.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
        SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Position = UDim2.new(0, 0, 1, 0)
        SectionFrame.Size = UDim2.new(0, 150, 0, 70)
        SectionFrame.ScrollBarThickness = 3
        SectionFrame.ClipsDescendants = true

        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.Parent = SectionFrame
        UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 3)

        -- Store SectionFrame in Section table for later use
        self.SectionFrame = SectionFrame
        
            -- Create a LocalScript for MinimizeSection functionality
    local function MinimizeSectionScript()
        local script = Instance.new('LocalScript', MinimizeSection)
        local isMinimized = false

        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local minimizeTween = TweenService:Create(SectionFrame, tweenInfo, {Size = UDim2.new(0, 150, 0, 1)})
        local restoreTween = TweenService:Create(SectionFrame, tweenInfo, {Size = UDim2.new(0, 150, 0, 70)})

        MinimizeSection.MouseButton1Click:Connect(function()
            if not isMinimized then
                minimizeTween:Play()
                MinimizeSection.Text = "+"
                isMinimized = true
            else
                restoreTween:Play()
                MinimizeSection.Text = "-"
                isMinimized = false
            end
        end)
    end
    coroutine.wrap(MinimizeSectionScript)()
    
    -- Function to update SectionFrame size
local function UpdateSectionFrameSize(sectionFrame)
    -- Get the content size needed
    local totalHeight = 0

    -- Calculate total height of the section
    for _, child in ipairs(sectionFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            totalHeight = totalHeight + child.AbsoluteSize.Y
        end
    end

    -- Apply the total height plus padding
    sectionFrame.Size = UDim2.new(0, sectionFrame.AbsoluteSize.X, 0, totalHeight + 10)
end

function Elements:AddButton(Name, Call)
    local Button = Instance.new("TextButton")
    Button.Parent = self.SectionFrame
    Button.BackgroundColor3 = Color3.fromRGB(78, 78, 78)
    Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Button.BorderSizePixel = 0
    Button.Position = UDim2.new(0.0133333337, 0, 0, 0)
    Button.Size = UDim2.new(0, 146, 0, 30)
    Button.Font = Enum.Font.SourceSans
    Button.Text = Name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14.000

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        pcall(Call)
    end)

    -- Update SectionFrame size after adding a button
    UpdateSectionFrameSize(self.SectionFrame)
end

function Elements:AddTextBox(Name, Call)
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = self.SectionFrame
    TextBox.BackgroundColor3 = Color3.fromRGB(78, 78, 78)
    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextBox.BorderSizePixel = 0
    TextBox.Position = UDim2.new(0.0166666675, 0, 0.333333343, 0)
    TextBox.Size = UDim2.new(0, 146, 0, 30)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.PlaceholderText = Name
    TextBox.TextColor3 = Color3.fromRGB(212, 212, 212)
    TextBox.TextSize = 14.000

    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 3)
    UICorner_2.Parent = TextBox

    TextBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            pcall(Call, TextBox.Text)
        end
    end)

    -- Update SectionFrame size after adding a TextBox
    UpdateSectionFrameSize(self.SectionFrame)
end

return Elements
end

return Section
end

return Window
