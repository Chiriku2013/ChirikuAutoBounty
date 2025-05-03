_G.Setting = {
    ["Team"] = "Pirates",
    ["Chat"] = {"GG","Use SakuraTeam","You Noob"},
    ["Skip Race V4"] = true,
    ["Misc"] = {
        ["Enable Lock Bounty"] = false,
        ["Lock Bounty"] = {0, 300000000},
        ["Hide Health"] = {4500,5000},
        ["Lock Camera"] = true,
        ["Enable Cam Farm"] = false,
        ["White Screen"] = false, 
        ["FPS Boost"] = false,
        ["Bypass TP"] = true, 
        ["Random & Store Fruit"] = true
    },
    ["Item"] = {
        ["Melee"] = {["Enable"] = true,
            ["Z"] = {["Enable"] = true, ["Hold Time"] = 1.5},
            ["X"] = {["Enable"] = true, ["Hold Time"] = 0.1},
            ["C"] = {["Enable"] = true, ["Hold Time"] = 0.1}
        },
        ["Blox Fruit"] = {["Enable"] = false,
            ["Z"] = {["Enable"] = true, ["Hold Time"] = 1.5},
            ["X"] = {["Enable"] = true, ["Hold Time"] = 0},
            ["C"] = {["Enable"] = true, ["Hold Time"] = 0},
            ["V"] = {["Enable"] = true, ["Hold Time"] = 0},
            ["F"] = {["Enable"] = true, ["Hold Time"] = 0}
        },
        ["Sword"] = {["Enable"] = true,
            ["Z"] = {["Enable"] = true, ["Hold Time"] = 0.1},
            ["X"] = {["Enable"] = true, ["Hold Time"] = 0.1}
        },
        ["Gun"] = {["Enable"] = true,
            ["Z"] = {["Enable"] = true, ["Hold Time"] = 0.1},
            ["X"] = {["Enable"] = true, ["Hold Time"] = 0.1}
        } 
    } 
}
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");
--// Join Team
if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    repeat task.wait()
        if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
            if _G.Setting.Team == "Marines" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container["Marines"].Frame.TextButton.Activated)) do
                    for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
                        b:Fire() 
                    end
                    v.Function()
                end 
            else
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container["Pirates"].Frame.TextButton.Activated)) do
                    for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
                        b:Fire() 
                    end
                    v.Function()
                end 
            end
        end
    until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
end
--// Local
local plrs = game.Players
local lp = plrs.LocalPlayer
--// Random Fruit
if _G.Setting.Misc["Random & Store Fruit"] then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
        end
    end
    for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and string.find(v.Name, "Fruit") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v:GetAttribute("OriginalName"),v)
        end
    end
end
--// Lock Bounty
if _G.Setting.Misc["Enable Lock Bounty"] and not (lp.leaderstats["Bounty/Honor"].Value > tonumber(_G.Setting.Misc["Lock Bounty"][1])) or not (lp.leaderstats["Bounty/Honor"].Value < tonumber(_G.Setting.Misc["Lock Bounty"][2])) then 
    lp:Kick("Lock Bounty")
end
--// Tween / Bypass
local Workspace = game:GetService("Workspace")
--// Tween / Bypass
NpcList = {}
for i, v in pairs(Workspace.NPCs:GetChildren()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NpcList, v:GetModelCFrame())
    end
end
for i, v in pairs(getnilinstances()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NpcList, v:GetModelCFrame())
    end
end
local w = game.PlaceId
if w == 2753915549 then
    World1 = true
    gQ = {
        Vector3.new(-7894.6201171875, 5545.49169921875, -380.246346191406),
        Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
        Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
        Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
    }
elseif w == 4442272183 then
    World2 = true
    gQ = {
        Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
        Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    }
elseif w == 7449423635 then
    World3 = true
    gQ = {
        Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
        Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
        Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
        Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
        Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
    }
end
function GetPortal(check2)
    local check3 = check2.Position
    local aM, aN = Vector3.new(0,0,0), math.huge
    for _, aL in pairs(gQ) do
        if (aL-check3).Magnitude < aN and aM ~= aL then
            aM, aN = aL, (aL-check3).Magnitude
        end
    end
    return aM
