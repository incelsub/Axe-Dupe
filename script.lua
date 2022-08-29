-- Dupe Axe by 0x37 --
local Player = game:GetService("Players").LocalPlayer
local Interact = game:GetService("ReplicatedStorage").Interaction.ClientInteracted

function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

function GetFirstTool()
    GetCharacter().Humanoid:UnequipTools()
    for _, Tool in pairs(Player.Backpack:GetChildren()) do
        if Tool.Name ~= "BlueprintTool" then
            return Tool 
        end
    end
    return false, "Unable to find to dupe."
end

function DropTool(Tool, Position)
    local Position = Position or GetCharacter().HumanoidRootPart.CFrame
    Interact:FireServer(Tool, "Drop tool", Position)
end

function DupeTool(Position)
    local Position = Position or GetCharacter().HumanoidRootPart.CFrame
    local DupeTool = GetFirstTool()
    if not DupeTool then
        return false, "Failed to find tool." 
    end
    DupeTool.Parent = GetCharacter()
    DropTool(DupeTool, Position)
    task.wait()
    GetCharacter().Head:Destroy()
    Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")
    task.wait(1)
    GetCharacter().HumanoidRootPart.CFrame = Position
    return true, "Duped successfully!"
end

-- UI Library by Wally --
local Library = loadstring(game:HttpGet("https://pastebin.com/raw/zH17BK2a"))()
local Window = Library:CreateWindow({ text = "Better Dupe Axe" })
local StatusText

Window:AddButton("Dupe Axe", function()
    StatusText.Text = "Status: Duping"
    local success, msg = DupeTool()
    StatusText.Text = "Status: " .. msg
    task.wait(3)
    StatusText.Text = "Status: Waiting"
end)

StatusText = Window:AddLabel("Status: Waiting")
