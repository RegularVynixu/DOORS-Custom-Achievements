local CustomAchievements = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Custom-Achievements/main/init.luau"))()

if CustomAchievements:CheckOwned("TestAchievement") then
    CustomAchievements:Revoke("TestAchievement")
end

CustomAchievements:Grant({
    Identifier = "TestAchievement",
    Title = "Title",
    Desc = "Description",
    Reason = "Reason",
    Image = "rbxassetid://12309073114"
}, {
    CheckOwned = true,
    Remember = true
})