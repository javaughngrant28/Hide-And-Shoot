local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShootEvent = ReplicatedStorage.Events:WaitForChild('Shoot')
local BrickEffect = require(script.BrickEffect)

local function Shoot(player: Player, originPosition: Vector3, targetPsotion: Vector3)
    BrickEffect.Fire(originPosition,targetPsotion)
end

ShootEvent.OnServerEvent:Connect(Shoot)