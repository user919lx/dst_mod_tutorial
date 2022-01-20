local require = GLOBAL.require
local pcall = GLOBAL.pcall

-- 为了方便后续添加其它的动作，类似官方代码中的Recipe，将新动作的相关参数都集中存放在一个module中的若干table里
local actions_status,actions_data = pcall(require,"lf_actions")

-- 这部分的代码是固定的，添加新的动作并不需要改动此处，只需要修改lf_actions.lua文件中的内容
if actions_status then
    -- 导入自定义动作
    if actions_data.actions then
        for _,act in pairs(actions_data.actions) do
            -- 首先需要使用AddAction注册新动作，会返回这个动作，可以进一步添加一些动作相关参数比如施放距离等
            local action = AddAction(act.id,act.str,act.fn)
            if act.actiondata then
                for k,data in pairs(act.actiondata) do
                    action[k] = data
                end
            end
            -- 将这个新动作与SG做绑定，wilson是玩家人物通用的SG，客机玩家还有额外的wilson_client为SG，为了保证客机一致性，都进行绑定
            AddStategraphActionHandler("wilson",GLOBAL.ActionHandler(action, act.state))
            AddStategraphActionHandler("wilson_client",GLOBAL.ActionHandler(action,act.state))
        end
    end
    -- 导入动作与组件的绑定
    if actions_data.component_actions then
        for _,v in pairs(actions_data.component_actions) do
            -- 这里定义的testfn，需要在判定条件合格后将动作插入动作序列
            local testfn = function(...)
                local actions = GLOBAL.select(-2,...)
                for _,data in pairs(v.tests) do
                    if data and data.testfn and data.testfn(...) then
                        data.action = string.upper( data.action )
                        table.insert( actions, GLOBAL.ACTIONS[data.action] )
                    end
                end
            end
            AddComponentAction(v.type, v.component, testfn)
        end
    end
end

-- 为所有玩家添加额外的组件ironhand
AddPrefabPostInitAny(function(inst)
    if(inst:HasTag("player")) then
        inst:AddComponent("ironhand")
    end
end)