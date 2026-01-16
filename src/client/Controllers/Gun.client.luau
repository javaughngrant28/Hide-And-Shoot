local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ToolDetectore = require(script.Parent.Parent.Modules.ToolDetectore)
local Mouse = require(script.Parent.Parent.Modules.Mouse)
local Throttle = require(game.ReplicatedStorage.Libraries.Throttle)
local GunConfig = require(game.ReplicatedStorage.Shared.Configs.GunConfig)

local Player = Players.LocalPlayer
local ShootEvent = ReplicatedStorage.Events:WaitForChild('Shoot')

local rayCastPerms: RaycastParams


ToolDetectore.AddedSignal:Connect(function(tool: Tool)
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local filter = {tool,Character}

    local perms = RaycastParams.new()
    perms.FilterType = Enum.RaycastFilterType.Exclude
    perms.FilterDescendantsInstances = filter

    rayCastPerms = perms
end)

ToolDetectore.EquippedSignal:Connect(function(tool: Tool)
    local activedConnection: RBXScriptConnection
    local destroyConnection: RBXScriptConnection
    local unequippedConnection: RBXScriptConnection

    local attachment = tool:FindFirstChildWhichIsA('Attachment',true)
    assert(attachment,`{tool} Has no attachment`)

    local function Fire()
        local rayPosition = Mouse.GetPosition(rayCastPerms)
        local rayInstance = Mouse.GetTarget(rayCastPerms)
        ShootEvent:FireServer(attachment.WorldCFrame.Position,rayPosition,rayInstance)
    end

    activedConnection = tool.Activated:Connect(function()
        Throttle('FireGun',GunConfig.ShootDebounce,Fire)
    end)

    local function DestroyConnections()
        activedConnection:Disconnect()
        unequippedConnection:Disconnect()
        destroyConnection:Disconnect()
    end

    unequippedConnection = tool.Unequipped:Once(DestroyConnections)
    destroyConnection = tool.Destroying:Once(DestroyConnections)
end)



