# DOORS Custom Achievements

A simple module that allows you to visually unlock fake achievements in Roblox DOORS.

## Features

- Allows you to grant/revoke custom achievements
- Custom achievements can be remembered for future runs

## Limitations

- Custom achievements are client-sided and purely visual, of course

## Usage

### Grant a custom achievement

```lua
local CustomAchievements = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Custom-Achievements/main/init.luau"))()

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
```

### Revoke an achievement

```lua
CustomAchievements:Revoke("TestAchievement")
```

### Check if player owns an achievement

```lua
local owned: boolean = CustomAchievements:CheckOwned("TestAchievement")
```