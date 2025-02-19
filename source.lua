--[[
    VortexUI Library
    Created by: vort.5 on discord
]]

local VortexUI = {}

local THEME = {
    BACKGROUND = Color3.fromRGB(40, 30, 60),      -- Dark purple background
    ACCENT = Color3.fromRGB(80, 60, 120),         -- Lighter purple accent
    SECONDARY = Color3.fromRGB(60, 45, 90),       -- Secondary purple
    TEXT = Color3.fromRGB(255, 255, 255),         -- White text
    HOVER = Color3.fromRGB(100, 80, 140),         -- Hover state
    SELECTED = Color3.fromRGB(120, 100, 160),     -- Selected state
    TOGGLE_ON = Color3.fromRGB(130, 110, 200),    -- Toggle on state
    TOGGLE_OFF = Color3.fromRGB(60, 50, 80)       -- Toggle off state
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ANIMS = {
    DURATION = 0.3,
    FADE = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    SLIDE = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
}

local function storeOriginalProperties(instance)
    if not instance:GetAttribute("OriginalProperties") then
        local properties = {}
        if instance:IsA("Frame") or instance:IsA("TextButton") or instance:IsA("TextLabel") or instance:IsA("ScrollingFrame") then
            properties.BackgroundColor3 = instance.BackgroundColor3
            properties.BackgroundTransparency = instance.BackgroundTransparency
        end
        if instance:IsA("TextButton") or instance:IsA("TextLabel") then
            properties.TextColor3 = instance.TextColor3
            properties.TextTransparency = instance.TextTransparency
        end
        instance:SetAttribute("OriginalProperties", game:GetService("HttpService"):JSONEncode(properties))
    end
end

local function restoreOriginalProperties(instance)
    local originalPropertiesJson = instance:GetAttribute("OriginalProperties")
    if originalPropertiesJson then
        local properties = game:GetService("HttpService"):JSONDecode(originalPropertiesJson)
        for property, value in pairs(properties) do
            instance[property] = value
        end
    end
end

local function fadeInstance(instance, fadeOut)
    storeOriginalProperties(instance)
    
    if fadeOut then
        if instance:IsA("Frame") or instance:IsA("TextButton") or instance:IsA("TextLabel") or instance:IsA("ScrollingFrame") then
            TweenService:Create(instance, ANIMS.FADE, {
                BackgroundTransparency = 1
            }):Play()
        end
        if instance:IsA("TextButton") or instance:IsA("TextLabel") then
            TweenService:Create(instance, ANIMS.FADE, {
                TextTransparency = 1
            }):Play()
        end
    else
        restoreOriginalProperties(instance)
    end
end

function VortexUI.new(title)
    local library = {}
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "VortexUI"
    gui.ResetOnSpawn = false
    
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 600, 0, 400)
    main.Position = UDim2.new(0.5, -300, 0.5, -200)
    main.BackgroundColor3 = THEME.BACKGROUND
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Parent = gui
    
    storeOriginalProperties(main)
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 8)
    mainCorner.Parent = main
    
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = THEME.ACCENT
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main
    
    storeOriginalProperties(titleBar)
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar
    
    local sidebarToggle = Instance.new("TextButton")
    sidebarToggle.Name = "SidebarToggle"
    sidebarToggle.Size = UDim2.new(0, 35, 0, 35)
    sidebarToggle.Position = UDim2.new(0, 0, 0, 0)
    sidebarToggle.BackgroundTransparency = 1
    sidebarToggle.Text = "</>"
    sidebarToggle.TextColor3 = THEME.TEXT
    sidebarToggle.TextSize = 18
    sidebarToggle.Font = Enum.Font.Code
    sidebarToggle.Parent = titleBar
    
    storeOriginalProperties(sidebarToggle)
    
    local titleText = Instance.new("TextLabel")
    titleText.Name = "Title"
    titleText.Text = title or "Vortex UI"
    titleText.Size = UDim2.new(1, -100, 1, 0)
    titleText.Position = UDim2.new(0, 40, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.TextColor3 = THEME.TEXT
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    storeOriginalProperties(titleText)
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.Position = UDim2.new(1, -35, 0, 0)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = THEME.TEXT
    closeButton.TextSize = 24
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar
    
    storeOriginalProperties(closeButton)
    
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Size = UDim2.new(1, 0, 1, -35)
    container.Position = UDim2.new(0, 0, 0, 35)
    container.BackgroundTransparency = 1
    container.Parent = main
    
    storeOriginalProperties(container)
   
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 150, 1, 0)
    sidebar.BackgroundColor3 = THEME.SECONDARY
    sidebar.BorderSizePixel = 0
    sidebar.ClipsDescendants = true
    sidebar.Parent = container
    
    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 8)
    sidebarCorner.Parent = sidebar

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(1, -150, 1, 0)
    tabContainer.Position = UDim2.new(0, 150, 0, 0)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = container
    
    storeOriginalProperties(tabContainer)
    
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(0, 20, 0, 20)
    minimizeButton.BackgroundColor3 = THEME.ACCENT
    minimizeButton.Text = "V"
    minimizeButton.TextColor3 = THEME.TEXT
    minimizeButton.TextSize = 18
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Visible = false
    minimizeButton.Parent = gui
    
    storeOriginalProperties(minimizeButton)
    
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 20)
    minimizeCorner.Parent = minimizeButton
    
    local dragging, dragInput, dragStart, startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch) then
            updateDrag(input)
        end
    end)
    
    local currentTab = nil
    local tabs = {}
    
