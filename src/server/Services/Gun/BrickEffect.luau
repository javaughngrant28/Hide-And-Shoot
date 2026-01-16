local TweenService = game:GetService("TweenService")

local brickColor = BrickColor.new('Med. yellowish green')
local size = Vector3.new(1,1,1)

local tweenTime = 0.8

local part = Instance.new('Part')
part.BrickColor = brickColor
part.Size = size
part.Anchored = true
part.CanCollide = false
part.CanTouch = false
part.CanQuery = false
part.Material = Enum.Material.Neon
part.Transparency = 0.2

local tweenInfo = TweenInfo.new(tweenTime,Enum.EasingStyle.Linear)


local function CreareBrick(originPosition: Vector3, targetPsotion: Vector3)
    local direction = targetPsotion - originPosition
    local length = direction.Magnitude
    local halfWayPoint = originPosition + (direction / 2)

    local brick = part:Clone()
    brick.Parent = workspace
    brick.CFrame =  CFrame.lookAt(halfWayPoint,targetPsotion)
    brick.Size = Vector3.new(size.X,size.Y,length)

    local tween = TweenService:Create(brick,tweenInfo,{Transparency = 1})
    tween.Completed:Once(function()
        tween:Destroy()
    end)

    tween:Play()
end

return {
    Fire = CreareBrick
}
