local Translations = {
   --["Kagu Hub"] = "Kagu Hub",
    ["Lock"] = "锁定",
    ["Main"] = "主界面",
    ["Info"] = "信息",
    ["UI Settings"] = "UI设置",
    ["Toggle"] = "切换",
    ["Community"] = "社区",
    ["You can find the community of our Kagu Hub script in diskord and telegram. I can help you there if you encounter any errors."] = "长夜月汉化",
    ["Telegram Channel Discord Server"] = "Telegram频道 Discord服务器",
    ["SUBMARINES"] = "潜艇",
    ["War Tycoon: v1.3.0"] = "战争大亨: v1.3.0",
    ["Search"] = "搜索",
    ["Custom theme name"] = "自定义主题名称",
    ["Create theme"] = "创建主题",
    ["Custom themes"] = "自定义主题",
    ["Load theme"] = "加载主题",
    ["Overwrite theme"] = "覆盖主题",
    ["Delete theme"] = "删除主题",
    ["Refresh list"] = "刷新列表",
    ["Defresh list"] = "刷新列表",
    ["Set as autoload"] = "设置为自动加载",
    ["Reset autoload"] = "重置自动加载",
    ["Kill Aura"] = "杀戮光环",
    ["Ignore Own Vehicle"] = "忽略自己的载具",
    ["Target Helicopter"] = "目标直升机",
    ["Target Vehicles"] = "目标车辆",
    ["Target Planes"] = "目标飞机",
    ["Target Gunship"] = "目标武装直升机",
    ["Target Tank"] = "目标坦克",
    ["Target Boats"] = "目标船只",
    ["Rocket Count"] = "火箭数量",
    ["Get RPG"] = "获取RPG",
    ["ESP"] = "透视",
    ["If the ESPs are broken or working poorly, then turn them off and restart the script without changing the window."] = "如果ESP功能损坏或工作不正常，请关闭它们并在不更改窗口的情况下重新启动脚本",
    ["Enable ESP"] = "启用ESP",
    ["Box"] = "方框",
    ["Tracers"] = "追踪线",
    ["Name"] = "名称",
    ["Health Bar"] = "生命条",
    ["Refresh ESP"] = "刷新ESP",
    ["Target Drones"] = "目标无人机",
    ["Fly"] = "飞行",
    ["Fly Speed"] = "飞行速度",
    ["NoClip"] = "穿墙模式",
    ["No Fall Damage"] = "无坠落伤害",
    ["Full Bright"] = "全亮",
    ["FPS Boost"] = "FPS提升",
    ["RPG"] = "RPG",
    ["ONLY WITH RPG"] = "仅限使用RPG时",
    ["If the RPG doesn't fire, then rejoin (it may also not reach)"] = "如果RPG无法发射，请重新加入游戏（也可能无法命中目标）",
    ["Nuke Aura"] = "核弹光环",
    ["Aura Range"] = "光环范围",
    ["Nuke Shield"] = "核弹护盾",
    ["Rocket MultiShot"] = "火箭多重射击",
    ["Money"] = "金钱",
    ["Auto Crate"] = "自动开箱",
    ["Auto Buy"] = "自动购买",
    ["Character"] = "角色",
    ["Speed Hack"] = "加速",
    ["CFrame Multiplier"] = "CFrame倍增器",
    ["Time"] = "时间",
    ["Friend Boost"] = "好友助力",
    ["Combat"] = "战斗",
    ["Silent Aim"] = "静默瞄准",
    ["TeamCheck"] = "队伍检查",
    ["Target Part"] = "目标部位",
    ["Head"] = "头部",
    ["Fov Enabled"] = "启用视野",
    ["Fov Changer"] = "视野修改器",
    ["Set as default"] = "设为默认",
    ["Reset default"] = "重置默认",
    ["Current autoload config: none"] = "当前自动加载配置：无",
    ["Themes"] = "主题",
    ["Background color"] = "背景颜色",
    ["Main color"] = "主颜色",
    ["Accent color"] = "强调色",
    ["Outline color"] = "轮廓颜色",
    ["Font color"] = "字体颜色",
    ["Font Face"] = "字体",
    ["Code"] = "代码",
    ["Theme list"] = "主题列表",
    ["Default"] = "默认",
    ["Delete config"] = "删除配置"
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                
