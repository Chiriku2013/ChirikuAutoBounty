getgenv().Config = {
    ["Team"] = "Pirates",
    ["Config"] = {
        ["Auto V4"] = true,
        ["Skip Race V4 Players"] = true,
        ["Low Health"] = 4500, 5300
    },
    ["Tool"] = {
        ["Melee"] = {["Enable"] = true,
            ["Z"] = {true, 0.7},
            ["X"] = {true, 0.0},
            ["C"] = {true, 0.0}
        },
        ["Blox Fruit"] = {["Enable"] = false,
            ["Z"] = {true, 0},
            ["X"] = {false, 0},
            ["C"] = {false, 0},
            ["V"] = {false, 0},
            ["F"] = {true, 0.3}
        },
        ["Sword"] = {["Enable"] = true,
            ["Z"] = {true, 1.5},
            ["X"] = {true, 0.0}
        },
        ["Gun"] = {["Enable"] = true,
            ["Z"] = {true, 0.1},
            ["X"] = {true, 0.0}
        },
    },
}

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game:GetService("Players").LocalPlayer

for i,v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "Script" then
        v:Destroy()
    end
end

game.Workspace.ChildAdded:Connect(function(child)
    if child.Name == "Script" then
        child:Destroy()
    end
end)

local plr = game.Players.LocalPlayer
if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    repeat task.wait()
        if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
            for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container[getgenv().Config].Frame.TextButton.Activated)) do
                for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
                    b:Fire() 
                end
                v.Function()
            end 
        end
    until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
end

NpcList = {}
for i, v in pairs(game.Workspace.NPCs:GetChildren()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NpcList, v:GetModelCFrame())
    end
end
for i, v in pairs(getnilinstances()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NpcList, v:GetModelCFrame())
    end
end

