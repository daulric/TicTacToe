local RS = game:GetService("ReplicatedStorage")
local exon = require(RS.Packages:WaitForChild("exon"))
local util = exon.util

local counter = util.createCounter

local react = exon.react

local CellFrame = react.Component:extend("Cell Frame")
local Cell = require(script.Parent:WaitForChild("Cell"))

function CellFrame:init()
    self.state = { Cells = {} }
    self.player1turn, self.updateTurn = react.createBinding(true)
    self.text, self.updateText = react.createBinding("TicTacToe")
    self.debounce = false

    self.frame = react.createRef()

    counter(1, 9, 1, function(i)

        self:setState(function(state)
            local element = react.createElement(Cell, {
                name = i,
                clicked = function(element)
                    if element.Text == "" then

                        if self.player1turn:getValue() == true then
                            element.TextColor3 = Color3.fromRGB(51, 56, 215)
                            element.Text = "X"
                            self.updateTurn(false)
                            self.updateText("O Turn")
                            self:check()
                        elseif self.player1turn:getValue() == false then
                            element.TextColor3 = Color3.fromRGB(109, 36, 36)
                            element.Text = "O"
                            self.updateTurn(true)
                            self.updateText("X Turn")
                            self:check()
                        end
                    end
                end
            })

            table.insert(state.Cells, element)
        end)

    end)

    self.updateText("X Turn")
end


