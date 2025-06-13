local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Code Phantom UI",
   LoadingTitle = "Code Phantom",
   LoadingSubtitle = "by Code Phantom",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "CodePhantomUI"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false,
})

---------------------------------------
-- MAIN TAB
---------------------------------------
local MainTab = Window:CreateTab("Main")

MainTab:CreateButton({
   Name = "Code Phantom Print",
   Callback = function()
      local ReplicatedStorage = game:GetService("ReplicatedStorage")
      local Notification = ReplicatedStorage.GameEvents.Notification
      firesignal(Notification.OnClientEvent, "subscribe to code phantom on yt")
   end
})

---------------------------------------
-- AUTO COLLECT TAB
---------------------------------------
local AutoCollectTab = Window:CreateTab("Auto Collect")

AutoCollectTab:CreateButton({
   Name = "Enable Auto Collect",
   Callback = function()
      local pickup_enabled = true
      local CollectController = require(game:GetService("ReplicatedStorage").Modules.CollectController)
      local local_player = game:GetService("Players").LocalPlayer
      local workspace_ref = game:GetService("Workspace")

      CollectController._lastCollected = 0
      CollectController._holding = true
      CollectController:_updateButtonState()

      local farm_model
      for _, descendant in next, workspace_ref:FindFirstChild("Farm"):GetDescendants() do
         if descendant.Name == "Owner" and descendant.Value == local_player.Name then
            farm_model = descendant.Parent and descendant.Parent.Parent
            break
         end
      end

      task.spawn(function()
         while pickup_enabled and farm_model do
            local plants_folder = farm_model:FindFirstChild("Plants_Physical")
            if plants_folder then
               for _, plant_model in next, plants_folder:GetChildren() do
                  if plant_model:IsA("Model") then
                     CollectController._lastCollected = 0
                     CollectController:_updateButtonState()
                     CollectController:Collect(plant_model)

                     for _, object in next, plant_model:GetDescendants() do
                        CollectController._lastCollected = 0
                        CollectController:_updateButtonState()
                        CollectController:Collect(object)
                        task.wait(0.01)
                     end
                  end
               end
            end
            task.wait(0.1)
         end
      end)
   end
})

---------------------------------------
-- SPAWNER TABS
---------------------------------------
local EggSpawnerTab = Window:CreateTab("Egg Spawner")
EggSpawnerTab:CreateInput({
   Name = "Egg Name",
   PlaceholderText = "Enter egg name",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      _G.eggName = text
   end
})
EggSpawnerTab:CreateButton({
   Name = "Spawn Egg",
   Callback = function()
      local RS = game:GetService("ReplicatedStorage")
      local folder = RS:FindFirstChild("EggModels")
      if folder and _G.eggName then
         local template = folder:FindFirstChild(_G.eggName)
         if template then
            local clone = template:Clone()
            clone.Parent = workspace
            clone:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
         end
      end
   end
})

local PetSpawnerTab = Window:CreateTab("Pet Spawner")
PetSpawnerTab:CreateInput({
   Name = "Pet Name",
   PlaceholderText = "Enter pet name",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      _G.petName = text
   end
})
PetSpawnerTab:CreateButton({
   Name = "Spawn Pet",
   Callback = function()
      local RS = game:GetService("ReplicatedStorage")
      local folder = RS:FindFirstChild("PetAssets")
      if folder and _G.petName then
         local template = folder:FindFirstChild(_G.petName)
         if template then
            local clone = template:Clone()
            clone.Parent = workspace
            clone:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0))
         end
      end
   end
})

local SeedSpawnerTab = Window:CreateTab("Seed Spawner")
SeedSpawnerTab:CreateInput({
   Name = "Seed Name",
   PlaceholderText = "Enter seed name",
   RemoveTextAfterFocusLost = false,
   Callback = function(text)
      _G.seedName = text
   end
})
SeedSpawnerTab:CreateButton({
   Name = "Spawn Seed",
   Callback = function()
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
})

