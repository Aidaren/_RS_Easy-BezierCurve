--[[
Made By Aidaren / 究极挨打人
Credits:
老胡家的拖鞋
枫

Version - 1.3.1

ContactMe:
WeChat: AidarenADR
Discord: Aidaren#5009
--]]

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

--<模块>--
local BezierCurve = {}

function BezierCurve.Lerp(Start , End , Time)

	if typeof(Start) ~= "Vector3" then
		Start = Start.Position
	end

	if typeof(End) ~= "Vector3" then
		End = End.Position
	end

	return Start + (End - Start) * Time

end

function BezierCurve.GetFrameByDistance(Start , End , Multiply)

	if typeof(Start) ~= "Vector3" then
		Start = Start.Position
	end

	if typeof(End) ~= "Vector3" then
		End = End.Position
	end

	if not Multiply then
		Multiply = 1
	else
		Multiply = 1 + Multiply
	end

	local Distance = (Start - End).Magnitude--旋转半径
	local Frame = math.round(Distance * 2 / Multiply)

	return Frame

end

function BezierCurve.GetMotionTime(Frame , FPS)
	local Time = 0

	Time += task.wait(1 / FPS) * Frame

	return Time
end

function BezierCurve.GetMiddlePosition(StartPosition , TargetPosition , Angle , Offset)

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
	local RotateCFrame = CFrame.new(MiddlePosition,TargetPosition) --从起始与目标之间的中心点指向目标的向量,用此向量进行旋转

	RotateCFrame = RotateCFrame * CFrame.Angles(0,0,math.rad(Angle)) --根据角度旋转此向量
	local Radius = HalfVector3.Magnitude * Offset--旋转半径

	local ResultPosition = MiddlePosition + RotateCFrame.UpVector * Radius --中间位置 + 旋转后的上朝向 * 半径

	return ResultPosition

end

function BezierCurve.Get2MiddlePosition(StartPosition , TargetPosition , Angle1 , Offset1 , Angle2 , Offset2)

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

	local function GetResultPosition(StartPosition , TargetPosition , Angle , Offset , Length)

		local HalfVector3 = (StartPosition - TargetPosition) * Length --起始与目标之间三分之一长度的向量
		local MiddlePosition = StartPosition - HalfVector3 --中间位置点
		local RotateCFrame = CFrame.new(MiddlePosition,TargetPosition) --从起始与目标之间的中心点指向目标的向量,用此向量进行旋转

		RotateCFrame = RotateCFrame * CFrame.Angles(0,0,math.rad(Angle)) --根据角度旋转此向量
		local Radius = HalfVector3.Magnitude * Offset--旋转半径

		local ResultPosition = MiddlePosition + RotateCFrame.UpVector * Radius --中间位置 + 旋转后的上朝向 * 半径

		return ResultPosition

	end

	local ResultPosition1 = GetResultPosition(StartPosition , TargetPosition , Angle1 , Offset1 , 1/3)
	local ResultPosition2 = GetResultPosition(StartPosition , TargetPosition , Angle2 , Offset2 , 1/3 * 2)

	return ResultPosition1 , ResultPosition2

end

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurves(Frame , FPS , Target , Position1 , Position2)

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event 
	Event = RunService.Heartbeat:Connect(function(DeltaTime)

		TotalTime += DeltaTime

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			Target.Position = BezierCurve.Lerp(Position1 , Position2 , Time)

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)

end

function BezierCurve.QuadraticBezierCurves(Frame , FPS , Target , Position1 , Position2 , Position3)

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	if typeof(Position3) ~= "Vector3" then
		Position3 = Position3.Position
	end

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event 
	Event = RunService.Heartbeat:Connect(function(DT)

		TotalTime += DT

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
			local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)

			Target.Position = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)

end

function BezierCurve.CubicBezierCurves(Frame , FPS , Target , Position1:Vector3 , Position2 , Position3 , Position4)

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

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event 
	Event = RunService.Heartbeat:Connect(function(DeltaTime)

		TotalTime += DeltaTime

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
			local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)
			local Lerp3 = BezierCurve.Lerp(Position3 , Position4 , Time)

			local InLerp1 = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)
			local InLerp2 = BezierCurve.Lerp(Lerp2 , Lerp3 , Time)

			Target.Position = BezierCurve.Lerp(InLerp1 , InLerp2 , Time)

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)

end

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2 , CFrameOffset)

	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(1,1,1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	if typeof(Position1) ~= "Vector3" then
		Position1 = Position1.Position
	end

	if typeof(Position2) ~= "Vector3" then
		Position2 = Position2.Position
	end

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event
	Event = RunService.Heartbeat:Connect(function(DeltaTime)

		TotalTime += DeltaTime

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			CFramePart.Position = BezierCurve.Lerp(Position1 , Position2 , Time)

			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0)) * CFrameOffset
			Target.Position = CFramePart.Position

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)

	Debris:AddItem(CFramePart , task.wait())

end

function BezierCurve.QuadraticBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2 , Position3 , CFrameOffset)


	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(1,1,1)
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

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event
	Event = RunService.Heartbeat:Connect(function(DeltaTime)

		TotalTime += DeltaTime

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
			local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)

			CFramePart.Position = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)

			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0)) * CFrameOffset
			Target.Position = CFramePart.Position

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)

	Debris:AddItem(CFramePart , task.wait())

end

function BezierCurve.CubicBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2 , Position3 , Position4 , CFrameOffset)


	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 1
	CFramePart.Size = Vector3.new(1,1,1)
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

	local Index = 0
	local DeltaTime = 1 / FPS
	local TotalTime = 0

	local Event
	Event = RunService.Heartbeat:Connect(function(DeltaTime)

		TotalTime += DeltaTime

		if TotalTime < Index * DeltaTime then
			return
		end

		if TotalTime >= Index * DeltaTime then

			Index += 1

			local Time = Index / Frame

			local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
			local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)
			local Lerp3 = BezierCurve.Lerp(Position3 , Position4 , Time)

			local InLerp1 = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)
			local InLerp2 = BezierCurve.Lerp(Lerp2 , Lerp3 , Time)

			CFramePart.Position = BezierCurve.Lerp(InLerp1 , InLerp2 , Time)

			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0)) * CFrameOffset
			Target.Position = CFramePart.Position

		end

		if Index >= Frame then
			Event:Disconnect()
		end

	end)


	Debris:AddItem(CFramePart , task.wait())

end

return BezierCurve
