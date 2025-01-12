--Boombox appearance:
local tool = Instance.new("Tool")
local handle = Instance.new("Part")
local specialmesh = Instance.new("SpecialMesh")

tool.Name = "Lostwave Boombox"
tool.ToolTip = "Makes your life a lot whole lot easier!... as long as it works."
tool.TextureId = "rbxassetid://684265100"
tool.Parent = game.Players.LocalPlayer:FindFirstChild("Backpack") or game.Players.LocalPlayer:WaitForChild("Backpack")

handle.Name = "Handle"
handle.Size = Vector3.new(3.2, 1.6, 1.2)
handle.Parent = tool

specialmesh.Name = "Mesh"
specialmesh.MeshType = Enum.MeshType.FileMesh
specialmesh.MeshId = "http://www.roblox.com/asset/?id=212302951"
specialmesh.TextureId = "http://www.roblox.com/asset/?id=152863214"
specialmesh.Scale = Vector3.new(4, 4, 4)
specialmesh.Parent = handle
-- Gui to Lua
-- Version: 3.2

-- Instances:

local ChooseSongGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextBox = Instance.new("TextBox")
local TextButton = Instance.new("TextButton")

--Properties:

ChooseSongGui.Name = "ChooseSongGui"
ChooseSongGui.Enabled = false
ChooseSongGui.Parent = game.Players.LocalPlayer:FindFirstChild("PlayerGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ChooseSongGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Draggable = true
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0.25, 0, 0.30563283, 0)
Frame.Style = Enum.FrameStyle.RobloxRound

TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1.000
TextLabel.Size = UDim2.new(1, 0, 0.600000024, 0)
TextLabel.Text = "Type the song you wanna play. (song must be made by the creator of this place, this method has a very high chance to fail, check console if it gets stuck/timed-outted.)"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextStrokeTransparency = 0.000
TextLabel.TextWrapped = true

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BackgroundTransparency = 0.500
TextBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Position = UDim2.new(0, 0, 0.600000024, 0)
TextBox.Size = UDim2.new(1, 0, 0.200000003, 0)
TextBox.PlaceholderText = "SoundId goes here..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.TextWrapped = true

TextButton.Parent = Frame
TextButton.Position = UDim2.new(0.125, 0, 0.800000012, 0)
TextButton.Size = UDim2.new(0.75, 0, 0.200000003, 0)
TextButton.Style = Enum.ButtonStyle.RobloxButton
TextButton.Text = "Play!"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextScaled = true
TextButton.TextStrokeTransparency = 0.000
TextButton.TextWrapped = true

-- Scripts:

local function BYNMLN_fake_script() -- TextButton.PlaySound 
	local scriptF = Instance.new('LocalScript', TextButton)

	local MarketplaceService = game:GetService("MarketplaceService")
	local ContentProvider = game:GetService("ContentProvider")
	local Players = game:GetService("Players")
	
	local button = scriptF.Parent
	local textBox = button.Parent.TextBox
	
	local sound
	
	local function warnPlr(msg, info)
		textBox.Text = msg
		if info then
			warn(msg .. " Extra information: " .. info)
		else
			warn(msg)
		end
	end
	
	local function play(soundId, info)
		print("play")
		if sound then
			sound:Destroy()
		end
		textBox.Text = "Trying to load..."
		sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://" .. soundId
		sound.Parent = game.Workspace
		task.wait(1)
		if not sound.IsLoaded then
			task.wait(3)
			if not sound.IsLoaded then
				warnPlr("Sound timeouted. Either this is deleted or just doesn't have permission to run. (check console)")
				return
			end
		end
		sound:Play()
		textBox.Text = "Loaded!"
	end
	
	button.MouseButton1Click:Connect(function()
		print("click")
		local soundId = tonumber(textBox.Text)
		if soundId then
			local success, info = pcall(function()
				return MarketplaceService:GetProductInfo(soundId)
			end)
			
			if success then
				if info.AssetTypeId == 3 then
					play(soundId, info)
				else
					warnPlr("The entered ID is not an audio asset.")
				end
			else
				warnPlr("Couldn't get info, extra information on console.", info)
			end
		else
			warnPlr("The entered ID is not a number.")
		end
	end)
end
coroutine.wrap(BYNMLN_fake_script)()

--Boombox scripts:

tool.Equipped:Connect(function()
	ChooseSongGui.Enabled = true
end)

tool.Unequipped:Connect(function()
	ChooseSongGui.Enabled = false
end)