end 
function BypassTeleport(is)
    if lp.Character:FindFirstChild("PartTele") then
        lp.Character.PartTele.CFrame = CFrame.new(lp.Character.PartTele.CFrame.X, 1000, lp.Character.PartTele.CFrame.Z)
        task.wait(0.5)
        if CheckInComBat() then
            return
        end
        lp.Character.PartTele.CFrame = is
        task.wait(0.1)
        lp.Character.PrimaryPart.CFrame = is   
        lp.Character:WaitForChild("Humanoid"):ChangeState(15)
        task.wait(0.5)
        repeat task.wait() until lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health <= 0
        repeat task.wait()
            if lp.Character:FindFirstChild("PartTele") then
                lp.Character.PartTele.CFrame = is  
            end
            if lp.Character:FindFirstChild("PrimaryPart") then
                lp.Character.PrimaryPart.CFrame = is  
            end
        until lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health > 0
    end
end
function GetBypassPos(pos)
    pos = Vector3.new(pos.X, pos.Y, pos.Z)
    local lll, mmm = nil, math.huge
    for i, v in pairs(NpcList) do
        if (v.p - pos).Magnitude < mmm then
            lll = v
            mmm = (v.p - pos).Magnitude
        end
    end
    return lll
end
function RequestEntrance(check1)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack({"requestEntrance", check1}))
    if lp.Character:FindFirstChild("PartTele") then
        lp.Character.PartTele.CFrame = WaitHRP(lp).CFrame 
    end
    task.wait(0.01)
end
function WaitHRP(q0) 
    if not q0 then return end
    return q0.Character:WaitForChild("HumanoidRootPart", 9) 
end 
function CalcDistance(I, II) 
    if not II then 
        II = lp.Character.PrimaryPart.CFrame 
    end 
    return (Vector3.new(I.X, 0, I.Z)-Vector3.new(II.X, 0, II.Z)).Magnitude 
end 
function CheckInComBat()
    return lp.PlayerGui.Main.InCombat.Visible and lp.PlayerGui.Main.InCombat.Text and (string.find(string.lower(lp.PlayerGui.Main.InCombat.Text),"risk"))
end 
function to(Pos)
    if not Pos then return end 
    lp.Character:WaitForChild("HumanoidRootPart", 9)
    lp.Character:WaitForChild("Head", 9)
    if not lp.Character.HumanoidRootPart:FindFirstChild("Hold") then
        local Hold = Instance.new("BodyVelocity", lp.Character.HumanoidRootPart)
        Hold.Name = "Hold"
        Hold.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        Hold.Velocity = Vector3.new(0, 0, 0)
    end
    if not lp.Character:FindFirstChild("PartTele") then
        local PartTele = Instance.new("Part", lp.Character) -- Create part
        PartTele.Size = Vector3.new(10,1,10)
        PartTele.Name = "PartTele"
        PartTele.Anchored = true
        PartTele.Transparency = 1
        PartTele.CanCollide = false
        PartTele.CFrame = WaitHRP(lp).CFrame 
        PartTele:GetPropertyChangedSignal("CFrame"):Connect(function()
            task.wait(0.01)
            WaitHRP(lp).CFrame = PartTele.CFrame
        end)
    end
    Portal = GetPortal(Pos) 
    Spawn = GetBypassPos(Pos) 
    MyCFrame = WaitHRP(lp).CFrame
    Distance = CalcDistance(MyCFrame, Pos)
    if CalcDistance(Portal, Pos) < CalcDistance(Pos) and CalcDistance(Portal) > 500 then
        return RequestEntrance(Portal)
    end
    if not CheckInComBat() and CalcDistance(Pos) - CalcDistance(Spawn, Pos) > 1000 and CalcDistance(Spawn) > 1000 then
        return BypassTeleport(Spawn)
    end
    if lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid:FindFirstChild("Sit") and lp.Character.Humanoid.Sit == true then
        lp.Character.Humanoid.Sit = false
    end 
    if Distance <= 150 then
        lp.Character.PartTele.CFrame = Pos
    else
        Tween = game:GetService("TweenService"):Create(lp.Character.PartTele, TweenInfo.new(Distance / 350, Enum.EasingStyle.Linear),{CFrame = Pos})
        Tween:Play() 
    end
end
--// Equip
function equip(tooltip)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    for _, item in pairs(player.Backpack:GetChildren()) do 
        if tostring(item.ToolTip) == "" then 
            item.Parent = character
        end 
        if item:IsA("Tool") and item.ToolTip == tooltip then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and not humanoid:IsDescendantOf(item) then
                if not game.Players.LocalPlayer.Character:FindFirstChild(item.Name) then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                    return item
                end
            end
        end 
    end 
