# Gif
Easy creation of GIFs with LuaU.

# Example Code
```lua
  local Gif = require(script.Gif)

  local NyanCatInstance = script.Parent:WaitForChild("NyanCat")
  local NyanGif = Gif.new("Nyan Cat", 8):Start()

  NyanGif:Connect(function(ImageID)
    NyanCatInstance.Image = ImageID
  end)
```

# Constructing Explanation
```lua
  local Gif = require(script.Gif) -- requiring the Gif module
  
  Gif.new(
    TABLE or STRING (Table data or preset index), 
    INTEGER (Frames Per Second)
  )
  
  --[[
    There are two ways to construct a gif. One way being: Creating a preset in the "GifPresets" module or pasting the data

    -- Preset Example --
    local MyGIF = Gif.new("Nyan Cat", 8)

    -- Table Example --
    local MyGIF = Gif.new({
        "rbxassetid://5311791662",
        "rbxassetid://5311791766",
        "rbxassetid://5311791844",
        "rbxassetid://5311791971",
        "rbxassetid://5311792083",
        "rbxassetid://5311792184",
        "rbxassetid://5311792289",
        "rbxassetid://5311792403"
   }, 8)
  --]]
```

# Handling Expanation
```lua
  local Gif = require(script.Gif) -- requiring the Gif module

  --[[
    Not really important, but I prefer doing method 1    

    -- Starting "Method" 1 --
    local MyGIF = Gif.new("Nyan Cat", 8):Start()

    -- Starting "Method" 2 --
    local MyGIF = Gif.new("Nyan Cat", 8)

    MyGIF:Start()

    
    Once you call :Start() on MyGIF it will start the cycling between images, except only in MyGIF's data.
    To be able to update your ImageLabel/ImageButton (or other things that you could find this useful for) do:
    

    MyGIF:Connect(function(ImageID)
      -- Image ID is the full "rbxassetid://NUMBER" id, every time the Frame updates, the function wrapped in :Connect() gets called
    end)

    
    To stop MyGIF from running call:

    MyGIF:Stop()

    In doing this, it will completely sweep all of its connections, including the .RenderStepped that handles the cycling.
  ]]
```
