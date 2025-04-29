-- This script attempts to disable or "kill" specific GUI folders in Roblox
-- Note: Many of these are protected core GUIs that cannot be modified by normal scripts

local function disableFolder(folderName)
    local success, result = pcall(function()
        -- Try to find the folder in different parent locations
        local parentLocations = {
            game:GetService("CoreGui"),
            game:GetService("StarterGui"),
            game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        }
        
        for _, parent in ipairs(parentLocations) do
            local folder = parent:FindFirstChild(folderName)
            if folder then
                folder:Destroy()
                return true
            end
        end
        return false
    end)
    
    if not success then
        warn("Failed to disable folder "..folderName..": "..tostring(result))
        return false
    end
    return result
end

-- List of folders to attempt to disable
local foldersToDisable = {
    "FLags",
    "GetFFlagPauseMuteFix",
    "NetworkPauseNotification",
    "Corescripts/NetworkPause",
    "RobloxNetworkPauseNotification"
}

-- Run the disabler in a loop with delays
while true do
    for _, folderName in ipairs(foldersToDisable) do
        disableFolder(folderName)
    end
    wait(1) -- Check every second
end
