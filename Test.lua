local TweenService = game:GetService("TweenService")

local Window = {}

function Window:AddWindow(Title)
    local Elements = {}

    -- Create main GUI elements
    local MarkLibrary = Instance.new("ScreenGui")
    local WindowFrame = Instance.new("Frame")
    local TitleLabel = Instance.new("TextLabel")
    local MinimizeWindow = Instance.new("TextButton")
    local ContentFrame = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Configure MarkLibrary
    MarkLibrary.Name = "MarkLibrary"
    MarkLibrary.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MarkLibrary.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Configure WindowFrame
    WindowFrame.Name = "WindowFrame"
    WindowFrame.Parent = MarkLibrary
    WindowFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    WindowFrame.Size = UDim2.new(0, 200, 0, 30)
    WindowFrame.Position = UDim2.new(0.5, -100, 0.5, -15)
    WindowFrame.Active = true
    WindowFrame.Draggable = true

    -- Configure TitleLabel
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = WindowFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18

    -- Configure MinimizeWindow
    MinimizeWindow.Name = "MinimizeWindow"
    MinimizeWindow.Parent = WindowFrame
    MinimizeWindow.BackgroundTransparency = 1
    MinimizeWindow.Size = UDim2.new(0.2, 0, 1, 0)
    MinimizeWindow.Position = UDim2.new(0.8, 0, 0, 0)
    MinimizeWindow.Font = Enum.Font.SourceSans
    MinimizeWindow.Text = "-"
    MinimizeWindow.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeWindow.TextSize = 24

    -- Configure ContentFrame
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = WindowFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(41, 41, 41)
    ContentFrame.Position = UDim2.new(0, 0, 1, 0)
    ContentFrame.Size = UDim2.new(1, 0, 0, 0) -- Initial size zero
    ContentFrame.ClipsDescendants = true
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.ScrollBarThickness = 4

    -- Configure UIListLayout
    UIListLayout.Parent = ContentFrame
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    -- Minimize and maximize functionality
    local isMinimized = false
    MinimizeWindow.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            ContentFrame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.25, true)
            MinimizeWindow.Text = "+"
        else
            local contentSize = UIListLayout.AbsoluteContentSize
            ContentFrame:TweenSize(UDim2.new(1, 0, 0, contentSize.Y + 10), "Out", "Quad", 0.25, true)
            MinimizeWindow.Text = "-"
        end
    end)

    -- Function to update ContentFrame size
    local function updateContentSize()
        local contentSize = UIListLayout.AbsoluteContentSize
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y)
        if not isMinimized then
            ContentFrame:TweenSize(UDim2.new(1, 0, 0, contentSize.Y + 10), "Out", "Quad", 0.2, true)
        end
    end

    -- Elements table to hold AddSection method
    function Elements:AddSection(Name)
        local Section = {}

        -- Create SectionFrame
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Parent = ContentFrame
        SectionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        SectionFrame.Size = UDim2.new(0.95, 0, 0, 30)
        SectionFrame.ClipsDescendants = true

        -- Create SectionTitle
        local SectionTitle = Instance.new("TextLabel")
        SectionTitle.Parent = SectionFrame
        SectionTitle.BackgroundTransparency = 1
        SectionTitle.Size = UDim2.new(0.8, 0, 1, 0)
        SectionTitle.Font = Enum.Font.SourceSansSemibold
        SectionTitle.Text = Name
        SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SectionTitle.TextSize = 16
        SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
        SectionTitle.Position = UDim2.new(0.05, 0, 0, 0)

        -- Create MinimizeSection button
        local MinimizeSection = Instance.new("TextButton")
        MinimizeSection.Parent = SectionFrame
        MinimizeSection.BackgroundTransparency = 1
        MinimizeSection.Size = UDim2.new(0.15, 0, 1, 0)
        MinimizeSection.Position = UDim2.new(0.85, 0, 0, 0)
        MinimizeSection.Font = Enum.Font.SourceSans
        MinimizeSection.Text = "-"
        MinimizeSection.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinimizeSection.TextSize = 20

        -- Create ItemsFrame inside SectionFrame
        local ItemsFrame = Instance.new("Frame")
        ItemsFrame.Parent = SectionFrame
        ItemsFrame.BackgroundTransparency = 1
        ItemsFrame.Position = UDim2.new(0, 0, 1, 0)
        ItemsFrame.Size = UDim2.new(1, 0, 0, 0)

        -- UIListLayout for ItemsFrame
        local ItemsLayout = Instance.new("UIListLayout")
        ItemsLayout.Parent = ItemsFrame
        ItemsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ItemsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ItemsLayout.Padding = UDim.new(0, 5)

        -- Minimize and maximize functionality for Section
        local sectionMinimized = false
        MinimizeSection.MouseButton1Click:Connect(function()
            sectionMinimized = not sectionMinimized
            if sectionMinimized then
                ItemsFrame:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.25, true)
                MinimizeSection.Text = "+"
            else
                local itemsSize = ItemsLayout.AbsoluteContentSize
                ItemsFrame:TweenSize(UDim2.new(1, 0, 0, itemsSize.Y + 10), "Out", "Quad", 0.25, true)
                MinimizeSection.Text = "-"
            end
            -- Update ContentFrame size
            updateContentSize()
        end)

        -- Function to update SectionFrame size
        local function updateSectionSize()
            local itemsSize = ItemsLayout.AbsoluteContentSize
            if not sectionMinimized then
                ItemsFrame.Size = UDim2.new(1, 0, 0, itemsSize.Y + 10)
            end
            SectionFrame.Size = UDim2.new(0.95, 0, 0, ItemsFrame.Size.Y.Offset + 30)
            -- Update ContentFrame size
            updateContentSize()
        end

        -- Methods to add elements to the section
        function Section:AddButton(ButtonText, Callback)
            local Button = Instance.new("TextButton")
            Button.Parent = ItemsFrame
            Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Button.Size = UDim2.new(0.95, 0, 0, 30)
            Button.Font = Enum.Font.SourceSans
            Button.Text = ButtonText
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 16
            Button.AutoButtonColor = true

            Button.MouseButton1Click:Connect(function()
                if Callback and type(Callback) == "function" then
                    pcall(Callback)
                end
            end)

            updateSectionSize()
        end

        function Section:AddTextBox(PlaceholderText, Callback)
            local TextBox = Instance.new("TextBox")
            TextBox.Parent = ItemsFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            TextBox.Size = UDim2.new(0.95, 0, 0, 30)
            TextBox.Font = Enum.Font.SourceSans
            TextBox.PlaceholderText = PlaceholderText
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 16
            TextBox.ClearTextOnFocus = false

            TextBox.FocusLost:Connect(function(enterPressed)
                if enterPressed and Callback and type(Callback) == "function" then
                    pcall(Callback, TextBox.Text)
                end
            end)

            updateSectionSize()
        end

        -- Return the Section object
        return Section
    end

    -- Return Elements to allow chaining
    return Elements
end

return Window
