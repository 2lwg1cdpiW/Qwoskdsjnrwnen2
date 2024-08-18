local Window = {}

function Window:Title(Title)
    -- Create GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local TextLabel = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local UIListLayout = Instance.new("UIListLayout")
    local Frame = Instance.new("ScrollingFrame")
    local TextButton_2 = Instance.new("TextButton")

    -- Set properties for GUI elements
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    TextLabel.Parent = ScreenGui
    TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0, 55, 0, 20)
    TextLabel.Size = UDim2.new(0, 150, 0, 30)
    TextLabel.Font = Enum.Font.SourceSans
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Text = Title
    TextLabel.TextSize = 21
    TextLabel.Font = Enum.Font.GothamBold

    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = TextLabel

    TextButton_2.Parent = TextLabel
    TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextButton_2.BackgroundTransparency = 1
    TextButton_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextButton_2.BorderSizePixel = 0
    TextButton_2.Position = UDim2.new(0.8, 0, -0.033, 0)
    TextButton_2.Size = UDim2.new(0, 30, 0, 30)
    TextButton_2.Font = Enum.Font.SourceSans
    TextButton_2.Text = "-"
    TextButton_2.TextColor3 = Color3.fromRGB(254, 254, 254)
    TextButton_2.TextScaled = true
    TextButton_2.TextSize = 14
    TextButton_2.TextWrapped = true

    local UICorner_Button2 = Instance.new("UICorner")
    UICorner_Button2.CornerRadius = UDim.new(0, 3)
    UICorner_Button2.Parent = TextButton_2

    -- Function to enable smooth dragging of the TextLabel
    local function SmoothDrag()
        local Drag = TextLabel
        local UserInputService = game:GetService("UserInputService")
        local TweenService = game:GetService("TweenService")
        local dragging, dragInput, dragStart, startPos

        local function update(input)
            local delta = input.Position - dragStart
            local dragTime = 0.04
            local SmoothDrag = {}
            SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            local dragSmoothFunction = TweenService:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
            dragSmoothFunction:Play()
        end

        Drag.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Drag.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        Drag.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    SmoothDrag()

    -- Toggle frame size when the "-" button is clicked
    local toggleState = false

    local function toggleFrameSize()
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(
            0.5, -- Animation time
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.InOut
        )
        
        local collapsedSize = UDim2.new(0, 150, 0, 1)
        local expandedSize = UDim2.new(0, 150, 0, 200)

        if toggleState then
            -- Expand the frame
            Frame.Visible = true
            local tweenExpand = tweenService:Create(Frame, tweenInfo, {Size = expandedSize})
            tweenExpand:Play()
        else
            -- Collapse the frame
            local tweenCollapse = tweenService:Create(Frame, tweenInfo, {Size = collapsedSize})
            tweenCollapse:Play()
            tweenCollapse.Completed:Connect(function()
                Frame.Visible = false
            end)
        end
        toggleState = not toggleState
    end

    TextButton_2.MouseButton1Click:Connect(toggleFrameSize)

    local Section = {}

    function Section:AddSection(Name)
        -- Create a new section frame
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Parent = TextLabel
        SectionFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
        SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionFrame.BorderSizePixel = 0
        SectionFrame.Position = UDim2.new(0, 55, 0, 60)
        SectionFrame.Size = UDim2.new(0, 150, 0, 200)
        
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Parent = SectionFrame
        SectionTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
        SectionTitle.BorderSizePixel = 0
        SectionTitle.Size = UDim2.new(1, 0, 0, 30)
        SectionTitle.Font = Enum.Font.SourceSans
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.Text = Name
        SectionTitle.TextSize = 21
        SectionTitle.Font = Enum.Font.GothamBold
        
        local UICorner_Section = Instance.new("UICorner")
        UICorner_Section.CornerRadius = UDim.new(0, 2)
        UICorner_Section.Parent = SectionTitle

        local UIListLayout_Section = Instance.new("UIListLayout")
        UIListLayout_Section.Parent = SectionFrame
        UIListLayout_Section.HorizontalAlignment = Enum.HorizontalAlignment.Center
        UIListLayout_Section.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_Section.Padding = UDim.new(0, 3)

        -- Function to update CanvasSize based on UIListLayout size
        local function updateCanvasSize()
            SectionFrame.CanvasSize = UDim2.new(0, 150, 0, SectionFrame.UIListLayout.AbsoluteContentSize.Y)
        end

        -- Update CanvasSize whenever UIListLayout's content size changes
        UIListLayout_Section:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)

        -- Initial CanvasSize setup
        updateCanvasSize()

        local Elements = {}

        function Elements:AddButton(Name, Call)
            local TextButton = Instance.new("TextButton")
            TextButton.Parent = SectionFrame
            TextButton.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderSizePixel = 0
            TextButton.Size = UDim2.new(0, 145, 0, 30)
            TextButton.Font = Enum.Font.SourceSans
            TextButton.TextColor3 = Color3.fromRGB(220, 220, 220)
            TextButton.Text = Name
            TextButton.TextSize = 16
            TextButton.Font = Enum.Font.GothamBold
            
            local UICorner2 = Instance.new("UICorner")
            UICorner2.CornerRadius = UDim.new(0, 3)
            UICorner2.Parent = TextButton

            TextButton.MouseButton1Click:Connect(function()
                pcall(Call)
            end)
        end

        -- Function to create toggle buttons inside the frame
        function Elements:AddToggle(Name, Call)
            -- Create the container frame for the toggle
            local ToggleContainer = Instance.new("Frame")
            ToggleContainer.Parent = SectionFrame
            ToggleContainer.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
            ToggleContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
            ToggleContainer.BorderSizePixel = 0
            ToggleContainer.Size = UDim2.new(0, 144, 0, 30)
            
                local uiStroke = Instance.new("UIStroke")
    uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border -- Stroke applied to the border
    uiStroke.Color = Color3.fromRGB(220, 220, 220) -- Stroke color (white)
    uiStroke.Thickness = 0.5 -- Stroke thickness
    uiStroke.Parent = ToggleContainer

    -- Create the TextLabel for the toggle title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = ToggleContainer
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(0, 100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TitleLabel.Text = Name
    TitleLabel.TextSize = 16.000
    TitleLabel.Font = Enum.Font.GothamBold

    -- Create the toggle button
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Parent = ToggleContainer
    ToggleButton.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
    ToggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ToggleButton.BorderSizePixel = 2 -- Outline when not toggled
    ToggleButton.BackgroundTransparency = 1
    ToggleButton.Size = UDim2.new(0, 26, 0, 26)
    ToggleButton.Position = UDim2.new(0, 113, 0, 2) -- Positioned to the right
    ToggleButton.Font = Enum.Font.SourceSans
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(220, 220, 220)

    local UICornerButton = Instance.new("UICorner")
    UICornerButton.CornerRadius = UDim.new(0, 6)
    UICornerButton.Parent = ToggleButton

    local isToggled = false

local function updateVisuals()
    if isToggled then
        ToggleButton.BackgroundTransparency = 0
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green color when toggled
        ToggleButton.BorderSizePixel = 0 -- Remove border when toggled
    else
        ToggleButton.BackgroundTransparency = 0.5
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White color when not toggled
        ToggleButton.BorderSizePixel = 2 -- Add border when not toggled
    end
end

    ToggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        updateVisuals()
        pcall(Call, isToggled) -- Pass the state to the callback
    end)

    -- Initial visual update
    updateVisuals()
    
    return {
        Toggle = ToggleButton,
        GetState = function()
            return isToggled
        end
    }
end
            
             function Elements:AddTextBox(Name, DefaultText, Callback)
            local TextBoxFrame = Instance.new("Frame")
            TextBoxFrame.Parent = SectionFrame
            TextBoxFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
            TextBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBoxFrame.BorderSizePixel = 0
            TextBoxFrame.Size = UDim2.new(0, 145, 0, 30)

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = TextBoxFrame
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.Size = UDim2.new(0.5, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.Text = Name
            TextLabel.TextSize = 16
            TextLabel.Font = Enum.Font.GothamBold

            local TextBox = Instance.new("TextBox")
            TextBox.Parent = TextBoxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextBox.BorderSizePixel = 0
            TextBox.Position = UDim2.new(0.5, 0, 0, 0)
            TextBox.Size = UDim2.new(0.5, 0, 1, 0)
            TextBox.Font = Enum.Font.SourceSans
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.Text = DefaultText
            TextBox.TextSize = 16
            TextBox.ClearTextOnFocus = false

            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    pcall(Callback, TextBox.Text)
                end
            end)
        end

        return Elements
    end

    return Section
end

return Window
