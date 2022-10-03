local Pho = Class(function(self, inst)
    self.inst = inst
    self._current = net_float(inst.GUID, "pho._current")
end)

function Pho:SetCurrent(current)
    if self.inst.components.pho then
        -- 更新网络变量，仅在主机执行
        current = current or 0
        self._current:set(current)
    end
end

function Pho:GetCurrent()
    if self.inst.components.pho ~= nil then
        -- 在主机直接读取component的值
        return self.inst.components.pho.current
    else
        -- 在客机读取网络变量的值
        return self._current:value()
    end
end

return Pho