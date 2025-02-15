# Vortex UI Library Documentation

# Features
• Built for mobile / Mobile Friendly

• Built in draggable button to make ui reappear upon 
tap when ui is hidden

• Smooth Animations with a purple theme to the ui

# Update Log
2/15/25: initial test

next update: keybind to hide ui for pc users
custom themes
dropdowns (maybe)

# Getting Loadstring
```
local VortexUI = loadstring(game:HttpGet("https://pastebin.com/raw/59cpHaFC"))()
```

# Creating a Window
```
local Window = VortexUI.new("Window Title")
```

# Creating Tabs
```
local Tab = Window:CreateTab("TabName")
```

# Creating Sections
```
local Section = Tab:CreateSection("SectionName")
```

# Creating Buttons
```
MainTab:CreateButton("Button Text", function()
    print("Button Clicked")
end)
```

# Creating Toggles
```
Tab:CreateToggle("Toggle Text", false, function(state)
    print("Toggle:", state)
end)
```

# Creating Sliders
```
Tab:CreateSlider("Slider Text", min, max, default, function(value)
    print("Slider Value:", value)
end)
```

# Creating Labels
```
Tab:CreateLabel("This is a label")
```

# Full Example Usage
```
local VortexUI = loadstring(game:HttpGet("https://pastebin.com/raw/59cpHaFC"))()
local Window = VortexUI.new("Example Usage")

local Tab = Window:CreateTab("Tab 1")
local Section = Tab:CreateSection("Section 1")

Tab:CreateLabel("This is a label")

Tab:CreateButton("Button", function()
    print("Button Clicked")
end)

local Tab2 = Window:CreateTab("Tab 2")
local Section = Tab2:CreateSection("Section 2")

Tab2:CreateToggle("Toggle", false, function(state)
    print("Toggle:", state)
end)

Tab2:CreateSlider("Slider", 0, 100, 0, function(value)
    print("Slider Value:", value)
end)
```

# Support
For support, Contact vort.5 on discord

# Credits
Made by vort.5 on discord



