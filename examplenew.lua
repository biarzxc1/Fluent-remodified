--[[
    examplenew.lua
    -----------------------------------------------------------------
    Demo script showcasing the modified Fluent UI library.
    Loads the library, builds a window styled to match the
    "Asus Hub | Game | Delta" screenshot reference, and creates
    every kind of element so you can visually verify the changes:

        - Dark acrylic window with rounded corners
        - White vertical pill selector on the active tab
        - Tabs rendered as "icon | Label" (Visuals, Combat,
          Players, Collect, Settings)
        - Bold large section header ("Settings", "Collect", ...)
        - Tall rounded dark element cards with bigger text
        - Toggles, sliders, dropdowns, paragraphs, keybinds, inputs

    Drop this in a LocalScript (or run it from your executor) after
    the Fluent source has been published as a ModuleScript / loadstring.
    -----------------------------------------------------------------
]]

-- 1. Load the library --------------------------------------------------------
-- If you are running this locally inside Studio, replace the loadstring line
-- with:  local Fluent = require(path.to.Fluent)
local Fluent      = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- 2. Create the main window --------------------------------------------------
-- Title + SubTitle render as bold "Asus Hub" followed by the muted
-- " | Game | Delta" portion, exactly like in the reference screenshot.
local Window = Fluent:CreateWindow({
    Title          = "Asus Hub",
    SubTitle       = " | Game | Delta",
    TabWidth       = 160,
    Size           = UDim2.fromOffset(580, 460),
    Acrylic        = true,    -- frosted dark background
    Theme          = "Dark",  -- uses the new near-black palette + white accent
    MinimizeKey    = Enum.KeyCode.LeftControl,
})

-- 3. Tabs --------------------------------------------------------------------
-- Each tab title is auto-prefixed with "| " by the modified Tab component
-- so you only need to pass the plain name here.
local Tabs = {
    Visuals  = Window:AddTab({ Title = "Visuals",  Icon = "eye"      }),
    Combat   = Window:AddTab({ Title = "Combat",   Icon = "swords"   }),
    Players  = Window:AddTab({ Title = "Players",  Icon = "users"    }),
    Collect  = Window:AddTab({ Title = "Collect",  Icon = "shopping-basket" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

-- 4. Visuals tab -------------------------------------------------------------
Tabs.Visuals:AddParagraph({
    Title   = "ESP",
    Content = "Toggle visual helpers like player ESP, item ESP and chams.",
})

Tabs.Visuals:AddToggle("PlayerESP", {
    Title   = "Player ESP",
    Default = false,
})

Tabs.Visuals:AddToggle("ItemESP", {
    Title   = "Item ESP",
    Default = true,
})

Tabs.Visuals:AddSlider("ESPDistance", {
    Title   = "ESP Distance",
    Default = 250,
    Min     = 0,
    Max     = 1000,
    Rounding = 0,
    Callback = function(_) end,
})

-- 5. Combat tab --------------------------------------------------------------
Tabs.Combat:AddToggle("AutoFarm", {
    Title       = "Auto Farm",
    Description = "Automatically attack the closest enemy",
    Default     = false,
})

Tabs.Combat:AddSlider("HitRange", {
    Title   = "Hit Range",
    Default = 12,
    Min     = 1,
    Max     = 50,
    Rounding = 0,
})

Tabs.Combat:AddKeybind("Panic", {
    Title   = "Panic Key",
    Default = "F",
    Mode    = "Toggle",
})

-- 6. Players tab -------------------------------------------------------------
Tabs.Players:AddDropdown("PlayerList", {
    Title   = "Select Player",
    Values  = { "Player1", "Player2", "Player3" },
    Multi   = false,
    Default = 1,
})

Tabs.Players:AddButton({
    Title       = "Teleport to Player",
    Description = "Move next to the currently selected player",
    Callback    = function() print("Teleport!") end,
})

-- 7. Collect tab (mirrors screenshot 4) --------------------------------------
Tabs.Collect:AddDropdown("ItemFilter", {
    Title       = "All = collect every item on",
    Values      = { "Wood", "Iron", "Gold", "Diamond" },
    Multi       = true,
    Default     = {},
})

Tabs.Collect:AddToggle("AutoCollect", {
    Title       = "Auto Collect Itens",
    Description = "Select some itens or collect all",
    Default     = false,
})

Tabs.Collect:AddToggle("AuraCollect", {
    Title       = "Collect aura Itens",
    Description = "Collect only itens with aura",
    Default     = false,
})

Tabs.Collect:AddSlider("AuraRadius", {
    Title       = "Aura radius",
    Description = "distance aura itens",
    Default     = 10,
    Min         = 1,
    Max         = 50,
    Rounding    = 0,
})

-- 8. Settings tab (mirrors screenshots 1-3) ----------------------------------
Tabs.Settings:AddDropdown("Theme", {
    Title   = "Theme",
    Values  = { "Dark", "Darker", "Light", "Aqua", "Amethyst", "Rose" },
    Default = "Dark",
    Callback = function(value)
        Fluent:Dictate(Fluent.Themes[value] or Fluent.Themes.Dark)
    end,
})

Tabs.Settings:AddSlider("Sharpness", {
    Title   = "Sharpness",
    Default = 0,
    Min     = 0,
    Max     = 10,
    Rounding = 0,
})

Tabs.Settings:AddParagraph({
    Title   = "Owner & Developer",
    Content = "hid1ey",
})

Tabs.Settings:AddDropdown("Social", {
    Title   = "Social Media - @hid1ey",
    Values  = { "Instagram: @hid1ey", "Discord: @hid1ey" },
    Multi   = false,
    Default = 1,
})

-- 9. Init add-ons ------------------------------------------------------------
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

InterfaceManager:SetFolder("AsusHub")
SaveManager:SetFolder("AsusHub/Game-Delta")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

-- 10. Show the window -------------------------------------------------------
Window:SelectTab(5) -- open on "Settings" so you immediately see the new style
Fluent:Notify({
    Title    = "Asus Hub loaded",
    Content  = "UI restyled to match the new Asus Hub | Game | Delta design.",
    Duration = 5,
})
