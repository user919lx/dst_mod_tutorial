local DEGREE_1 = 100
local DEGREE_2 = 200
local DEGREE_3 = 500


local IronHand = Class(function(self, inst)
    self.inst = inst
    self.forge_degree = 0 -- 记录熟练度
    self.inst:AddTag("ironhand") -- 添加tag方便动作检测
end,
nil,
nil)


function IronHand:GetNumWorks()
    if(self.forge_degree<DEGREE_2) then
        return 1
    elseif(self.forge_degree<DEGREE_3) then
        return 2
    else
        return 10000
    end
end


function IronHand:Work(target)
    -- 主要函数，action中调用执行
    if target.components.workable ~= nil and
        target.components.workable:CanBeWorked() then
        -- 砍树，挖矿，都是通过调用workable的WorkedBy方法来降低目标需要work的次数的，降低为0则目标被摧毁。可以通过这个函数来控制每次降低的量
        target.components.workable:WorkedBy(self.inst, self:GetNumWorks())
        -- 另写一个函数用于计算扣血
        self:DoHealthDelta()
        -- 另写一个函数用于熟练度增加，熟练度的结算放在work之后
        self:DoDegreeDelta(1)
        return true
    end
    return false
end

function IronHand:DoHealthDelta()
    if(self.forge_degree<DEGREE_1) and self.inst.components.health~=nil then
        self.inst.components.health:DoDelta(-1)
    end
end


function IronHand:DoDegreeDelta(delta)
    self.forge_degree = self.forge_degree + delta
    self.inst.components.talker:Say(string.format("当前熟练度 %d", self.forge_degree))
end


function IronHand:OnSave()
    -- 关闭游戏前储存熟练度
    return { forge_degree = self.forge_degree }
end

function IronHand:OnLoad(data)
    -- 打开游戏前加载之前储存的熟练度
    if data.forge_degree ~= nil then
        self.forge_degree = data.forge_degree
    end
end

return IronHand