local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local commands = {"move forward", "move backward", "move left", "move right", "jump", "loop forward", "loop backward", "forward jump", "backward jump", "left jump", "right jump", "stop"}
local UserInputService = game:GetService("UserInputService")
local event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
local moving = false

local function Say(msg)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
end

function getChat(msg, target)
    print(msg)
    for i, command in ipairs(commands) do
        print("starting for loop")
        if msg == command then
            if command == "move forward" then
                task.wait(0.1)
                print("picked up command: move forward")
                Say("Moving forward.")
                Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
            elseif command == "move backward" then
                task.wait(0.1)
                print("picked up command: move backward")
                Say("Moving backward.")
                Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
            elseif command == "move left" then
                task.wait(0.1)
                print("picked up command: move left")
                Say("Moving left.")
                Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.CFrame.rightVector * 10)
            elseif command == "move right" then
                task.wait(0.1)
                print("picked up command: move right")
                Say("Moving right.")
                Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.rightVector * 10)
            elseif command == "jump" then
                local humanoid = Player.Character:FindFirstChild("Humanoid")
                task.wait(0.1)
                print("picked up command: jump")
                Say("Jumping.")
                humanoid:ChangeState("Jumping")
                humanoid.Jump = true
            elseif command == "loop forward" then
                task.wait(0.1)
                print("picked up command: loop forward")
                Say("Moving forward. Say stop to stop moving.")
				moving = true
				repeat
					Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
					task.wait(0.5)
				until
					moving == false
			elseif command == "loop backward" then
                task.wait(0.1)
                print("picked up command: loop backward")
                Say("Moving forward. Say stop to stop moving.")
				moving = true
				Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
				task.wait(0.5)
				repeat
					Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
					task.wait(0.5)
				until
					moving == false
			elseif command == "forward jump" then
				local humanoid = Player.Character:FindFirstChild("Humanoid")
				task.wait(0.1)
                print("picked up command: forward jump")
				Say("Jumping forward.")
				Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
				task.wait(0.05)
				humanoid:ChangeState("Jumping")
                humanoid.Jump = true
            elseif command == "backward jump" then
            	local humanoid = Player.Character:FindFirstChild("Humanoid")
				task.wait(0.1)
                print("picked up command: backward jump")
				Say("Jumping backward.")
				Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.CFrame.lookVector * 10)
				task.wait(0.05)
				humanoid:ChangeState("Jumping")
                humanoid.Jump = true
            elseif command == "left jump" then
            	local humanoid = Player.Character:FindFirstChild("Humanoid")
				task.wait(0.1)
                print("picked up command: left jump")
				Say("Jumping left.")
				Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.CFrame.rightVector * 10)
				task.wait(0.05)
				humanoid:ChangeState("Jumping")
                humanoid.Jump = true
            elseif command == "right jump" then
            	local humanoid = Player.Character:FindFirstChild("Humanoid")
				task.wait(0.1)
                print("picked up command: right jump")
				Say("Jumping right.")
				Player.Character.Humanoid:MoveTo(Player.Character.HumanoidRootPart.Position + Player.Character.HumanoidRootPart.CFrame.rightVector * 10)
				task.wait(0.05)
				humanoid:ChangeState("Jumping")
                humanoid.Jump = true
			elseif command == "stop" then
                task.wait(0.1)
                print("picked up command: stop")
                if moving == true then
					moving = false
					Say("Stopping.")
				else
					moving = false
					Say("Not currently looping.")
				end
			end
        end
    end
end

local function initialize(char)
    char = Player.Character or Player.CharacterAdded:Wait()
    local chatConnection

    if chatConnection then
        chatConnection:Disconnect()
    end

    chatConnection = event.OnMessageDoneFiltering.OnClientEvent:Connect(function(object)
        getChat(object.Message, char)
    end)

    char.AncestryChanged:Connect(function(_, parent)
        if parent == nil then
            chatConnection:Disconnect()
        end
    end)
end

initialize()
Say("Bot Initialized. Say one of the following commands: move forward, move backward, move left, move right, jump, loop forward, loop backward, forward jump, backward jump, left jump, right jump.")

Player.CharacterAdded:Connect(function(character)
    char = character
    initialize(char)
end)