function CellFrame:XWins(a, b, c)
    local frame: Frame = self.frame:getValue()
    local button1: TextButton = frame:WaitForChild("Cell "..a)
    local button2: TextButton = frame:WaitForChild("Cell "..b)
    local button3: TextButton = frame:WaitForChild("Cell "..c)

    button1.BackgroundColor3 = Color3.fromRGB(41, 223, 243)
    button2.BackgroundColor3 = Color3.fromRGB(41, 223, 243)
    button3.BackgroundColor3 = Color3.fromRGB(41, 223, 243)

    counter(1, 9, 1, function(i)
        if i ~= a and i ~= b and i ~= c then
            local button =  frame:WaitForChild("Cell "..i)
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    self.updateText("X Wins")
    self.debounce = true
    task.wait(3)
    local player:Player = self.props.player
    player.Character:WaitForChild("Humanoid").Health = 0
end

function CellFrame:OWins(a, b, c)
    local frame: Frame = self.frame:getValue()
    local button1: TextButton = frame:WaitForChild("Cell "..a)
    local button2: TextButton = frame:WaitForChild("Cell "..b)
    local button3: TextButton = frame:WaitForChild("Cell "..c)

    button1.BackgroundColor3 = Color3.fromRGB(158, 41, 35)
    button2.BackgroundColor3 = Color3.fromRGB(158, 41, 35)
    button3.BackgroundColor3 = Color3.fromRGB(158, 41, 35)

    counter(1, 9, 1, function(i)
        if i ~= a and i ~= b and i ~= c then
            local button =  frame:WaitForChild("Cell "..i)
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end)

    self.updateText("O Wins")
    self.debounce = true
    task.wait(3)
    local player:Player = self.props.player
    player.Character:WaitForChild("Humanoid").Health = 0

end

function CellFrame:checkbtn(a, val)
    return self.frame:getValue():WaitForChild("Cell "..a).Text == val
end

function CellFrame:CheckTie()
    local frame: Frame = self.frame:getValue()
    return (frame:WaitForChild("Cell 1").Text ~= "" and 
            frame:WaitForChild("Cell 2").Text ~= ""and 
            frame:WaitForChild("Cell 3").Text ~= "" and 
            frame:WaitForChild("Cell 4").Text ~= "" and
            frame:WaitForChild("Cell 5").Text ~= "" and
            frame:WaitForChild("Cell 6").Text ~= "" and 
            frame:WaitForChild("Cell 7").Text ~= "" and 
            frame:WaitForChild("Cell 8").Text ~= "" and 
            frame:WaitForChild("Cell 9").Text ~= ""
        )
end

function CellFrame:check()
    -- X Wins
    if self:checkbtn(1, "X") and self:checkbtn(2, "X") and self:checkbtn(3, "X") then
        self:XWins(1, 2, 3)
    end
    if self:checkbtn(4, "X") and self:checkbtn(5, "X") and self:checkbtn(6, "X") then
        self:XWins(4, 5, 6)
    end
    if self:checkbtn(7, "X") and self:checkbtn(8, "X") and self:checkbtn(9, "X") then
        self:XWins(7,8,9)
    end
    if self:checkbtn(1, "X") and self:checkbtn(4, "X") and self:checkbtn(7, "X") then
        self:XWins(1, 4, 7)
    end
    if self:checkbtn(2, "X") and self:checkbtn(5, "X") and self:checkbtn(8, "X") then
        self:XWins(2, 5, 8)
    end
    if self:checkbtn(3, "X") and self:checkbtn(6, "X") and self:checkbtn(9, "X") then
        self:XWins(3, 6, 9)
    end
    if self:checkbtn(1, "X") and self:checkbtn(5, "X") and self:checkbtn(9, "X") then
        self:XWins(1, 5, 9)
    end
    if self:checkbtn(3, "X") and self:checkbtn(5, "X") and self:checkbtn(7, "X") then
        self:XWins(3, 5, 7)
    end

    -- OWins
    if self:checkbtn(1, "O") and self:checkbtn(2, "O") and self:checkbtn(3, "O") then
        self:OWins(1, 2, 3)
    end
    if self:checkbtn(4, "O") and self:checkbtn(5, "O") and self:checkbtn(6, "O") then
        self:OWins(4, 5, 6)
    end
    if self:checkbtn(7, "O") and self:checkbtn(8, "O") and self:checkbtn(9, "O") then
        self:OWins(7,8,8)
    end
    if self:checkbtn(1, "O") and self:checkbtn(4, "O") and self:checkbtn(7, "O") then
        self:OWins(1, 4, 7)
    end
    if self:checkbtn(2, "O") and self:checkbtn(5, "O") and self:checkbtn(8, "O") then
        self:OWins(2, 5, 8)
    end
    if self:checkbtn(3, "O") and self:checkbtn(6, "O") and self:checkbtn(9, "O") then
        self:OWins(3, 6, 9)
    end
    if self:checkbtn(1, "O") and self:checkbtn(5, "O") and self:checkbtn(9, "O") then
        self:OWins(1, 5, 9)
    end
    if self:checkbtn(3, "O") and self:checkbtn(5, "O") and self:checkbtn(7, "O") then
        self:OWins(3, 5, 7)
    end

    if self:CheckTie() then
        if self.debounce == false then
            self.updateText("Its a Tie")
            task.wait(3)
            local player:Player = self.props.player
            player.Character:WaitForChild("Humanoid").Health = 0
        end
    end

end

function CellFrame:didMount()
    print(self.state.Cells)
end

function CellFrame:willUnmount()
    self:setState(nil)
    self.props = {}
end

function CellFrame:render()

    return react.createElement("Frame", {
        Name = "Cell Frame Cover",
        Size = UDim2.new(0.507, 0,0.846, 0),
        Position = UDim2.new(0.246, 0,0.076, 0),
    }, {

        TextLabel = react.createElement("TextLabel", {
            Name = "TextLabel",
            Text = self.text:map(function(value)
                return value
            end),

            TextColor3 = Color3.fromRGB(67, 67, 67),
            Font = Enum.Font.Cartoon,
            TextScaled = true,
            Size = UDim2.new(1, 0, 0.114, 0),
            BackgroundTransparency = 1,
        }),

        CellFrame = react.createElement("Frame", {
            Name = "Cell Frame",
            [react.Ref] = self.frame,
            Position = UDim2.new(0.071, 0,0.115, 0),
            Size = UDim2.new(0.856, 0,0.86, 0)
        }, react.Children, {
            UICorner = react.createElement("UICorner", {
                Name = "Corner",
                CornerRadius = UDim.new(0, 5),
            }),

            UIAspectContrainant = react.createElement("UIAspectRatioConstraint", {
                Name = "Scaler"
            }),
    
            GridLayout = react.createElement("UIGridLayout", {
                Name = "GridLayout",
                CellPadding = UDim2.new(0, 5, 0, 5),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            }),

            ChildCells = react.createFragment(self.state.Cells)
        }),

        UIAspectContrainant = react.createElement("UIAspectRatioConstraint", {
            Name = "Scaler"
        }),

    })
end

return CellFrame