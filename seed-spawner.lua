local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "GROW A GARDEN SEED spawner", 
    Icon = 0,
    LoadingTitle = "SEED SPAWNER", 
    LoadingSubtitle = "by code phantom ", 
    Theme = "Amethyst",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false, 
    ConfigurationSaving = {
       Enabled = false,
       FolderName = nil,
       FileName = ""
    },
    Discord = {
       Enabled = false,
       Invite = "",
       RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
       Title = "",
       Subtitle = "",
       Note = "", 
       FileName = "Key",
       SaveKey = true, 
       GrabKeyFromSite = false,
       Key = {""}
    }
 })
 local Tab = Window:CreateTab("Spawn", 4483362458)
 local seed
 local Input = Tab:CreateInput({
    Name = "Seed",
    CurrentValue = "",
    PlaceholderText = "",
    RemoveTextAfterFocusLost = false,
    Flag = "Input1",
    Callback = function(Text)
        seed = Text
    end,
 })
seeds = {
    ["Carrot"] = 0,
    ["Tomato"] = 0,
    ["Strawberry"] = 0,
    ["Blueberry"] = 0,
    ["Corn"] = 0,
    ["Pumpkin"] = 0,
    ["Watermelon"] = 0,
    ["Apple"] = 0,
    ["Coconut"] = 0,
    ["Dragon Fruit"] = 0,
    ["Super"] = 0,
    ["Bamboo"] = 0,
    ["Raspberry"] = 0,
    ["Pineapple"] = 0,
    ["Peach"] = 0,
    ["Cactus"] = 0,
    ["Grape"] = 0,
    ["Pear"] = 0,
    ["Eggplant"] = 0,
    ["Purple Cabbage"] = 0,
    ["Lemon"] = 0,
    ["Chocolate Carrot"] = 0,
    ["Easter Egg"] = 0,
    ["Orange Tulip"] = 0,
    ["Pink Tulip"] = 0,
    ["Crocus"] = 0,
    ["Daffodil"] = 0,
    ["Cherry Blossom"] = 0,
    ["Red Lollipop"] = 0,
    ["Blue Lollipop"] = 0,
    ["Candy Sunflower"] = 0,
    ["Banana"] = 0,
    ["Passionfruit"] = 0,
    ["Cursed Fruit"] = 0,
    ["Lotus"] = 0,
    ["Papaya"] = 0,
    ["Soul Fruit"] = 0,
    ["Mega Mushroom"] = 0,
    ["Mango"] = 0,
    ["Venus Fly Trap"] = 0,
    ["Cranberry"] = 0,
    ["Durian"] = 0,
    ["Succulent"] = 0,
    ["Candy Blossom"] = 0,
    ["Mushroom"] = 0,
    ["Nightshade"] = 0,
    ["Avocado"] = 0,
    ["Pepper"] = 0,
    ["Moon Blossom"] = 0,
    ["Moonglow"] = 0,
    ["Starfruit"] = 0,
    ["Moonflower"] = 0,
    ["Mint"] = 0,
    ["Glowshroom"] = 0,
    ["Cacao"] = 0,
    ["Beanstalk"] = 0,
    ["Crimson Vine"] = 0,
    ["Moon Melon"] = 0,
    ["Blood Banana"] = 0,
    ["Moon Mango"] = 0,
    ["Celestiberry"] = 0,
    ["Purple Dahlia"] = 0,
    ["Hive Fruit"] = 0,
    ["Ember Lily"] = 0,
    ["Foxglove"] = 0,
    ["Rose"] = 0,
    ["Sunflower"] = 0,
    ["Lilac"] = 0
}
local a
local b
 local Button = Tab:CreateButton({
    Name = "Spawn seed",
    Callback = function()
        for i,v in pairs(game:GetService("ReplicatedStorage").Seed_Models:GetChildren()) do
            if seeds[seed] == 1 or seeds[seed] >= 1 then
                a.Name = seed.." Seed [X"..seeds[seed].."]"
                seeds[seed] += 1 
                return
            end
            if seed == tostring(v) then 
                seeds[seed] += 1 
                a = Instance.new("Tool")
                a.Parent = game.Players.LocalPlayer.Backpack
                a.Name = seed.." Seed [X"..seeds[seed].."]"
                a.GripPos = Vector3.new(0.20000000298023224, -0.4487171173095703, 0.23155708611011505)
                b = v:Clone()
                b.Name = "Handle"
                b.Parent = a
            end
        end
    end,
 })
