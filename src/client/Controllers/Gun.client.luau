local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ToolDetectore = require(script.Parent.Parent.Modules.ToolDetectore)
local Mouse = require(script.Parent.Parent.Modules.Mouse)
local Observers = require(game.ReplicatedStorage.Libraries.Observers)

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
    local mouseClickConnection: RBXScriptConnection
    local activedConnection: RBXScriptConnection
    local destroyConnection: RBXScriptConnection
    local unequippedConnection: RBXScriptConnection

    local attachment = tool:FindFirstChildWhichIsA('Attachment',true)
    assert(attachment,`{tool} Has no attachment`)

    activedConnection = tool.Activated:Connect(function()
        mouseClickConnection = Mouse.LeftClick:Connect(function(userInputState)
            if userInputState ~= Enum.UserInputState.End then return end

            local rayPosition = Mouse.GetPosition(rayCastPerms)
            ShootEvent:FireServer(attachment.WorldCFrame,rayPosition)
        end)
    end)

    local function DestroyConnections()
        activedConnection:Disconnect()
        mouseClickConnection:Disconnect()
        unequippedConnection:Disconnect()
        destroyConnection:Disconnect()
    end

    unequippedConnection = tool.Unequipped:Once(DestroyConnections)
    destroyConnection = tool.Destroying:Once(DestroyConnections)
end)