function CheckNearestTeleporter(aI) -- skid cho nhanh
    vcspos = aI.Position
    min = math.huge
    min2 = math.huge
    local y = game.PlaceId
    if y == 2753915549 then
        OldWorld = true
    elseif y == 4442272183 then
        NewWorld = true
    elseif y == 7449423635 then
        ThreeWorld = true
    end
    if ThreeWorld then
        TableLocations = {
            ["Caslte On The Sea"] = Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
            ["Hydra"] = Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
            ["Mansion"] = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
            ["Great Tree"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
            ["DoorBossNPCPirate"] = Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
            ["DoorBossNPCPirate2"] = Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
        }
    elseif NewWorld then
        TableLocations = {
            ["Mansion"] = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
            ["Flamingo"] = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
            ["CursedShip"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
            ["CursedShip2"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
        }
    elseif OldWorld then
        TableLocations = {
            ["Sky3"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
            ["Sky2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
            ["thanhphoduoibien"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
            ["thanhphoduoibien2"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
        }
    end
    TableLocations2 = {}
    for r, v in pairs(TableLocations) do
        TableLocations2[r] = (v - vcspos).Magnitude
    end
    for r, v in pairs(TableLocations2) do
        if v < min then
            min = v
            min2 = v
        end
    end
    for r, v in pairs(TableLocations2) do
        if v < min then
            min = v
            min2 = v
        end
    end
    for r, v in pairs(TableLocations2) do
        if v <= min then
            choose = TableLocations[r]
        end
    end
    min3 = (vcspos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if min2 <= min3 then
        return choose
    end
end
function requestEntrance(aJ)
    args = {"requestEntrance", aJ}
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    char = game.Players.LocalPlayer.Character.HumanoidRootPart
    char.CFrame = CFrame.new(oldcframe.X, oldcframe.Y + 50, oldcframe.Z)
    task.wait(0.5)
end

function CheckInComBat()
    return plr.PlayerGui.Main.InCombat.Visible and plr.PlayerGui.Main.InCombat.Text and (string.find(string.lower(plr.PlayerGui.Main.InCombat.Text),"risk"))
end 

function BypassTeleport(Pos) -- Skid Teru
    wait(.5)
    pcall(function()
        repeat
            task.wait()
            game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
            plr.Character.HumanoidRootPart.CFrame = Pos
        until plr.Character.PrimaryPart.CFrame == Pos
        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid", 9):ChangeState(15)
        plr.Character:SetPrimaryPartCFrame(Pos)
        wait(0.1)
        plr.Character.Head:Destroy()
        repeat
            task.wait()
        until plr.Character:FindFirstChild("Humanoid").Health <= 0
        repeat
            task.wait()
        until plr.Character:FindFirstChild("Head")
        wait(0.5)
    end)
end

function GetDistance(cc)
    if typeof(cc) == "CFrame" then
        return (cc.Position - plr.Character.HumanoidRootPart.Position).Magnitude
    elseif typeof(cc) == "Vector3" then
        return (cc - plr.Character.HumanoidRootPart.Position).Magnitude
    end
end

function RequestEntrance(ac)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack({"requestEntrance", ac}))
    task.wait(0.01)
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

NeedHop = false
function Tweento(TargetCFrame)
    pcall(function()
        local tweenservice = game:GetService("TweenService")
        local Distance = (plr.Character.HumanoidRootPart.Position - TargetCFrame.Position).Magnitude
        local info = TweenInfo.new(Distance / 350, Enum.EasingStyle.Linear)
        tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, {CFrame = TargetCFrame})
        if not plr.Character.Head:FindFirstChild("Hold") then
            local Hold = Instance.new("BodyVelocity", plr.Character.Head)
            Hold.Name = "Hold"
            Hold.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            Hold.Velocity = Vector3.new(0, 0, 0)
        end
        if Distance <= 250 then
            pcall(function()
                tween:Cancel()
            end)
            plr.Character.HumanoidRootPart.CFrame = TargetCFrame
        end
        if CheckNearestTeleporter(TargetCFrame) and GetDistance(TargetCFrame.Position) > 500 then
            RequestEntrance(CheckNearestTeleporter(TargetCFrame))
        end
        if GetDistance(TargetCFrame.Position) > 2550 and not NeedHop and not CheckInComBat() then
            BypassTeleport(GetBypassPos(TargetCFrame))
        end
        tween:Play()
    end)
end

function EquipTool(name)
    for _, v in game.Players.LocalPlayer.Backpack:GetChildren() do
        if v:IsA("Tool") and tostring(v) == name or v.ToolTip == name then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v) 
            CurrentTool = tostring(v)
        end
    end
end 

ThisTarget = {} 
table.insert(ThisTarget, plr)
function GetTarget()
    playertarget = {}
    for r, v in pairs(game.Players:GetPlayers()) do
        if 
            v and
            v.Name ~= plr.Name and 
            v.Parent and v.Character and 
            v.Character:FindFirstChild("Humanoid") and 
            v.Character:FindFirstChild("HumanoidRootPart") and
            v.Character.Humanoid.Health > 0 and
            tostring(v.Team) == "Pirates" and 
            v.Data.Level.Value - plr.Data.Level.Value < 300 and 
            not table.find(ThisTarget, v) and 
            not table.find(playertarget, v) and
            (getgenv().Config.Config["Skip Race V4 Players"] and 
            not (v.Backpack:FindFirstChild("Awakening") or 
            v.Character:FindFirstChild("Awakening")) or 
            not getgenv().Config.Config["Skip Race V4 Players"])
        then
            table.insert(playertarget, v)
        end
    end
    return playertarget
end

function HopServer() 
    function bQ(v)
        if v.Name == "ErrorPrompt" then
            if v.Visible then
                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                    v.Visible = false
                end
            end
            v:GetPropertyChangedSignal("Visible"):Connect(function()
                if v.Visible then
                    if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                        v.Visible = false
                    end
                end
            end)
        end
    end
    for i, v in game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren() do
        bQ(v) 
    end
    game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
    
    while wait() do
        Tweento(CFrame.new(0, math.random(1000,5000), 0)) 
        if not CheckInComBat() then
            plr.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text = "Singapore"
            for r = 1, math.huge do
                for k, v in game.ReplicatedStorage.__ServerBrowser:InvokeServer(r) do
                    if k ~= game.JobId and v["Count"] <= 10 then
                        game.ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
                    end
                end
            end
        end
    end
 end

function FindTarget()
    dist = math.huge
    returnenemy = nil
    for r, v in pairs(GetTarget()) do
        if v and v.Parent and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if plr and plr.Parent and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if GetDistance(v.Character.HumanoidRootPart.Position) < dist then
                    returnenemy = v
                    dist = GetDistance(v.Character.HumanoidRootPart.Position)
                end
            end
        end
    end
    if returnenemy ~= nil then
        table.insert(ThisTarget, returnenemy)
        target = returnenemy
    else
    HopServer()
        NeedHop = true
    end
end

function CheckRaidTarget(q0) 
    for a=1,5,1 do 
        local a0 = game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island"..a) 
        if a0 and (q0.Character.HumanoidRootPart.Position - a0.Position) < 3000 then 
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
    if not target then 
        print("not target")
        return FindTarget() 
    end 
    if not target.Parent then 
        print("not target parent")
        return FindTarget() 
    end 
    if not target.Character then 
        print("not target character")
        return FindTarget() 
    end   
    if target.Character.Humanoid.Health <= 0 then
        print("target die")
        return FindTarget() 
    end
    if (checkNotify("died") or checkNotify("tį»­ trįŗ­n") or checkNotify("safe") or checkNotify("an toĆ n")) and target:DistanceFromCharacter(plr.Character:WaitForChild("Head", 9).Position) <= 15 then
        print("notify target die")
        return FindTarget() 
    end 
    if CheckRaidTarget(target) then
        print("target is raiding")
        return FindTarget() 
    end
    if plr.PlayerGui.Main.BottomHUDList.SafeZone.Visible and target:DistanceFromCharacter(plr.Character:WaitForChild("Head").Position) <= 15 then
        print("Safe Zone")
        return FindTarget()
    end
    if target:DistanceFromCharacter(plr.Character:WaitForChild("Head").Position) < 300 then 
        if os.time() - fromtime > 100 then 
            if not CheckInComBat() then
                print("bruh, not combat")
                return FindTarget()
            end
        end
    else 
        fromtime = os.time() 
    end
    return true
end

function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
end
function GetWeapon(wpname)
    for r, v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == wpname then
            return v.Name
        end
    end
    for r, v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == wpname then
            return v.Name
        end
    end
end

function GetSkills()
    for r, v in getgenv().Config.Tool do
        if v.Enable then
            CurrentTool = GetWeapon(r)
            for a, b in v do
                if a == "Enable" then
                    -- not
                else
                    if not CurrentTool or not plr.PlayerGui.Main.Skills:FindFirstChild(CurrentTool) or plr.PlayerGui.Main.Skills:FindFirstChild(CurrentTool)[a].Cooldown.AbsoluteSize.X < 5 and b[1]then
                        return {r, a, b}
                    end
                end
            end
        end
    end
end

function down(use, cooldown)
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,use,false,game)
        task.wait(cooldown)
        game:GetService("VirtualInputManager"):SendKeyEvent(false,use,false,game)
    end)
end

spawn(function()
    while wait() do
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false    
            end
        end
    end
end)

spawn(function()
    while task.wait() do
        if target then
            game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
        if getgenv().Config.Config["Auto V4"] then
            down("Y, 1")
        end
    end
end)

-- Gui to Lua
-- Version: 3.6

-- Instances:

local BountyScreen = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local Target = Instance.new("TextLabel")
local TextHub = Instance.new("Frame")
local Hub = Instance.new("TextLabel")
local Features = Instance.new("Frame")
local UIPadding = Instance.new("UIPadding")
local NameOwn = Instance.new("TextLabel")
local Deve = Instance.new("TextLabel")
local Time = Instance.new("TextLabel")
local Earned = Instance.new("TextLabel")
local Total = Instance.new("TextLabel")
local Line = Instance.new("Frame")
local Line_2 = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local UIStroke_2 = Instance.new("UIStroke")

-- Properties:

BountyScreen.Name = "Bounty Screen"
BountyScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Main.Name = "Main"
Main.Parent = BountyScreen
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 367, 0, 435)
Main.Visible = false

UICorner.Parent = Main

UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Parent = Main

DropShadowHolder.Name = "DropShadowHolder"
DropShadowHolder.Parent = Main
DropShadowHolder.BackgroundTransparency = 1.000
DropShadowHolder.BorderSizePixel = 0
DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
DropShadowHolder.ZIndex = 0

DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 51, 1, 51)
DropShadow.ZIndex = 0
DropShadow.Image = "rbxassetid://6014261993"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.500
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

Target.Name = "Target"
Target.Parent = DropShadowHolder
Target.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Target.BackgroundTransparency = 1.000
Target.BorderColor3 = Color3.fromRGB(0, 0, 0)
Target.BorderSizePixel = 0
Target.Position = UDim2.new(0, 0, 0, 180)
Target.Size = UDim2.new(1, 0, 0, 45)
Target.Font = Enum.Font.GothamBold
Target.Text = "Total Earned : 1000000000"
Target.TextColor3 = Color3.fromRGB(255, 255, 255)
Target.TextSize = 14.000

TextHub.Name = "Chiriku Auto Bounty"
TextHub.Parent = Main
TextHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextHub.BackgroundTransparency = 1.000
TextHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextHub.BorderSizePixel = 0
TextHub.Position = UDim2.new(0, 18, 0, 32)
TextHub.Size = UDim2.new(1, -36, 0, 30)

Hub.Name = "Chiriku Auto Bounty"
Hub.Parent = Chiriku Auto Bounty
Hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Hub.BackgroundTransparency = 1.000
Hub.BorderColor3 = Color3.fromRGB(0, 0, 0)
Hub.BorderSizePixel = 0
Hub.Size = UDim2.new(1, 0, 1, 0)
Hub.Font = Enum.Font.GothamBold
Hub.Text = "ZenusX - Auto Bounty"
Hub.TextColor3 = Color3.fromRGB(255, 255, 255)
Hub.TextSize = 28.000

Features.Name = "Features"
Features.Parent = Main
Features.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Features.BackgroundTransparency = 1.000
Features.BorderColor3 = Color3.fromRGB(0, 0, 0)
Features.BorderSizePixel = 0
Features.Position = UDim2.new(0, 18, 0, 87)
Features.Size = UDim2.new(1, -36, 1, -87)

UIPadding.Parent = Features
UIPadding.PaddingBottom = UDim.new(0, 8)
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingRight = UDim.new(0, 8)
UIPadding.PaddingTop = UDim.new(0, 8)

NameOwn.Name = "NameOwn"
NameOwn.Parent = Features
NameOwn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NameOwn.BackgroundTransparency = 1.000
NameOwn.BorderColor3 = Color3.fromRGB(0, 0, 0)
NameOwn.BorderSizePixel = 0
NameOwn.Size = UDim2.new(1, 0, 0, 45)
NameOwn.Font = Enum.Font.GothamBold
NameOwn.Text = "Owner : ! xDark"
NameOwn.TextColor3 = Color3.fromRGB(255, 255, 255)
NameOwn.TextSize = 14.000

Deve.Name = "Deve"
Deve.Parent = Features
Deve.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Deve.BackgroundTransparency = 1.000
Deve.BorderColor3 = Color3.fromRGB(0, 0, 0)
Deve.BorderSizePixel = 0
Deve.Position = UDim2.new(0, 0, 0, 45)
Deve.Size = UDim2.new(1, 0, 0, 45)
Deve.Font = Enum.Font.GothamBold
Deve.Text = "Developer : nil"
Deve.TextColor3 = Color3.fromRGB(255, 255, 255)
Deve.TextSize = 14.000

Time.Name = "Time"
Time.Parent = Features
Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Time.BackgroundTransparency = 1.000
Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
Time.BorderSizePixel = 0
Time.Position = UDim2.new(0, 0, 0, 225)
Time.Size = UDim2.new(1, 0, 0, 45)
Time.Font = Enum.Font.GothamBold
Time.Text = "Account Time : 0H 0M 0S"
Time.TextColor3 = Color3.fromRGB(255, 255, 255)
Time.TextSize = 14.000

Earned.Name = "Earned"
Earned.Parent = Features
Earned.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Earned.BackgroundTransparency = 1.000
Earned.BorderColor3 = Color3.fromRGB(0, 0, 0)
Earned.BorderSizePixel = 0
Earned.Position = UDim2.new(0, 0, 0, 135)
Earned.Size = UDim2.new(1, 0, 0, 45)
Earned.Font = Enum.Font.GothamBold
Earned.Text = "Bounty Earned : 0"
Earned.TextColor3 = Color3.fromRGB(255, 255, 255)
Earned.TextSize = 14.000

Total.Name = "Total"
Total.Parent = Features
Total.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Total.BackgroundTransparency = 1.000
Total.BorderColor3 = Color3.fromRGB(0, 0, 0)
Total.BorderSizePixel = 0
Total.Position = UDim2.new(0, 0, 0, 180)
Total.Size = UDim2.new(1, 0, 0, 45)
Total.Font = Enum.Font.GothamBold
Total.Text = "Total Earned : 1000000000"
Total.TextColor3 = Color3.fromRGB(255, 255, 255)
Total.TextSize = 14.000

Line.Name = "Line"
Line.Parent = Main
Line.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line.BorderSizePixel = 0
Line.Position = UDim2.new(0, 18, 0, 77)
Line.Size = UDim2.new(1, -36, 0, 1)

Line_2.Name = "Line"
Line_2.Parent = Main
Line_2.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Line_2.BorderSizePixel = 0
Line_2.Position = UDim2.new(0, 18, 0, 375)
Line_2.Size = UDim2.new(1, -36, 0, 1)

TextButton.Parent = BountyScreen
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.BackgroundTransparency = 1.000
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.5, 0, 0, 0)
TextButton.Size = UDim2.new(0, 200, 0, 45)
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = "Skip Players"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 18.000

