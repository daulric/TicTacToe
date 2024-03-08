local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local exon = require(RS.Packages:WaitForChild("exon"))
local oneframe = exon.oneframe
local react = exon.react

local CompileGame = oneframe.Component.create("Compile TTT")

local TTTGame = require(RS.Shared:WaitForChild("TicTacToe"))


function CompileGame:start()
    Players.PlayerAdded:Connect(function(player)
        local mounted

        local element = react.createElement(TTTGame, {
            player = player
        })

        player.CharacterAdded:Connect(function(char)
            print("player added!")

            if mounted == nil then
                mounted = react.mount(element, player.PlayerGui)
            else
                mounted = react.update(mounted, react.createElement(TTTGame, { player = player }) )
            end

        end)

    end)
end

return CompileGame