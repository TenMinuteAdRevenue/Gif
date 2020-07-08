local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		BindableEvent = Instance.new("BindableEvent")
	}, Signal)
end

function Signal:Fire(...)
	self.Arguments = {...}
	self.BindableEvent:Fire()
end

function Signal:Wait()
	self.BindableEvent.Event:Wait() 
	
	return unpack(self.Arguments)	
end

function Signal:Connect(callback)
	return self.BindableEvent.Event:Connect(function()
		callback(unpack(self.Arguments))
	end)
end

return Signal