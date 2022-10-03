GLOBAL.CHEATS_ENABLED = true
AddReplicableComponent("pho")

-- 给玩家头上挂一个文本，显示光合度
AddPlayerPostInit(function (player)
    -- 在主机上添加组件pho
    if GLOBAL.TheWorld.ismastersim then
        player:AddComponent("pho")
    end
    player:DoTaskInTime(1,function (player)
        local FollowText = GLOBAL.require "widgets/followtext"
        -- 仅在玩家由HUD时处理这个
        if player and player.HUD then
            player.headwidget = player.HUD:AddChild(FollowText(GLOBAL.TALKINGFONT, 35))
            player.headwidget:SetHUD(player.HUD.inst)
            player.headwidget:SetOffset(GLOBAL.Vector3(0, -500, 0))
            player.headwidget:SetTarget(player)
            player.headwidget.text:SetColour(1, 1, 1, 1)
            player.headwidget.text:SetString("光合度: 没有数据")
            player.headwidget:Show()
            
            local OldOnUpdate = player.headwidget.OnUpdate
            -- OnUpdate会持续更新UI组件的状态，可以不断读取属性值来修改文本显示
            player.headwidget.OnUpdate = function (self, dt)
                OldOnUpdate(self, dt)
                -- 用replica的GetCurrent来获取数据，如果要移植到单机，此处只需替换replica为components
                local current = player.replica.pho:GetCurrent()
                player.headwidget.text:SetString(string.format("光合度: %.2f", current))
            end
        end
    end)
end)



AddModRPCHandler("Lesson Network","RandomPho", function(player, num)
    -- 在RPC函数中，默认是主机环境
    player.components.pho.current = num
end)

-- 按下R键随机更新光合度
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_R, function()
    local num = GLOBAL.math.random()*100
    SendModRPCToServer(GetModRPC("Lesson Network","RandomPho"), num)
end)