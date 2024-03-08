local RS = game:GetService("ReplicatedStorage")
local exon = require(RS.Packages.exon)

local oneframe = exon.oneframe

local clientFolder = RS.Shared:WaitForChild("Client")
oneframe.OnStart(clientFolder):andThen(function()
    print("client started!")
end)