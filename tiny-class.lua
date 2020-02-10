function class(prototype)
    local class = setmetatable({prototype = prototype}, {__index = prototype})
    -- object inheritance
    class.constructor = function(self, ...) end
    class.id = function(self, object) return tostring(object):sub(8) end -- object id
    class.new = function(self, ...)
        local new = {}
        local super = setmetatable({class = self, id = self.id and self:id(new) or nil}, {__index = self.prototype})
        local prototype = setmetatable(new, {__index = super})
		    local object = setmetatable({}, {__index = prototype, __tostring = function() return 'object: '..tostring(prototype):sub(8) end, __newindex = function(self, k, v) pcall(not({class=1,id=1})[k] and rawset, self, k, v) end})
        if self.constructor then self.constructor(object, ...) end
        return object
    end
    -- add variables to class, non-static and static
    class.implement = function(self, prototype, static)
        local prototype = setmetatable(prototype, {__index = (static or false) and getmetatable(self).__index or self.prototype})
        if (static or false) then
            local mt = getmetatable(self).__index
            setmetatable(self, {__index = prototype})
        else
            rawset(self, 'prototype', prototype)
        end
    end
    -- class extension
    class.extend = function(self, prototype)
        local prototype = setmetatable(prototype, {__index = self.prototype})
        local class = setmetatable({prototype = prototype, super = self}, {__index = self})
        return setmetatable({}, {__index = class, __tostring = function() return 'class: '..tostring(class):sub(8) end, __newindex = function(self, k, v) pcall(not({prototype=1,new=1,implement=1,extend=1,super=1})[k] and rawset, self, k, v) end})
    end
    -- return new class
    return setmetatable({}, {__index = class, __tostring = function() return 'class: '..tostring(class):sub(8) end, __newindex = function(self, k, v) pcall(not({prototype=1,new=1,implement=1,extend=1})[k] and rawset, self, k, v) end})
end
