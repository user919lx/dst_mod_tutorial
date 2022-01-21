local actions = {
    {
        -- ID会在下面的component绑定中使用，全大写
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
        -- 如果有action对应的参数设置，如施放距离或者优先级等，可以在此处添加，因为这个动作较简单，我没有添加额外的参数设置
        -- actiondata = {},
        -- state指的是要绑定的SG的state
        state = "dojostleaction"
    },
}

-- 这个table记录每一个component与action的连接
local component_actions = {
    {
        type = "SCENE",
        -- 注意component指的是inst的component，不同type下的inst指代的目标不同，详情请看第三期文章的讲解，此处的inst是指要砍的树、要挖的矿石等。
        component = "workable",
        tests = {
            -- 允许绑定多个动作，如果满足条件都会插入动作序列中，具体会执行哪一个动作则由动作优先级来判定。
            {
                action = "IRONHAND",
                -- 这里的testfn是在所有的机器上执行的，所以不要使用component来做判断，推荐使用tag，因为主客机都存在。
                testfn = function(inst, doer, actions, right)
                    return doer:HasTag("ironhand")
                end
            }
        }
    }
}
return {actions = actions, component_actions = component_actions}