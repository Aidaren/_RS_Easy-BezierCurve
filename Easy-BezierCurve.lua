--# selene: allow(unused_variable , shadowing , manual_table_clone , parenthese_conditions , multiple_statements , deprecated , incorrect_standard_library_use , roblox_incorrect_color3_new_bounds , empty_if , if_same_then_else)
--[[
Made By Aidaren / 究极挨打人
Credits:
老胡家的拖鞋
枫

Version - 2.0.0

ContactMe:
WeChat: AidarenADR
Discord: Aidaren#5009
--]]

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

--<模块>--
local BezierCurve = {}

function BezierCurve.Lerp(Start, End, Time)
	if typeof(Start) ~= "Vector3" then
		Start = Start.Position
	end

	if typeof(End) ~= "Vector3" then
		End = End.Position
	end

	return Start + (End - Start) * Time
end

function BezierCurve.GetMiddlePosition(StartPosition, TargetPosition, Angle, Offset)
	if typeof(StartPosition) ~= "Vector3" then
		StartPosition = StartPosition.Position
	end

	if typeof(TargetPosition) ~= "Vector3" then
		TargetPosition = TargetPosition.Position
	end

	if not Angle then
		Angle = 0
	end

	if not Offset then
		Offset = 1
	else
		Offset = 1 + Offset
	end

	local HalfVector3 = (StartPosition - TargetPosition) * 0.5 --起始与目标之间一半长度的向量
	local MiddlePosition = StartPosition - HalfVector3 --中间位置点
	local RotateCFrame = CFrame.new(MiddlePosition, TargetPosition) --从起始与目标之间的中心点指向目标的向量,用此向量进行旋转

	RotateCFrame = RotateCFrame * CFrame.Angles(0, 0, math.rad(Angle)) --根据角度旋转此向量
	local Radius = HalfVector3.Magnitude * Offset --旋转半径

	local ResultPosition = MiddlePosition + RotateCFrame.UpVector * Radius --中间位置 + 旋转后的上朝向 * 半径

	return ResultPosition
end

function BezierCurve.Get2MiddlePosition(StartPosition, TargetPosition, Angle1, Offset1, Angle2, Offset2)
	if typeof(StartPosition) ~= "Vector3" then
		StartPosition = StartPosition.Position
	end

	if typeof(TargetPosition) ~= "Vector3" then
		TargetPosition = TargetPosition.Position
	end

	if not Angle1 then
		Angle1 = 0
	end

	if not Angle2 then
		Angle2 = 0
	end

	if not Offset1 then
		Offset1 = 1
	else
		Offset1 = 1 + Offset1
	end

	if not Offset2 then
		Offset2 = 1
	else
		Offset2 = 1 + Offset2
	end

	local function GetResultPosition(StartPosition, TargetPosition, Angle, Offset, Length)
		local HalfVector3 = (StartPosition - TargetPosition) * Length --起始与目标之间三分之一长度的向量
		local MiddlePosition = StartPosition - HalfVector3 --中间位置点
		local RotateCFrame = CFrame.new(MiddlePosition, TargetPosition) --从起始与目标之间的中心点指向目标的向量,用此向量进行旋转

		RotateCFrame = RotateCFrame * CFrame.Angles(0, 0, math.rad(Angle)) --根据角度旋转此向量
		local Radius = HalfVector3.Magnitude * Offset --旋转半径

		local ResultPosition = MiddlePosition + RotateCFrame.UpVector * Radius --中间位置 + 旋转后的上朝向 * 半径
	end

	local ResultPosition1 = GetResultPosition(StartPosition, TargetPosition, Angle1, Offset1, 1 / 3)
	local ResultPosition2 = GetResultPosition(StartPosition, TargetPosition, Angle2, Offset2, 1 / 3 * 2)

	return ResultPosition1, ResultPosition2
end

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurves(Time, Position1, Position2)
	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	return BezierCurve.Lerp(Position1, Position2, Time)
end

function BezierCurve.QuadraticBezierCurves(Time, Position1, Position2, Position3)
	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	if typeof(Position3) ~= "Vector3" then
		Position3 = Position3.Position
	end

	local Lerp1 = BezierCurve.Lerp(Position1, Position2, Time)
	local Lerp2 = BezierCurve.Lerp(Position2, Position3, Time)

	return BezierCurve.Lerp(Lerp1, Lerp2, Time)
end

function BezierCurve.CubicBezierCurves(Time, Position1: Vector3, Position2, Position3, Position4)
	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	if typeof(Position3) ~= "Vector3" then
		Position3 = Position3.Position
	end

	if typeof(Position4) ~= "Vector3" then
		Position4 = Position4.Position
	end

	local Lerp1 = BezierCurve.Lerp(Position1, Position2, Time)
	local Lerp2 = BezierCurve.Lerp(Position2, Position3, Time)
	local Lerp3 = BezierCurve.Lerp(Position3, Position4, Time)

	local InLerp1 = BezierCurve.Lerp(Lerp1, Lerp2, Time)
	local InLerp2 = BezierCurve.Lerp(Lerp2, Lerp3, Time)

	return BezierCurve.Lerp(InLerp1, InLerp2, Time)
end

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurvesLookAt(Time, Target, Position1, Position2, CFrameOffset)
	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(1, 1, 1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	CFramePart.Position = BezierCurve.Lerp(Position1, Position2, Time)

	if CFrameOffset then
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0)) * CFrameOffset
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	else
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0)) * CFrameOffset
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	end
end

function BezierCurve.QuadraticBezierCurvesLookAt(Time, Target, Position1, Position2, Position3, CFrameOffset)
	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(0.1, 0.1, 0.1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	if typeof(Position3) ~= "Vector3" then
		Position3 = Position3.Position
	end

	local Lerp1 = BezierCurve.Lerp(Position1, Position2, Time)
	local Lerp2 = BezierCurve.Lerp(Position2, Position3, Time)
	CFramePart.Position = BezierCurve.Lerp(Lerp1, Lerp2, Time)

	if CFrameOffset then
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0)) * CFrameOffset
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	else
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0))
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	end
end

function BezierCurve.CubicBezierCurvesLookAt(Time, Target, Position1, Position2, Position3, Position4, CFrameOffset)
	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(1, 1, 1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	if typeof(Position3) ~= "Vector3" then
		Position3 = Position3.Position
	end

	if typeof(Position4) ~= "Vector3" then
		Position4 = Position4.Position
	end

	local Lerp1 = BezierCurve.Lerp(Position1, Position2, Time)
	local Lerp2 = BezierCurve.Lerp(Position2, Position3, Time)
	CFramePart.Position = BezierCurve.Lerp(Lerp1, Lerp2, Time)

	local Lerp1 = BezierCurve.Lerp(Position1, Position2, Time)
	local Lerp2 = BezierCurve.Lerp(Position2, Position3, Time)
	local Lerp3 = BezierCurve.Lerp(Position3, Position4, Time)

	local InLerp1 = BezierCurve.Lerp(Lerp1, Lerp2, Time)
	local InLerp2 = BezierCurve.Lerp(Lerp2, Lerp3, Time)

	CFramePart.Position = BezierCurve.Lerp(InLerp1, InLerp2, Time)

	if CFrameOffset then
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0)) * CFrameOffset
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	else
		local TargetCFrame = CFrame.lookAt(Target.Position, CFramePart.Position, Vector3.new(0, 1, 0))
		local TargetPosition = CFramePart.Position

		Debris:AddItem(CFramePart, task.wait())

		return TargetCFrame, TargetPosition
	end
end

return BezierCurve