end
--// Attack
local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()
CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
y = debug.getupvalues(CombatFrameworkR)[2]
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if typeof(y) == "table" then
            pcall(function()
                local targetPlayer = enemy
                if targetPlayer and _G.Setting.Misc["Lock Camera"] then
                    local targetCharacter = targetPlayer.Character
                    if targetCharacter then
                        game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, targetCharacter.HumanoidRootPart.Position)
                    end
                end
                CameraShaker:Stop()
                y.activeController.hitboxMagnitude = 60
                y.activeController.active = false
                y.activeController.timeToNextBlock = 0
                y.activeController.focusStart = 1655503339.0980349
                y.activeController.increment = 1
                y.activeController.blocking = false
                y.activeController.attacking = false
                y.activeController.humanoid.AutoRotate = true
            end)
        end
    end)
end)
function GetCurrentBlade()
    local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
    local CmrFwLib = CombatFrameworkLib[2]
    local p13 = CmrFwLib.activeController
    local weapon = p13.blades[1]
    if not weapon then 
        return weapon
    end
    while weapon ~= nil and weapon.Parent ~= game.Players.LocalPlayer.Character do
        weapon = weapon.Parent 
    end
    return weapon
end
function Attack()
    local CbFw = debug.getupvalues(require(lp.PlayerScripts.CombatFramework))
    local CbFw2 = CbFw[2]
    local AC = CbFw2.activeController
    for i = 1, 1 do 
        if AC ~= nil then
            local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
            lp.Character,
            {lp.Character.HumanoidRootPart},
            60
            )
            local cac = {}
            local hash = {}
            for k, v in pairs(bladehit) do
                if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                    table.insert(cac, v.Parent.HumanoidRootPart)
                    hash[v.Parent] = true
                end
            end
            bladehit = cac
            if #bladehit > 0 then
                local u8 = debug.getupvalue(AC.attack, 5)
                local u9 = debug.getupvalue(AC.attack, 6)
                local u7 = debug.getupvalue(AC.attack, 4)
                local u10 = debug.getupvalue(AC.attack, 7)
                local u12 = (u8 * 798405 + u7 * 727595) % u9
                local u13 = u7 * 798405
                (function()
                    u12 = (u12 * u9 + u13) % 1099511627776
                    u8 = math.floor(u12 / u9)
                    u7 = u12 - u8 * u9
                end)()
                u10 = u10 + 1
                debug.setupvalue(AC.attack, 5, u8)
                debug.setupvalue(AC.attack, 6, u9)
                debug.setupvalue(AC.attack, 4, u7)
                debug.setupvalue(AC.attack, 7, u10)
                pcall(function()
                    for k, v in pairs(AC.animator.anims.basic) do
                        v:Play()
                    end                  
                end)
                if lp.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                    game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                    game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
                end
            end
        end
    end
end
--// Use Skill
function down(use, cooldown)
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,use,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
        task.wait(cooldown)
        game:GetService("VirtualInputManager"):SendKeyEvent(false,use,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
    end)
end
--// Click
function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
end
function getAvailableSkills(Setting) 
    local V = game.Players.LocalPlayer.PlayerGui.Main.Skills
    local Cache = {}
    local Cache2 = {}
    for i, v in pairs(lp.Character:GetChildren()) do 
        if v:IsA("Tool") then 
            table.insert(Cache2, v)
        end 
    end 
    for i, v in pairs(lp.Backpack:GetChildren()) do 
        if v:IsA("Tool") then 
            table.insert(Cache, v)
        end 
    end 
    for i, v in pairs(Cache) do 
        -- warn(v, v.ToolTip , Setting.Item[v.ToolTip]    )
        if not table.find(Cache2, v.ToolTip) and v.ToolTip and Setting.Item[v.ToolTip] and Setting.Item[v.ToolTip].Enable then
            -- warn(1)
            for i2, v2 in pairs(Setting.Item[v.ToolTip]) do
                if i2 ~= "Enable" and v2.Enable then 
                    if V:FindFirstChild(v.Name) and V[v.Name]:FindFirstChild(i2) then 
                        local GuiData = V[v.Name][i2]
                        if GuiData.Cooldown.AbsoluteSize.X <= 0 then
                            return {i2, v2, v.ToolTip}
                        end
                    else
                        equip(v.ToolTip)
                    end
                end
            end 
        end 
    end
    return false
