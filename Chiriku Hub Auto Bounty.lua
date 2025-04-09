--// Chiriku Hub Auto Bounty (Full Version) | Mobile Friendly
--// Tự chọn team, auto bounty, next player, hop server
--// By ChatGPT theo yêu cầu người dùng

--// Auto Join Team
local chosenTeam = getgenv().Team or "Pirates"
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
local args = {
    ["Pirates"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
    end,
    ["Marines"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
    end,
    ["Random"] = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", math.random(1, 2) == 1 and "Pirates" or "Marines")
    end
}
if args[chosenTeam] then args[chosenTeam]() end

--// Dịch vụ cần
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

--// Kiểm tra người chơi hợp lệ
local function IsEnemy(player)
    if player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local pvp = player:FindFirstChild("Data") and player.Data:FindFirstChild("PVP")
        local inSafeZone = player.Character:FindFirstChild("ForceField") ~= nil
        return humanoid and humanoid.Health > 0 and (not inSafeZone) and (pvp and pvp.Value == true)
    end
    return false
end

--// Tìm mục tiêu gần nhất
local function GetClosestTarget()
    local closest, dist = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsEnemy(player) then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local magnitude = (root.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                if magnitude < dist then
                    closest = player
                    dist = magnitude
                end
            end
        end
    end
    return closest
end

--// Tấn công mục tiêu
local function Attack(target)
    repeat
        if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then break end
        LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
        game:service("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
        game:service("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
        task.wait(0.2)
    until not IsEnemy(target)
end

--// Chuyển server khác
local function HopServer()
    local PlaceID = game.PlaceId
    TeleportService:Teleport(PlaceID)
end

--// UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Chiriku Hub - Auto Bounty", "DarkTheme")
local Main = Window:NewTab("Auto Bounty")
local MainSection = Main:NewSection("Chức năng chính")

local AutoBounty = false
local AutoFarmLoop

MainSection:NewToggle("Auto Bounty", "Bật/Tắt săn người tự động", function(value)
    AutoBounty = value
    if AutoBounty then
        AutoFarmLoop = task.spawn(function()
            while AutoBounty do
                local target = GetClosestTarget()
                if target then
                    Attack(target)
                else
                    HopServer()
                end
                task.wait(0.5)
            end
        end)
    else
        if AutoFarmLoop then task.cancel(AutoFarmLoop) end
    end
end)

MainSection:NewButton("Next Player", "Chuyển sang người chơi khác", function()
    local target = GetClosestTarget()
    if target then
        Attack(target)
    end
end)

MainSection:NewButton("Hop Server", "Tìm server khác", function()
    HopServer()
end)