local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Code Phantom", "Midnight")

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
    end,
})

---------------------------------------
-- MORE TAB
---------------------------------------
local MoreTab = Window:CreateTab("More")

MoreTab:CreateButton({
    Name = "Auto Collect",
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
    end,
})

---------------------------------------
-- EGG PREDICTOR TAB
---------------------------------------
local EggPredTab = Window:CreateTab("Egg Predictor")

EggPredTab:CreateButton({
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
                if egg:GetAttribute("OBJECT_UUID") ~= uuid then continue end
                return egg
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
            txt.Color = Color3.new(1, 1, 1)
            txt.Outline = true
            txt.OutlineColor = Color3.new(0, 0, 0)
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

        local original
        original = hookfunction(getconnections(rs.GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function, newcclosure(function(uuid, pet)
            refreshLabel(uuid, pet)
            return original(uuid, pet)
        end))

        rsRun.PreRender:Connect(updateLabels)
    end,
})

---------------------------------------
-- EGG SPAWNER TAB
---------------------------------------
local EggSpawnerTab = Window:CreateTab("Egg Spawner")
local eggName = ""

EggSpawnerTab:CreateTextBox({
    Name = "Egg Name",
    TextDisappear = false,
    PlaceholderText = "Enter egg name (case sensitive)",
    Callback = function(text)
        eggName = text
    end,
})

EggSpawnerTab:CreateButton({
    Name = "Spawn Egg",
    Callback = function()
        if eggName == "" then
            warn("Code Phantom: No egg name entered!")
            return
        end

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local EggModels = ReplicatedStorage:FindFirstChild("EggModels")

        if not EggModels then
            warn("Code Phantom: EggModels folder not found in ReplicatedStorage!")
            return
        end

        local eggTemplate = EggModels:FindFirstChild(eggName)
        if not eggTemplate then
            warn(`Code Phantom: Egg '{eggName}' not found in EggModels!`)
            return
        end

        local clonedEgg = eggTemplate:Clone()
        clonedEgg.Parent = workspace
        clonedEgg:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
        print(`Code Phantom: Spawned egg '{eggName}'`)
    end,
})

---------------------------------------
-- PET SPAWNER TAB
---------------------------------------
local PetSpawnerTab = Window:CreateTab("Pet Spawner")
local petName = ""

PetSpawnerTab:CreateTextBox({
    Name = "Pet Name",
    TextDisappear = false,
    PlaceholderText = "Enter pet name (case sensitive)",
    Callback = function(text)
        petName = text
    end,
})

PetSpawnerTab:CreateButton({
    Name = "Spawn Pet",
    Callback = function()
        if petName == "" then
            warn("Code Phantom: No pet name entered!")
            return
        end

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local PetAssets = ReplicatedStorage:FindFirstChild("PetAssets")

        if not PetAssets then
            warn("Code Phantom: PetAssets folder not found in ReplicatedStorage!")
            return
        end

        local petTemplate = PetAssets:FindFirstChild(petName)
        if not petTemplate then
            warn(`Code Phantom: Pet '{petName}' not found in PetAssets!`)
            return
        end

        local clonedPet = petTemplate:Clone()
        clonedPet.Parent = workspace
        clonedPet:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0))
        print(`Code Phantom: Spawned pet '{petName}'`)
    end,
})

