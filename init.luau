-- \\ Services // --

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- \\ Variables // --

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Modules = {
    AchievementUnlock = require(PlayerGui:FindFirstChild("AchievementUnlock", true) :: ModuleScript),
}
local DefaultAchievement = {
    Identifier = "TestAchievement",
    Title = "Title",
    Desc = "Description",
    Reason = "Reason",
    Image = "rbxassetid://12309073114"
}
local DefaultOptions = {
    CheckOwned = false,
    Remember = true
}

local Module = {}

type AchievementConfig = {
    Identifier: string?,
    Title: string?,
    Desc: string?,
    Reason: string?,
    Image: string?
}

type Achievement = {
    Title: string,
    Desc: string,
    Reason: string,
    Image: string,
    [string]: any
}

type Options = {
    CheckOwned: boolean,
    Remember: boolean
}

type OwnedAchievements = { string }

-- \\ Functions // --

local function WriteConfig(data: OwnedAchievements): (boolean, string?)
    return pcall(function()
        writefile("DOORS_Custom_Achievements.json", HttpService:JSONEncode(data))
    end)
end

local function DecodeConfig(): OwnedAchievements
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile("DOORS_Custom_Achievements.json"))
    end)
    return success and result or {}
end

-- \\ Main // --

Module.CheckOwned = function(self, identifier: string): boolean
    return table.find(DecodeConfig(), identifier) ~= nil
end

Module.Revoke = function(self, identifier: string)
    local config = DecodeConfig()

    for i, v in next, config do
        if v == identifier then
            table.remove(config, i)
        end
    end

    WriteConfig(config)
end

Module.Grant = function(self, achievementConfig: AchievementConfig, options: Options?)
    options = typeof(options) == "table" and options or DefaultOptions
    
    -- Check if player already owns custom achievement
    local config = DecodeConfig()
    if
        options.CheckOwned
        and table.find(config, achievementConfig.Identifier)
    then
        return
    end
    
    -- Display fake achievement
    task.defer(Modules.AchievementUnlock, Modules, achievementConfig)

    -- Check if custom achievement should be remembered
    if
        options.Remember
        and not self:CheckOwned(achievementConfig.Identifier)
    then
        config[#config + 1] = achievementConfig.Identifier
        WriteConfig(config)
    end
end

return Module
