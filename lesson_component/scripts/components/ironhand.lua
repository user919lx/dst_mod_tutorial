-- 三个阈值点
local T1 = 100
local T2 = 200
local T3 = 500

-- 组件定义和初始化
local IronHand = Class(function(self, inst)
    self.inst = inst
    self.proficiency = 0 -- 熟练度
    self.inst:AddTag("ironhand")
end,
nil,
nil)

-- 计算工作效率，也就是一次动作相当于砍伐几次
function IronHand:GetNumWorks()
    if(self.proficiency<T2) then
        return 1
    elseif(self.proficiency<T3) then
        return 2
    else
        return 10000
    end
end

-- 砍树挖矿的相关逻辑流程
function IronHand:Work(target)
    -- 主要函数，action中调用执行
    if target.components.workable ~= nil and
        target.components.workable:CanBeWorked() then
        -- 砍树，挖矿，都是通过调用workable的WorkedBy方法来降低目标需要work的次数的，降低为0则目标被摧毁。可以通过这个函数来控制每次降低的量
        target.components.workable:WorkedBy(self.inst, self:GetNumWorks())
        -- 血量变化
        self:DoHealthDelta()
        -- 熟练度+1
        self:DoProficiencyDelta(1)
        return true
    end
    return false
end

-- 血量变化
function IronHand:DoHealthDelta()
    -- 熟练度100以下时才会扣1血
    if(self.proficiency<T1) and self.inst.components.health~=nil then
        self.inst.components.health:DoDelta(-1)
    end
end

-- 熟练度变化
function IronHand:DoProficiencyDelta(delta)
    self.proficiency = self.proficiency + delta
    self.inst.components.talker:Say(string.format("当前熟练度 %d", self.proficiency))
end


-- 关闭游戏前储存熟练度
function IronHand:OnSave()
   
    return { proficiency = self.proficiency }
end

-- 打开游戏前加载之前储存的熟练度
function IronHand:OnLoad(data)
    if data.proficiency ~= nil then
        self.proficiency = data.proficiency
    end
end

return IronHand