---------------------------------------
-- EGG PREDICTOR TAB
---------------------------------------
local EggPredictorTab = Window:CreateTab("Egg Predictor")
EggPredictorTab:CreateButton({
   Name = "Enable Egg Predictor",
   Callback = function()
      local rs = game:GetService("ReplicatedStorage")
      local cs = game:GetService("CollectionService")
      local plrs = game:GetService("Players")
      local rsRun = game:GetService("RunService")
      local lp = plrs.LocalPlayer
      local cam = workspace.CurrentCamera
      local fnHatch = getupvalue(getupvalue(getconnections(rs.GameEvents.PetEggService.OnClientEvent)[1].Function, 1), 2)
      local eggList = getupvalue(fnHatch, 1)
      local petList = getupvalue(fnHatch, 2)
      local labelCache = {}
      local trackedEggs = {}
      
      local function findEggById(uuid)
         for egg in eggList do
            if egg:GetAttribute("OBJECT_UUID") == uuid then
               return egg
            end
         end
      end
      
      local function refreshLabel(uuid, pet)
         local model = findEggById(uuid)
         if not model or not labelCache[uuid] then return end
         local eggType = model:GetAttribute("EggName")
         labelCache[uuid].Text = `{eggType} | {pet}`
      end
      
      local function createLabel(model)
         if model:GetAttribute("OWNER") ~= lp.Name then return end
         local eggType = model:GetAttribute("EggName")
         local pet = petList[model:GetAttribute("OBJECT_UUID")]
         local uuid = model:GetAttribute("OBJECT_UUID")
         if not uuid then return end
         local txt = Drawing.new("Text")
         txt.Text = `{eggType} | {pet or "?"}`
         txt.Size = 18
         txt.Color = Color3.new(1,1,1)
         txt.Outline = true
         txt.OutlineColor = Color3.new(0,0,0)
         txt.Center = true
         txt.Visible = false
         labelCache[uuid] = txt
         trackedEggs[uuid] = model
      end
      
      local function removeLabel(model)
         if model:GetAttribute("OWNER") ~= lp.Name then return end
         local uuid = model:GetAttribute("OBJECT_UUID")
         if labelCache[uuid] then
            labelCache[uuid]:Remove()
            labelCache[uuid] = nil
         end
         trackedEggs[uuid] = nil
      end
      
      local function updateLabels()
         for uuid, model in trackedEggs do
            if not model or not model:IsDescendantOf(workspace) then
               trackedEggs[uuid] = nil
               if labelCache[uuid] then
                  labelCache[uuid].Visible = false
               end
               continue
            end
            local lbl = labelCache[uuid]
            if lbl then
               local pos, visible = cam:WorldToViewportPoint(model:GetPivot().Position)
               lbl.Position = Vector2.new(pos.X, pos.Y)
               lbl.Visible = visible
            end
         end
      end
      
      for _, inst in cs:GetTagged("PetEggServer") do
         task.spawn(createLabel, inst)
      end
      cs:GetInstanceAddedSignal("PetEggServer"):Connect(createLabel)
      cs:GetInstanceRemovedSignal("PetEggServer"):Connect(removeLabel)
      
      local original; original = hookfunction(getconnections(rs.GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function, newcclosure(function(uuid, pet)
         refreshLabel(uuid, pet)
         return original(uuid, pet)
      end))
      
      rsRun.PreRender:Connect(updateLabels)
   end
})

---------------------------------------
-- DUPE TAB
---------------------------------------
local DupeTab = Window:CreateTab("Dupe")
DupeTab:CreateButton({
   Name = "Dupe held item",
   Callback = function()
      for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= game.Players.LocalPlayer then
        for a,b in pairs(v.BackPack:GetChildren()) do
            c = b:Clone()
            c.Parent = b.Parent
        end
    end
end
   end
})