function library:CreateTab(name)
        local tab = {}
        
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Size = UDim2.new(1, -20, 0, 35)
        tabButton.Position = UDim2.new(0, 10, 0, 10 + (#tabs * 45))
        tabButton.BackgroundColor3 = THEME.ACCENT
        tabButton.Text = name
        tabButton.TextColor3 = THEME.TEXT
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.Parent = sidebar
        
        storeOriginalProperties(tabButton)
        
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 6)
        tabButtonCorner.Parent = tabButton
        
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name .. "Content"
        tabContent.Size = UDim2.new(1, -20, 1, -20)
        tabContent.Position = UDim2.new(0, 10, 0, 10)
        tabContent.BackgroundTransparency = 1
        tabContent.ScrollBarThickness = 4
        tabContent.ScrollingEnabled = true
        tabContent.Visible = false
        tabContent.Parent = tabContainer
        
        storeOriginalProperties(tabContent)
        
        local UIListLayout = Instance.new("UIListLayout")
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 10)
        UIListLayout.Parent = tabContent
        
        function tab:Select()
            if currentTab then
                -- Fade out current tab
                currentTab.Content.Visible = false
                currentTab.Button.BackgroundColor3 = THEME.ACCENT
            end
            
            tabContent.Visible = true
            tabButton.BackgroundColor3 = THEME.SELECTED
            currentTab = {Content = tabContent, Button = tabButton}
        end
        
        function tab:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Name = text .. "Button"
            button.Size = UDim2.new(1, 0, 0, 35)
            button.BackgroundColor3 = THEME.ACCENT
            button.Text = text
            button.TextColor3 = THEME.TEXT
            button.TextSize = 14
            button.Font = Enum.Font.Gotham
            button.Parent = tabContent
            
            storeOriginalProperties(button)
            
            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 6)
            buttonCorner.Parent = button
            
            button.MouseEnter:Connect(function()
                TweenService:Create(button, ANIMS.FADE, {
                    BackgroundColor3 = THEME.HOVER
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button, ANIMS.FADE, {
                    BackgroundColor3 = THEME.ACCENT
                }):Play()
            end)
            
            button.MouseButton1Click:Connect(callback)
            return button
        end
        
        function tab:CreateToggle(text, default, callback)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = text .. "Toggle"
            toggleFrame.Size = UDim2.new(1, 0, 0, 35)
            toggleFrame.BackgroundColor3 = THEME.SECONDARY
            toggleFrame.Parent = tabContent
            
            storeOriginalProperties(toggleFrame)
            
local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 6)
            toggleCorner.Parent = toggleFrame
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(1, -60, 1, 0)
            toggleLabel.Position = UDim2.new(0, 10, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = text
            toggleLabel.TextColor3 = THEME.TEXT
            toggleLabel.TextSize = 14
            toggleLabel.Font = Enum.Font.Gotham
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            storeOriginalProperties(toggleLabel)
            
            local toggle = Instance.new("TextButton")
            toggle.Name = "ToggleButton"
            toggle.Size = UDim2.new(0, 40, 0, 20)
            toggle.Position = UDim2.new(1, -50, 0.5, -10)
            toggle.BackgroundColor3 = default and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
            toggle.Text = ""
            toggle.Parent = toggleFrame
            
            storeOriginalProperties(toggle)
            
            local toggleButtonCorner = Instance.new("UICorner")
            toggleButtonCorner.CornerRadius = UDim.new(0, 10)
            toggleButtonCorner.Parent = toggle
            
            local circle = Instance.new("Frame")
            circle.Size = UDim2.new(0, 16, 0, 16)
            circle.Position = UDim2.new(default and 1 or 0, default and -18 or 2, 0.5, -8)
            circle.BackgroundColor3 = THEME.TEXT
            circle.Parent = toggle
            
            storeOriginalProperties(circle)
            
            local circleCorner = Instance.new("UICorner")
            circleCorner.CornerRadius = UDim.new(1, 0)
            circleCorner.Parent = circle
            
            local toggled = default
            toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                TweenService:Create(toggle, ANIMS.FADE, {
                    BackgroundColor3 = toggled and THEME.TOGGLE_ON or THEME.TOGGLE_OFF
                }):Play()
                TweenService:Create(circle, ANIMS.FADE, {
                    Position = toggled and 
                        UDim2.new(1, -18, 0.5, -8) or 
                        UDim2.new(0, 2, 0.5, -8)
                }):Play()
                callback(toggled)
            end)
            
            return toggleFrame
        end
        
        function tab:CreateSlider(text, min, max, default, callback)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Name = text .. "Slider"
            sliderFrame.Size = UDim2.new(1, 0, 0, 50)
            sliderFrame.BackgroundColor3 = THEME.SECONDARY
            sliderFrame.Parent = tabContent
            
            storeOriginalProperties(sliderFrame)
            
            local sliderCorner = Instance.new("UICorner")
            sliderCorner.CornerRadius = UDim.new(0, 6)
            sliderCorner.Parent = sliderFrame
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, -20, 0, 20)
            sliderLabel.Position = UDim2.new(0, 10, 0, 5)
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Text = text
            sliderLabel.TextColor3 = THEME.TEXT
            sliderLabel.TextSize = 14
            sliderLabel.Font = Enum.Font.Gotham
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame
            
            storeOriginalProperties(sliderLabel)
            
            local sliderValue = Instance.new("TextLabel")
            sliderValue.Size = UDim2.new(0, 50, 0, 20)
            sliderValue.Position = UDim2.new(1, -60, 0, 5)
            sliderValue.BackgroundTransparency = 1
            sliderValue.Text = tostring(default)
            sliderValue.TextColor3 = THEME.TEXT
            sliderValue.TextSize = 14
            sliderValue.Font = Enum.Font.Gotham
            sliderValue.Parent = sliderFrame
            
            storeOriginalProperties(sliderValue)
            
            local sliderBg = Instance.new("Frame")
            sliderBg.Name = "Background"
            sliderBg.Size = UDim2.new(1, -20, 0, 4)
            sliderBg.Position = UDim2.new(0, 10, 0, 35)
            sliderBg.BackgroundColor3 = THEME.BACKGROUND
            sliderBg.Parent = sliderFrame
            

            storeOriginalProperties(sliderBg)
            
            local sliderBgCorner = Instance.new("UICorner")
            sliderBgCorner.CornerRadius = UDim.new(1, 0)
            sliderBgCorner.Parent = sliderBg
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Name = "Fill"
            sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
            sliderFill.BackgroundColor3 = THEME.ACCENT
            sliderFill.Parent = sliderBg
            
            storeOriginalProperties(sliderFill)
            
            local sliderFillCorner = Instance.new("UICorner")
            sliderFillCorner.CornerRadius = UDim.new(1, 0)
            sliderFillCorner.Parent = sliderFill
            
            local sliderHandle = Instance.new("Frame")
            sliderHandle.Name = "Handle"
            sliderHandle.Size = UDim2.new(0, 16, 0, 16)
            sliderHandle.Position = UDim2.new((default - min)/(max - min), -8, 0.5, -8)
            sliderHandle.BackgroundColor3 = THEME.TEXT
            sliderHandle.Parent = sliderBg
            
            storeOriginalProperties(sliderHandle)
            
            local sliderHandleCorner = Instance.new("UICorner")
            sliderHandleCorner.CornerRadius = UDim.new(1, 0)
            sliderHandleCorner.Parent = sliderHandle
            
            local sliding = false
            
            local function updateSlider(input)
                local percentage = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percentage)
                
                TweenService:Create(sliderFill, ANIMS.FADE, {
                    Size = UDim2.new(percentage, 0, 1, 0)
                }):Play()
                
                TweenService:Create(sliderHandle, ANIMS.FADE, {
                    Position = UDim2.new(percentage, -8, 0.5, -8)
                }):Play()
                
                sliderValue.Text = tostring(value)
                callback(value)
            end
            
            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    updateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or
                              input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)
            
            return sliderFrame
        end
        
        function tab:CreateLabel(text)
            local labelFrame = Instance.new("Frame")
            labelFrame.Name = text .. "Label"
            labelFrame.Size = UDim2.new(1, 0, 0, 35)
            labelFrame.BackgroundColor3 = THEME.SECONDARY
            labelFrame.Parent = tabContent
            
            storeOriginalProperties(labelFrame)
            
            local labelCorner = Instance.new("UICorner")
            labelCorner.CornerRadius = UDim.new(0, 6)
            labelCorner.Parent = labelFrame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -50, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = THEME.TEXT
            label.TextSize = 14
            label.Font = Enum.Font.Gotham
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = labelFrame
            
            storeOriginalProperties(label)
            
            local infoIcon = Instance.new("TextLabel")
            infoIcon.Size = UDim2.new(0, 35, 1, 0)
            infoIcon.Position = UDim2.new(1, -35, 0, 0)
            infoIcon.BackgroundTransparency = 1
            infoIcon.Text = "ⓘ"
            infoIcon.TextColor3 = THEME.TEXT
            infoIcon.TextSize = 18  -- Increased text size
            infoIcon.Font = Enum.Font.Gotham
            infoIcon.TextXAlignment = Enum.TextXAlignment.Right
            infoIcon.Parent = labelFrame
            
            storeOriginalProperties(infoIcon)
            
            return labelFrame
        end
       
        function tab:CreateSection(text)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = text .. "Section"
            sectionFrame.Size = UDim2.new(1, 0, 0, 30)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.Parent = tabContent
            
            local leftLine = Instance.new("Frame")
            leftLine.Name = "LeftLine"
            leftLine.Size = UDim2.new(0.3, -10, 0, 2)
            leftLine.Position = UDim2.new(0, 0, 0.5, -1)
            leftLine.BackgroundColor3 = THEME.ACCENT
            leftLine.BorderSizePixel = 0
            leftLine.Parent = sectionFrame
            
            storeOriginalProperties(leftLine)
            
            local rightLine = Instance.new("Frame")
            rightLine.Name = "RightLine"
            rightLine.Size = UDim2.new(0.3, -10, 0, 2)
            rightLine.Position = UDim2.new(0.7, 10, 0.5, -1)
            rightLine.BackgroundColor3 = THEME.ACCENT
            rightLine.BorderSizePixel = 0
            rightLine.Parent = sectionFrame
            
            storeOriginalProperties(rightLine)
            
            local sectionText = Instance.new("TextLabel")
            sectionText.Size = UDim2.new(0.4, 0, 1, 0)
            sectionText.Position = UDim2.new(0.3, 0, 0, 0)
            sectionText.BackgroundTransparency = 1
            sectionText.Text = text
            sectionText.TextColor3 = THEME.ACCENT
            sectionText.TextSize = 14
            sectionText.Font = Enum.Font.GothamBold
            sectionText.Parent = sectionFrame
            
            storeOriginalProperties(sectionText)
            
            return sectionFrame
        end
        