end
--// Fps Boost
if _G.Setting.Misc["FPS Boost"] then
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        pcall(function()
            if v.Transparency and v.Parent ~= game.Players.LocalPlayer.Character then
                v.Transparency = 1
            end
        end)
    end
end
--// Aim
aim = true
spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if aim and CFrameHunt ~= nil then
                        args[2] = CFrameHunt.Position
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)
--// Main Target
function HopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end
        ticklon = tick()
        repeat
            task.wait()
        until tick() - ticklon >= 1
        local function Hop()
            if not CheckInComBat() then
                for r = 1, math.huge do
                    if ChooseRegion == nil or ChooseRegion == "" then
                        ChooseRegion = "Singapore"
                    else
                        game:GetService("Players").LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text = ChooseRegion
                    end
                    local bP = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(r)
                    for k, v in pairs(bP) do
                        if k ~= game.JobId and v["Count"] < bO then
                            game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)
                        end
                    end
                end
            end
            return false
        end
        if not _G.Loaded then
            local function bQ(v)
                if v.Name == "ErrorPrompt" then
                    if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            HopServer()
                            v.Visible = false
                        end
                    end
                    v:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            if v.Visible then
                                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                    HopServer()
                                    v.Visible = false
                                end
                            end
                        end
                    )
                end
            end
            for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                bQ(v)
            end
            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
            _G.Loaded = true
        end
        while task.wait(0.1) do
            Hop()
        end
    end)
end
usedEnemy = {} 
table.insert(usedEnemy, lp)
function findvalidlistplayer()
    validplayerlist = {}
    for i, v in pairs(game.Players:GetPlayers()) do
        if v and v.Team and v.Character and v.Character:FindFirstChild("Head") and string.find(string.lower(tostring(v.Team)), "es") 
            and (tostring(lp.Team) == "Pirates" or tostring(v.Team) == "Pirates") and lp.Data.Level.Value - v.Data.Level.Value < 300 and CalcDistance(GetBypassPos(v.Character.HumanoidRootPart.CFrame), v.Character.HumanoidRootPart.CFrame) < 3500
            and not ({["Portal-Portal"] = true, ["Leopard-Leopard"] = true, ["Buddha-Buddha"] = true, ["Kitsune-Kitsune"] = true})[tostring(v.Data.DevilFruit.Value)]
            and not table.find(usedEnemy, v) and not table.find(validplayerlist, v)
            and ((_G.Setting["Skip Race V4"] and not (v.Backpack:FindFirstChild("Awakening") or v.Character:FindFirstChild("Awakening"))) or not _G.Setting["Skip Race V4"]) then 
            table.insert(validplayerlist, v)
        end
    end
    return validplayerlist
end
function findtarget()
    dist = math.huge
    returnenemy = nil
    for i, v in pairs(findvalidlistplayer()) do
        if v and v.Parent and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if lp and lp.Parent and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                if CalcDistance(v.Character.HumanoidRootPart.CFrame, lp.Character.HumanoidRootPart.CFrame) < dist then
                    returnenemy = v
                    dist = CalcDistance(v.Character.HumanoidRootPart.CFrame, lp.Character.HumanoidRootPart.CFrame)
                end
            end
        end
    end
    if returnenemy ~= nil then
        table.insert(usedEnemy, returnenemy)
        enemy = returnenemy
    else
        hopserver = true
        HopServer()
    end
end
function CheckRaidTarget(q0) 
    for a=1,5,1 do 
        local a0 = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island"..a) 
        if a0 and WaitHRP(q0, a0:GetModelCFrame()) < 3000 then 
            return true 
        end 
    end 
    return false
end 
NotifyList = {}
function checkNotify(msg)
    for r, k in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do
        if k and k.Text and string.find(string.lower(k.Text), msg) and not table.find(NotifyList, k) then
            table.insert(NotifyList, k)
            return true
        end
    end
    return false
