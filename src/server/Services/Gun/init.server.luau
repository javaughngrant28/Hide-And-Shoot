local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShootEvent = ReplicatedStorage.Events:WaitForChild('Shoot')
local BrickEffect = require(script.BrickEffect)

local function Shoot(player: Player, originPosition: Vector3, targetPsotion: Vector3, rayInstance: Instance?)
    BrickEffect.Fire(originPosition,targetPsotion)
    
    if not rayInstance then return end

    local humanoid = rayInstance.Parent:FindFirstChildWhichIsA('Humanoid') :: Humanoid
    if not humanoid then return end

    humanoid.Health = 0
end

ShootEvent.OnServerEvent:Connect(Shoot)