UICorner_2.CornerRadius = UDim.new(0, 3)
UICorner_2.Parent = TextButton

UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Color = Color3.fromRGB(50, 50, 50)
UIStroke_2.Parent = TextButton

TextButton.MouseButton1Click:Connect(function()
    FindTarget()
end)
             
    spawn(function()
        local gg = getrawmetatable(game)
        local old = gg.__namecall
        setreadonly(gg, false)
        gg.__namecall = newcclosure(function(...)
            local method = getnamecallmethod()
            local args = {...}
            if tostring(method) == "FireServer" then
                if tostring(args[1]) == "RemoteEvent" then
                    if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                        if target and target.Character and target.Character.Humanoid.Health > 0 then
                            args[2] = target.Character.HumanoidRootPart.Position
                            return old(unpack(args))
                        end
                    end
                end
            end
            return old(...)
        end)
    end)
    
    function BigHitbox() 
     pcall(function()
        local old = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
        local com = getupvalue(old, 2)
        com.activeController.hitboxMagnitude = 6000
    end) 
 end

task.spawn(function()
    while task.wait() do
        pcall(function()
            if NeedHop then
             --   game.Workspace.CurrentCamera.CameraSubject = plr.Character
                Tweento(CFrame.new(0,9000,0))
            else
                if checktarget() then
                    BigHitbox() 
                    plr.Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                    if GetDistance(target.Character.HumanoidRootPart.Position) <= 80 then
                        if GetSkills() then
                            EquipTool(GetSkills()[1]) 
                            down(GetSkills()[2], GetSkills()[3][2])
                            Click() 
                            if target and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 4 then
                                if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
                                end
                                plr.Character:SetAttribute("DashLength", 100)
                                if (not (game.Players.LocalPlayer.Character:FindFirstChild("HasBuso"))) then
                                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                                end
                                if 
                                    game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and 
                                    game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and 
                                    game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") 
                                then
                                else
                                    game:service("VirtualUser"):CaptureController()
                                    game:service("VirtualUser"):SetKeyDown("0x65")
                                    game:service("VirtualUser"):SetKeyUp("0x65")
                                end 
                                game.Workspace.CurrentCamera.CameraSubject = target.Character
                                if GetDistance(target.Character.HumanoidRootPart.Position) <= 100 then
                                    spawn(Tweento(target.Character.HumanoidRootPart.CFrame * CFrame.new(((math.random(1, 2) == 1 and 0) or -10), 4, 0)))
                                else
                                    Tweento(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0))
                                end
                            end  
                        else
                            Tweento(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                        end
                    else
                        Tweento(target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 4, 0))
                    end
                end
            end
        end)
    end
end)

