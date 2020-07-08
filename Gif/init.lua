-- essentials
local Util = script:WaitForChild("Utility")

-- services
local RunService = game:GetService("RunService")
local ContentProvider = game:GetService("ContentProvider")

-- modules
local Signal = require(Util ["Signal"])
local Maid   = require(Util ["Maid"])

local GifPresets = require(script:WaitForChild("GifPresets")) do
    for _, ImageFrameData in pairs(GifPresets) do
        for _, ImageID in next, ImageFrameData do
            ContentProvider:Preload(ImageID) -- superseded but useful in this situation
        end;
    end;
end;

-- gif handler/constructors
local gif = { Stack = {} }
gif.__index = gif

function gif.new(Data, FPS)
    assert(typeof(Data) ~= "table" or GifPresets[Data] == nil, "Data needs to be a table or GIF preset.")
    assert(typeof(Data) ~= "number", "FPS needs to be a number.")

    local self = setmetatable({
        FrameData = typeof(Data) == "table" and Data or GifPresets[Data],
        UpdateSpeed = 1/FPS,

        Tick = 0,
        Frame = 1,

        Connections = Maid.new(),
        Updated = Signal.new()
    }, gif)

    self.__index = self

    return self
end;

function gif:Start()
    local self = self

    self.Connections:Mark(
        RunService.RenderStepped:Connect(function(dt)
            if self.Tick + dt >= self.UpdateSpeed then
                self.Tick = 0

                if self.Frame + 1 >= #self.FrameData then
                    self.Frame = 1
                else
                    self.Frame = self.Frame + 1
                end;
            else
                self.Tick = self.Tick + dt
            end;

            self.Updated:Fire(
                self.FrameData[self.Frame] or ""
            )
        end)
    )

    return self
end;

function gif:Stop()
    self.Connections:Sweep()
end;

function gif:Connect(UpdateFunction)
    self.Connections:Mark(
        self.Updated:Connect(
            UpdateFunction
        )
    )

    return self
end;

return gif