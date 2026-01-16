local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ShootEvent = ReplicatedStorage.Events:WaitForChild('Shoot')


local function Shoot(player: Player, originPosition: Vector3, targetPsotion: Vector3)
    print(player,originPosition,targetPsotion)
end

ShootEvent.OnServerEvent:Connect(Shoot)