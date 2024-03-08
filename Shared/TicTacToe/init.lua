local RS = game:GetService("ReplicatedStorage")
local exon = require(RS.Packages.exon)

local react = exon.react

local TTT = react.Component:extend("TicTacToe")
local CellFrame = require(script:WaitForChild("CellFrame"))

function TTT:render()
    return react.createElement("ScreenGui", {
        Name = "TicTacToe Frame",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
    }, react.Children, {
        CellFrame = react.createElement(CellFrame, {
            player = self.props.player,
        }),
    })
end

return TTT