function tab:CreateDropdown(text, options, default, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = text .. "Dropdown"
    dropdownFrame.Size = UDim2.new(1, 0, 0, 35) -- Initial collapsed size
    dropdownFrame.BackgroundColor3 = THEME.SECONDARY
    dropdownFrame.ClipsDescendants = true -- Important for smooth animation
    dropdownFrame.Parent = tabContent
    
    storeOriginalProperties(dropdownFrame)
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 6)
    dropdownCorner.Parent = dropdownFrame
    
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 35)
    headerFrame.BackgroundTransparency = 1
    headerFrame.Parent = dropdownFrame
    
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Size = UDim2.new(1, -40, 1, 0)
    dropdownLabel.Position = UDim2.new(0, 10, 0, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Text = text
    dropdownLabel.TextColor3 = THEME.TEXT
    dropdownLabel.TextSize = 14
    dropdownLabel.Font = Enum.Font.Gotham
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.Parent = headerFrame
    
    storeOriginalProperties(dropdownLabel)
    
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Size = UDim2.new(0.5, -10, 1, 0)
    selectedLabel.Position = UDim2.new(0.5, 0, 0, 0)
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.Text = default or "Select..."
    selectedLabel.TextColor3 = THEME.ACCENT
    selectedLabel.TextSize = 14
    selectedLabel.Font = Enum.Font.Gotham
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Right
    selectedLabel.Parent = headerFrame
    
    storeOriginalProperties(selectedLabel)
    
    local toggleArrow = Instance.new("TextButton")
    toggleArrow.Size = UDim2.new(0, 35, 0, 35)
    toggleArrow.Position = UDim2.new(1, -35, 0, 0)
    toggleArrow.BackgroundTransparency = 1
    toggleArrow.Text = "▼"
    toggleArrow.TextColor3 = THEME.TEXT
    toggleArrow.TextSize = 14
    toggleArrow.Font = Enum.Font.GothamBold
    toggleArrow.Parent = headerFrame
    
    storeOriginalProperties(toggleArrow)
    
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Name = "Options"
    optionsFrame.Size = UDim2.new(1, -20, 0, (#options * 30))
    optionsFrame.Position = UDim2.new(0, 10, 0, 40)
    optionsFrame.BackgroundTransparency = 1
    optionsFrame.Parent = dropdownFrame
    
    local optionsList = Instance.new("UIListLayout")
    optionsList.SortOrder = Enum.SortOrder.LayoutOrder
    optionsList.Padding = UDim.new(0, 5)
    optionsList.Parent = optionsFrame
    
    local isOpen = false
    local selected = default
    
    local function updateDropdown()
        local targetSize = isOpen and UDim2.new(1, 0, 0, 45 + (#options * 30)) or UDim2.new(1, 0, 0, 35)
        local targetRotation = isOpen and 180 or 0
        
        TweenService:Create(dropdownFrame, ANIMS.SLIDE, {
            Size = targetSize
        }):Play()
        
        TweenService:Create(toggleArrow, ANIMS.SLIDE, {
            Rotation = targetRotation
        }):Play()
    end
    
    -- Create option buttons
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option .. "Option"
        optionButton.Size = UDim2.new(1, 0, 0, 25)
        optionButton.BackgroundColor3 = THEME.ACCENT
        optionButton.BackgroundTransparency = 0.8
        optionButton.Text = option
        optionButton.TextColor3 = THEME.TEXT
        optionButton.TextSize = 14
        optionButton.Font = Enum.Font.Gotham
        optionButton.Parent = optionsFrame
        
        storeOriginalProperties(optionButton)
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 4)
        optionCorner.Parent = optionButton
        
        -- Option hover effect
        optionButton.MouseEnter:Connect(function()
            TweenService:Create(optionButton, ANIMS.FADE, {
                BackgroundTransparency = 0.6,
                BackgroundColor3 = THEME.HOVER
            }):Play()
        end)
        
        optionButton.MouseLeave:Connect(function()
            TweenService:Create(optionButton, ANIMS.FADE, {
                BackgroundTransparency = 0.8,
                BackgroundColor3 = THEME.ACCENT
            }):Play()
        end)
        
        -- Option selection
        optionButton.MouseButton1Click:Connect(function()
            selected = option
            selectedLabel.Text = selected
            isOpen = false
            updateDropdown()
            if callback then
                callback(selected)
            end
        end)
    end
    
    -- Toggle dropdown
    toggleArrow.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        updateDropdown()
    end)
    
    headerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            isOpen = not isOpen
            updateDropdown()
        end
    end)
    
    -- Close dropdown when clicking outside
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            local position = input.Position
            local inBounds = position.X >= dropdownFrame.AbsolutePosition.X and
                           position.X <= dropdownFrame.AbsolutePosition.X + dropdownFrame.AbsoluteSize.X and
                           position.Y >= dropdownFrame.AbsolutePosition.Y and
                           position.Y <= dropdownFrame.AbsolutePosition.Y + dropdownFrame.AbsoluteSize.Y
            
            if not inBounds and isOpen then
                isOpen = false
                updateDropdown()
            end
        end
    end)
    
    -- API
    local dropdownAPI = {
        Frame = dropdownFrame,
        SetOptions = function(newOptions)
            -- Clear existing options
            for _, child in pairs(optionsFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            options = newOptions
            
            -- Update frame sizes
            optionsFrame.Size = UDim2.new(1, -20, 0, (#options * 30))
            if isOpen then
                dropdownFrame.Size = UDim2.new(1, 0, 0, 45 + (#options * 30))
            end
            
            -- Recreate options
            for i, option in ipairs(options) do
                -- (Copy the option button creation code from above)
                local optionButton = Instance.new("TextButton")
                optionButton.Name = option .. "Option"
                optionButton.Size = UDim2.new(1, 0, 0, 25)
                optionButton.BackgroundColor3 = THEME.ACCENT
                optionButton.BackgroundTransparency = 0.8
                optionButton.Text = option
                optionButton.TextColor3 = THEME.TEXT
                optionButton.TextSize = 14
                optionButton.Font = Enum.Font.Gotham
                optionButton.Parent = optionsFrame
                
                -- (Continue with the rest of the option button setup)
                local optionCorner = Instance.new("UICorner")
                optionCorner.CornerRadius = UDim.new(0, 4)
                optionCorner.Parent = optionButton
                
                optionButton.MouseEnter:Connect(function()
                    TweenService:Create(optionButton, ANIMS.FADE, {
                        BackgroundTransparency = 0.6,
                        BackgroundColor3 = THEME.HOVER
                    }):Play()
                end)
                
                optionButton.MouseLeave:Connect(function()
                    TweenService:Create(optionButton, ANIMS.FADE, {
                        BackgroundTransparency = 0.8,
                        BackgroundColor3 = THEME.ACCENT
                    }):Play()
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    selected = option
                    selectedLabel.Text = selected
                    isOpen = false
                    updateDropdown()
                    if callback then
                        callback(selected)
                    end
                end)
            end
        end,
        GetSelected = function()
            return selected
        end,
        SetSelected = function(option)
            if table.find(options, option) then
                selected = option
                selectedLabel.Text = selected
                if callback then
                    callback(selected)
                end
            end
        end
    }
    
    return dropdownAPI
        end
        
        tabButton.MouseButton1Click:Connect(function()
            tab:Select()
        end)
        
        if #tabs == 0 then
            task.spawn(function()
                wait() -- Wait for next frame
                tab:Select()
            end)
        end
        
        table.insert(tabs, tab)
        return tab
    end
    
    local sidebarOpen = true
    sidebarToggle.MouseButton1Click:Connect(function()
        sidebarOpen = not sidebarOpen
        
        TweenService:Create(sidebar, ANIMS.SLIDE, {
            Size = sidebarOpen and UDim2.new(0, 150, 1, 0) or UDim2.new(0, 0, 1, 0),
            Position = sidebarOpen and UDim2.new(0, 0, 0, 0) or UDim2.new(-1, 0, 0, 0)
        }):Play()
        
        TweenService:Create(tabContainer, ANIMS.SLIDE, {
            Size = sidebarOpen and UDim2.new(1, -150, 1, 0) or UDim2.new(1, 0, 1, 0),
            Position = sidebarOpen and UDim2.new(0, 150, 0, 0) or UDim2.new(0, 0, 0, 0)
        }):Play()
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        local connections = {}
        
        for _, element in ipairs(main:GetDescendants()) do
            if element:IsA("Frame") or element:IsA("TextButton") or element:IsA("TextLabel") or element:IsA("ScrollingFrame") then
                fadeInstance(element, true)
            end
        end
        
        for _, connection in ipairs(connections) do
            connection:Disconnect()
        end
        
        task.wait(ANIMS.DURATION)
        main.Visible = false
        minimizeButton.Visible = true
        
        for _, element in ipairs(main:GetDescendants()) do
            restoreOriginalProperties(element)
        end
    end)
    
    local minDragging = false
    local minDragStart, minStartPos
    
    minimizeButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            minDragging = true
            minDragStart = input.Position
            minStartPos = minimizeButton.Position
        end
    end)
    
    minimizeButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            minDragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if minDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or
                           input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - minDragStart
            minimizeButton.Position = UDim2.new(
                minStartPos.X.Scale,
                minStartPos.X.Offset + delta.X,
                minStartPos.Y.Scale,
                minStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    minimizeButton.MouseButton1Click:Connect(function()
        minimizeButton.Visible = false
        main.Visible = true
        
        for _, element in ipairs(main:GetDescendants()) do
            if element:IsA("Frame") or element:IsA("TextButton") or element:IsA("TextLabel") or element:IsA("ScrollingFrame") then
                fadeInstance(element, false)
            end
        end
    end)
    
    if syn and syn.protect_gui then
        syn.protect_gui(gui)
        gui.Parent = game:GetService("CoreGui")
    elseif gethui then
        gui.Parent = gethui()
    else
        gui.Parent = game:GetService("CoreGui")
    end
    
    return library
end

return VortexUI
