local T1 = 100

local IronHand = Class(function(self, inst)
    self.inst = inst
    self.proficiency = 0 -- 记录熟练度
    self.inst:AddTag("ironhand") -- 添加tag方便动作检测
end,
nil,
nil)


function IronHand:Work(target)
    -- 主要函数，action中调用执行
    if target.components.workable ~= nil and
        target.components.workable:CanBeWorked() then
        target.components.workable:WorkedBy(self.inst, 1)
        self:DoHealthDelta()
        self:DoProficiencyDelta(1)
        return true
    end
    return false
end

function IronHand:DoHealthDelta()
    if(self.proficiency<T1) and self.inst.components.health~=nil then
        self.inst.components.health:DoDelta(-1)
    end
end


function IronHand:DoProficiencyDelta(delta)
    self.proficiency = self.proficiency + delta
    self.inst.components.talker:Say(string.format("当前熟练度 %d", self.proficiency))
end


function IronHand:OnSave()
    -- 关闭游戏前储存熟练度
    return { proficiency = self.proficiency }
end

function IronHand:OnLoad(data)
    -- 打开游戏前加载之前储存的熟练度
    if data.proficiency ~= nil then
        self.proficiency = data.proficiency
    end
end

return IronHand