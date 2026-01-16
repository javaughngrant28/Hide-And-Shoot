local ReplicatedStorage = game:GetService("ReplicatedStorage")
local soundUtil = require(ReplicatedStorage.Shared.Utils.SoundUtil)
local hitSound = ReplicatedStorage.Assets.Sounds.LazerHit


local function PlayHitSound(position: Vector3)
    soundUtil.PlayAtPosition(hitSound,position)
end


return {
    Play = PlayHitSound
}

