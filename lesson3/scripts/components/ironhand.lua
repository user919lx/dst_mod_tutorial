local IronHand = Class(function(self, inst)
    self.inst = inst
    self.forge_degree = 0 -- 记录熟练度
    self.inst:AddTag("ironhand") -- 添加tag方便动作检测
end,
nil,
nil)


function IronHand:GetNumWorks()
    if(self.forge_degree<200) then
        return 1
    elseif(self.forge_degree<500) then
        return 2
    else
        return 10000
    end
end


function IronHand:Work(target)
    if target.components.workable ~= nil and
        target.components.workable:CanBeWorked() then
        target.components.workable:WorkedBy(self.inst, self:GetNumWorks())
        self:DoHealthDelta()
        self:DoDegreeDelta(1)
        return true
    end
    return false
end

function IronHand:DoHealthDelta()
    if(self.forge_degree<100) and self.inst.components.health~=nil then
        self.inst.components.health:DoDelta(-1)
    end
end


function IronHand:DoDegreeDelta(delta)
    self.forge_degree = self.forge_degree + delta
    self.inst.components.talker:Say(string.format("当前熟练度 %d", self.forge_degree))
end


function IronHand:OnSave()
    return { forge_degree = self.forge_degree }
end

function IronHand:OnLoad(data)
    if data.forge_degree ~= nil then
        self.forge_degree = data.forge_degree
    end
end

return IronHand