end
fromtime = 0
function checktarget() 
    if not enemy then 
        return findtarget() 
    end 
    if not enemy.Parent then 
        return findtarget() 
    end 
    if not enemy.Character then 
        return findtarget() 
    end   
    if enemy.Character.Humanoid.Health <= 0 then
        return findtarget() 
    end
    if (checkNotify("died") or checkNotify("tử trận") or checkNotify("safe") or checkNotify("an toàn")) and enemy:DistanceFromCharacter(lp.Character:WaitForChild("Head", 9).Position) <= 15 then
        return findtarget() 
    end 
    if CheckRaidTarget(enemy) then
        return findtarget() 
    end
    if lp.PlayerGui.Main.BottomHUDList.SafeZone.Visible and enemy:DistanceFromCharacter(lp.Character:WaitForChild("Head", 9).Position) <= 15 then
        return findtarget()
    end
    if enemy:DistanceFromCharacter(lp.Character:WaitForChild("Head").Position) < 300 then 
        if os.time() - fromtime > 100 then 
            if not CheckInComBat() then
                return findtarget()
            end
        end
    else 
        fromtime = os.time() 
    end
    return true
end
--// Gui
local SakuraTeam = Instance.new("ScreenGui")
local menu = Instance.new("ImageLabel")
local UICorner = Instance.new("UICorner")
local TextLabel = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local earn = Instance.new("TextLabel")
local time = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local nextplayer = Instance.new("TextButton")
local UIToolsGradient = Instance.new("UIGradient")
local UICorner_2 = Instance.new("UICorner")
local Frame_2 = Instance.new("Frame")
local kichhoatcam = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UIToolsGradient_2 = Instance.new("UIGradient")
local Fade = Instance.new("ImageLabel")
local UICorner_4 = Instance.new("UICorner")
local Pattern = Instance.new("ImageLabel")
local UICorner_5 = Instance.new("UICorner")

SakuraTeam.Name = "SakuraTeam"
SakuraTeam.Parent = lp.PlayerGui

menu.Name = "menu"
menu.Parent = SakuraTeam
menu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
menu.BorderColor3 = Color3.fromRGB(0, 0, 0)
menu.BorderSizePixel = 0
menu.Position = UDim2.new(0.328655869, 0, 0.270916343, 0)
menu.Size = UDim2.new(0, 399, 0, 229)
menu.Image = "rbxassetid://111111283602146"

UICorner.Parent = menu

TextLabel.Parent = menu
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.0150375944, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 179, 0, 30)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "SAKURA TEAM"
TextLabel.TextColor3 = Color3.fromRGB(255, 85, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

TextLabel_2.Parent = TextLabel
TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.BackgroundTransparency = 1.000
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.832402229, 0, 0.566666663, 0)
TextLabel_2.Size = UDim2.new(0, 68, 0, 21)
TextLabel_2.Font = Enum.Font.Unknown
TextLabel_2.Text = "Auto Bounty"
TextLabel_2.TextColor3 = Color3.fromRGB(85, 170, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

earn.Name = "earn"
earn.Parent = menu
earn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
earn.BackgroundTransparency = 0.990
earn.BorderColor3 = Color3.fromRGB(0, 0, 0)
earn.BorderSizePixel = 0
earn.Position = UDim2.new(0.0150375944, 0, 0.262008727, 0)
earn.Size = UDim2.new(0, 179, 0, 42)
earn.Font = Enum.Font.SourceSansBold
earn.Text = "Earn: xxxxxx"
earn.TextColor3 = Color3.fromRGB(99, 247, 255)
earn.TextScaled = true
earn.TextSize = 14.000
earn.TextWrapped = true

time.Name = "time"
time.Parent = menu
time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
time.BackgroundTransparency = 0.990
time.BorderColor3 = Color3.fromRGB(0, 0, 0)
time.BorderSizePixel = 0
time.Position = UDim2.new(0.0150375944, 0, 0.353711784, 0)
time.Size = UDim2.new(0, 351, 0, 67)
time.Font = Enum.Font.SourceSansBold
time.Text = "Time Elapsed: 24h:00m:00s"
time.TextColor3 = Color3.fromRGB(99, 247, 255)
time.TextScaled = true
time.TextSize = 14.000
time.TextWrapped = true

Frame.Parent = menu
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0350877196, 0, 0.77729255, 0)
Frame.Size = UDim2.new(0, 100, 0, 35)

nextplayer.Name = "nextplayer"
nextplayer.Parent = Frame
nextplayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nextplayer.BackgroundTransparency = 1.000
nextplayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
nextplayer.BorderSizePixel = 0
nextplayer.Size = UDim2.new(0, 99, 0, 34)
nextplayer.Font = Enum.Font.SourceSansBold
nextplayer.Text = "Next Player"
nextplayer.TextColor3 = Color3.fromRGB(81, 0, 255)
nextplayer.TextSize = 14.000

UIToolsGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(142, 14, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(31, 28, 24))}
UIToolsGradient.Name = "UIToolsGradient"
UIToolsGradient.Parent = Frame

UICorner_2.Parent = Frame

Frame_2.Parent = menu
Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame_2.BorderSizePixel = 0
Frame_2.Position = UDim2.new(0.328320801, 0, 0.77729255, 0)
Frame_2.Size = UDim2.new(0, 100, 0, 35)

kichhoatcam.Name = "kichhoatcam"
kichhoatcam.Parent = Frame_2
kichhoatcam.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
kichhoatcam.BackgroundTransparency = 1.000
kichhoatcam.BorderColor3 = Color3.fromRGB(0, 0, 0)
kichhoatcam.BorderSizePixel = 0
kichhoatcam.Position = UDim2.new(0.00999999978, 0, 0, 0)
kichhoatcam.Size = UDim2.new(0, 99, 0, 34)
kichhoatcam.Font = Enum.Font.SourceSansBold
kichhoatcam.Text = "Active Camera"
kichhoatcam.TextColor3 = Color3.fromRGB(255, 43, 237)
kichhoatcam.TextSize = 14.000

UICorner_3.Parent = Frame_2

UIToolsGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(14, 28, 38)), ColorSequenceKeypoint.new(0.37, Color3.fromRGB(42, 69, 75)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(41, 72, 97))}
UIToolsGradient_2.Name = "UIToolsGradient"
UIToolsGradient_2.Parent = Frame_2

Fade.Name = "Fade"
Fade.Parent = menu
Fade.AnchorPoint = Vector2.new(0.5, 0.5)
Fade.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fade.BackgroundTransparency = 1.000
Fade.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fade.BorderSizePixel = 0
Fade.Position = UDim2.new(0.5, 0, 0.794736862, 0)
Fade.Size = UDim2.new(1, 0, 0.400000006, 0)
Fade.Image = "rbxassetid://14840801383"
Fade.ImageColor3 = Color3.fromRGB(20, 20, 20)
Fade.ImageTransparency = 0.500

UICorner_4.Parent = Fade

Pattern.Name = "Pattern"
Pattern.Parent = menu
Pattern.AnchorPoint = Vector2.new(0.5, 0)
Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pattern.BackgroundTransparency = 1.000
Pattern.BorderColor3 = Color3.fromRGB(0, 0, 0)
Pattern.BorderSizePixel = 0
Pattern.Position = UDim2.new(0.495000005, 0, 0.600000024, 0)
Pattern.Size = UDim2.new(1, 0, 0.400000006, 0)
Pattern.Image = "rbxassetid://14841319882"
Pattern.ImageColor3 = Color3.fromRGB(0, 0, 0)
Pattern.ImageTransparency = 0.250

UICorner_5.Parent = Pattern
--// Edit Gui
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end
MakeDraggable(menu,TextLabel)
nextplayer.MouseButton1Down:Connect(function()
    findtarget()
end)
CamFarm = _G.Setting.Misc["Enable Cam Farm"]
if CamFarm == false then
    kichhoatcam.Text = "Enable Cam Farm"
    game.Players.LocalPlayer.CameraMinZoomDistance = 127
    game.Players.LocalPlayer.CameraMaxZoomDistance = 127
    game.Players.LocalPlayer.CameraMaxZoomDistance = 127
    game.Players.LocalPlayer.CameraMinZoomDistance = 0
else
    CamFarm = true
    kichhoatcam.Text = "Disable Cam Farm"
    game.Players.LocalPlayer.CameraMinZoomDistance = 0
    game.Players.LocalPlayer.CameraMaxZoomDistance = 0
    game.Players.LocalPlayer.CameraMaxZoomDistance = 127
    game.Players.LocalPlayer.CameraMinZoomDistance = 0
end
Frame_2.MouseButton1Down:Connect(function()
    if CamFarm == true then
        CamFarm = false
        kichhoatcam.Text = "Enable Cam Farm"
        game.Players.LocalPlayer.CameraMinZoomDistance = 127
        game.Players.LocalPlayer.CameraMaxZoomDistance = 127
        game.Players.LocalPlayer.CameraMaxZoomDistance = 127
        game.Players.LocalPlayer.CameraMinZoomDistance = 0
    else
        CamFarm = true
        kichhoatcam.Text = "Disable Cam Farm"
        game.Players.LocalPlayer.CameraMinZoomDistance = 0
        game.Players.LocalPlayer.CameraMaxZoomDistance = 0
        game.Players.LocalPlayer.CameraMaxZoomDistance = 127
        game.Players.LocalPlayer.CameraMinZoomDistance = 0
    end
end)
--// Counter
local foldername = "Sakura Team Auto Bounty"
local filename = foldername.."/Config.json"
function saveSettings()
    local HttpService = game:GetService("HttpService")
    local json = HttpService:JSONEncode(_G)
    if true then
        if isfolder(foldername) then
            if isfile(filename) then
                writefile(filename, json)
            else
                writefile(filename, json)
            end
        else
            makefolder(foldername)
        end
    end
