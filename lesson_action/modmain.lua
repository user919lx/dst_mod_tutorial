local _G = GLOBAL

-- 为所有玩家添加新组件ironhand
AddPrefabPostInitAny(function(inst)
    if(inst:HasTag("player")) then
        inst:AddComponent("ironhand")
    end
end)


-- 创建新动作
local act = {
    id = "IRONHAND",
    -- str的内容会在游戏界面中显示
    str = "铁手",
    -- action触发时执行的fn
    fn = function(act)
        if act.doer.components.ironhand ~= nil then
            return act.doer.components.ironhand:Work(act.target)
        end
        return false
    end,
    state = "dojostleaction"
}
local act_ironhand = AddAction(act.id, act.str, act.fn)


-- 添加动作处理器，将动作与人物SG连接，也就是指定触发动作时会进入的state
-- 主客机的两个SG都要添加
-- 这里进入的state是dojostleaction 空手出拳的动作
AddStategraphActionHandler("wilson",_G.ActionHandler(act_ironhand, act.state))
AddStategraphActionHandler("wilson_client",_G.ActionHandler(act_ironhand,act.state))


-- 设置组件动作，满足特定条件时将动作写入可执行动作表
-- 添加的是一个SCENE动作，对世界地图上任意含有workable组件的物体，比如树、矿石等，都会进入触发检测
-- 触发检测testfn
local cmp_act = {
    type = "SCENE",
    -- 注意component指的是inst的component，不同type下的inst指代的目标不同，此处的inst是指动作的目标，也就是要砍的树、要挖的矿石等
    component = "workable",
    -- doer指的是执行动作的角色，也就是玩家
    testfn = function (inst, doer, actions, right)
        if doer:HasTag("ironhand") then
            table.insert(actions, act_ironhand)
        end
    end
}
AddComponentAction(cmp_act.type, cmp_act.component, cmp_act.testfn)