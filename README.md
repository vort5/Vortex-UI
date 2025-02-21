# Vortex UI Library Documentation

# Features
• Built for mobile / Mobile Friendly

• Built in draggable button to make ui reappear upon 
tap when ui is hidden

• Smooth Animations with a purple theme to the ui

# Update Log
2/15/21: initial test

next update: 

actual release

custom themes

more pc support like keybinds and stuff

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

# Creating Dropdowns
```
Tab:CreateDropdown("Dropdown Name", {
    "Option 1",
    "Option 2",
    "Option 3",
    "Option 4"
}, "Option 1", function(selected)
    print("Selected Option:", selected)
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

Tab2:CreateDropdown("Select", {
    "Apple",
    "Banana",
    "Pineapple",
    "Mango"
}, "Apple", function(selected)
    print("Selected:", selected)
end)
```

# Support
For support, Contact vort.5 on discord

# Credits
Made by vort.5 on discord



