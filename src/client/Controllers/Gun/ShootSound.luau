
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local soundUtil = require(ReplicatedStorage.Shared.Utils.SoundUtil)
local sound = ReplicatedStorage.Assets.Sounds.LazerFire


local function FireSound()
    soundUtil.PlayOnClient(sound)
end

return {
    Fire = FireSound
}