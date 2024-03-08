local RS = game:GetService("ReplicatedStorage")
local exon = require(RS.Packages.exon)

local oneframe = exon.oneframe

local serverFolder = RS.Shared:WaitForChild("Server")
oneframe.OnStart(serverFolder):andThen(function()
    print("server started!")
end)