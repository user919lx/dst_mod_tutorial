local function on_current(self, current)
    -- 主机对current赋值时，同时调用replica的赋值函数
    self.inst.replica.pho:SetCurrent(current)
end

local Pho = Class(function(self, inst)
    self.inst = inst
    self.current = 0
    self.max = 100
    self:Init()
end,
nil,
{
    -- 元方法，在每次对current赋值时执行这个函数
    current = on_current,
})

function Pho:Init()
    self.inst:StartUpdatingComponent(self)
end

function Pho:DoDelta(delta)
    self.current = math.clamp(self.current + delta, 0, self.max)
end

function Pho:OnUpdate(dt)
    local delta = 0.1 * dt
    self:DoDelta(delta)
end

-- 该方法用于兼容单机版，在联机版中不使用（replica同名方法替代）
function Pho:SetCurrent(current)
    -- 使用rawset不触发元方法，也就是不会执行on_current
    -- rawset(self, "current", current)
    self.current = current
end

return  Pho
