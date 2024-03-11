local RS = game:GetService("ReplicatedStorage")
local exon = require(RS.Packages.exon)

local react = exon.react

local CellComponent = react.Component:extend("Cell")

function CellComponent:init()
    self.cell, self.updateCell = react.createBinding("")
    self.color, self.updateColor = react.createBinding(Color3.fromRGB(0, 0, 0)) 
end

function CellComponent:willUnmount()
    self:setState(nil)
    self.props = {}
end

function CellComponent:render()
    return react.createElement("TextButton", {
        Name = "Cell "..self.props.name,
        TextScaled = true,
        Size = UDim2.fromScale(200, 200),
        BackgroundColor3 = Color3.fromRGB(45, 44, 44),

        [react.Event.MouseButton1Click] = self.props.clicked,

        Text = self.cell:map(function(value)
            return value
        end),

        TextColor3 = self.color:map(function(value)
            return value
        end)
    }, {
      UICorner = react.createElement("UICorner", {
        Name = "Corner",
        CornerRadius = UDim.new(0, 2),
      }),
    })
end

return CellComponent