end
function loadSettings()
    local HttpService = game:GetService("HttpService")
    if isfolder(foldername) then
        if isfile(filename) then
            _G = HttpService:JSONDecode(readfile(filename))
        end
    end
end
_G.Total = 0
_G.Time = 0
Bounty = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value
Earned = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
Earned2 = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
startTime = tick() - _G.Time
OldTotalEarned = _G.Total 
TotalEarned = _G.Total
function GetElapsedTime(startTime)
    local elapsedTime = tick() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    _G.Time = elapsedTime
    local formattedTime = string.format("%dh:%dm:%ds", hours, minutes, seconds)
    return formattedTime
end
spawn(function()
    while task.wait() do 
        Earned = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
        TotalEarned = OldTotalEarned + Earned
        _G.Total = TotalEarned
        task.wait(0.01)
        earn.Text = "Earn: "..tostring(TotalEarned)
        time.Text = "Time Elapsed: "..tostring(GetElapsedTime(startTime))
        saveSettings()
        if checktarget() then
            if enemy:DistanceFromCharacter(WaitHRP(lp).Position) <= 30 then
                local skills = getAvailableSkills(_G.Setting)
                if skills then
                    equip(skills[3])
                    down(skills[1], skills[2]["Hold Time"])
                    Attack()
                end
            end
        end
    end
end)
local radius = 15
local angle = 0
function getNextPosition(center)
    angle = angle + 20
    return center + Vector3.new(math.sin(math.rad(angle)) * radius, 20, math.cos(math.rad(angle)) * radius)
end
function CheckAntiCheatBypass()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "General" or v.Name == "Shiftlock" or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
                v:Destroy()
            end
        end
    end
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans" or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp"  or v.Name == "PlayerList" then
                v:Destroy()
            end
        end
    end
end
CheckAntiCheatBypass()
while task.wait() do 
    if hopserver then 
        to(CFrame.new(0,9000,0))
    else
        if enemy and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.Health > 4 then
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
            end
            if (not (game.Players.LocalPlayer.Character:FindFirstChild("HasBuso"))) then
                local rel = game.ReplicatedStorage
                rel.Remotes.CommF_:InvokeServer("Buso")
            end
            if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                buoi = true
            else
                game:service("VirtualUser"):CaptureController()
                game:service("VirtualUser"):SetKeyDown("0x65")
                game:service("VirtualUser"):SetKeyUp("0x65")
            end 
            if tonumber(lp.Character.Humanoid.Health) > 0 and (tonumber(lp.Character.Humanoid.Health) < _G.Setting.Misc["Hide Health"][1] or (hide and tonumber(lp.Character.Humanoid.Health) < _G.Setting.Misc["Hide Health"][2])) then 
                hide = true 
                to(WaitHRP(enemy).CFrame+Vector3.new(0,math.random(9999,99999), 0)) 
            else
                hide = false
                local digit = WaitHRP(enemy).CFrame + (WaitHRP(enemy).Velocity/2)
                if digit.Y < 10 then 
                    digit = CFrame.new(digit.X, 10, digit.Z) 
                end 
                CFrameHunt = WaitHRP(enemy).CFrame
                if enemy.Character:FindFirstChild("Busy") and enemy.Character.Busy.Value then
                    to(getNextPosition(CFrameHunt))
                else
                    if enemy.Character:FindFirstChild("Humanoid") and enemy.Character.Humanoid.MoveDirection.Magnitude > 0 then
                        to(digit+Vector3.new(1,4,1))
                        if (not lp.Character:FindFirstChild("Busy") or not lp.Character.Busy.Value) and not game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible then
                            Click()
                        end
                    else
                        to(CFrameHunt+Vector3.new(1,4,1))
                    end
                    task.wait(0.1)
                end
            end
        end
    end
end