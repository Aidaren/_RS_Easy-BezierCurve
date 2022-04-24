--[[
Made By Aidaren / 究极挨打人
Credit: 老胡家的拖鞋

Version - 1.1.0

ContactMe:
WeChat: AidarenADR
Discord: Aidaren#5009
--]]

--<模块>--
local BezierCurve = {}

function BezierCurve.Lerp(Start , End , Time)
	
	return Start + (End - Start) * Time
	
end

function BezierCurve.GetMiddlePosition(StartPosition , TargetPosition , Angle , Offset)
	
	local Vector3Test = Vector3.new(0,0,0)
	
	if typeof(StartPosition) == typeof(Vector3Test) then
		StartPosition = StartPosition
	else
		StartPosition = StartPosition.Position
	end
	
	if typeof(TargetPosition) == typeof(Vector3Test) then
		TargetPosition = TargetPosition
	else
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

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurves(Frame , FPS , Target , Position1 , Position2)
	
	local Vector3Test = Vector3.new(0,0,0)
	
	if typeof(Position1) == typeof(Vector3Test) then
		Position1 = Position1
	else
		Position1 = Position1.Position
	end

	if typeof(Position2) == typeof(Vector3Test) then
		Position2 = Position2
	else
		Position2 = Position2.Position
	end

	for Index = 0 , Frame , 1 do
		
		local Time = Index / Frame
		
		Target.Position = BezierCurve.Lerp(Position1 , Position2 , Time)
		
		task.wait(1 / FPS)
		
	end
	
end

function BezierCurve.QuadraticBezierCurves(Frame , FPS , Target , Position1 , Position2 , Position3)
	
	local Vector3Test = Vector3.new(0,0,0)
	
	if typeof(Position1) == typeof(Vector3Test) then
		Position1 = Position1
	else
		Position1 = Position1.Position
	end

	if typeof(Position2) == typeof(Vector3Test) then
		Position2 = Position2
	else
		Position2 = Position2.Position
	end

	if typeof(Position3) == typeof(Vector3Test) then
		Position3 = Position3
	else
		Position3 = Position3.Position
	end
	
	for Index = 0 , Frame , 1 do
		
		local Time = Index / Frame
		
		local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
		local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)
		
		Target.Position = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)
		
		task.wait(1 / FPS)
		
	end
	
end

function BezierCurve.CubicBezierCurves(Frame , FPS , Target , Position1 , Position2 , Position3 , Position4)
	
	for Index = 0 , Frame , 1 do
		
		local Time = Index / Frame
		
		local Lerp1 = BezierCurve.Lerp(Position1.Position , Position2.Position , Time)
		local Lerp2 = BezierCurve.Lerp(Position2.Position , Position3.Position , Time)
		local Lerp3 = BezierCurve.Lerp(Position3.Position , Position4.Position , Time)
		
		local InLerp1 = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)
		local InLerp2 = BezierCurve.Lerp(Lerp2 , Lerp3 , Time)
		
		Target.Position = BezierCurve.Lerp(InLerp1 , InLerp2 , Time)
		
		task.wait(1 / FPS)
		
	end
	
end

------------------------------|分割线|------------------------------

function BezierCurve.LinearBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2)

	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 0.5
	CFramePart.Size = Vector3.new(1,1,1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	local Vector3Test = Vector3.new(0,0,0)

	if typeof(Position1) == typeof(Vector3Test) then
		Position1 = Position1
	else
		Position1 = Position1.Position
	end
	
	if typeof(Position2) == typeof(Vector3Test) then
		Position2 = Position2
	else
		Position2 = Position2.Position
	end
	
	for Index = 0 , Frame , 1 do
		
		local Time = Index / Frame
		
		CFramePart.Position = BezierCurve.Lerp(Position1 , Position2 , Time)
		
		if Index == 0 then
			continue
		else
			
			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0))
			Target.Position = CFramePart.Position
			
		end
		
		task.wait(1 / FPS)
		
	end
	
end

function BezierCurve.QuadraticBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2 , Position3)


	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 0.5
	CFramePart.Size = Vector3.new(1,1,1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	local Vector3Test = Vector3.new(0,0,0)

	if typeof(Position1) == typeof(Vector3Test) then
		Position1 = Position1
	else
		Position1 = Position1.Position
	end

	if typeof(Position2) == typeof(Vector3Test) then
		Position2 = Position2
	else
		Position2 = Position2.Position
	end

	if typeof(Position3) == typeof(Vector3Test) then
		Position3 = Position3
	else
		Position3 = Position3.Position
	end

	for Index = 0 , Frame , 1 do

		local Time = Index / Frame

		local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
		local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)

		CFramePart.Position = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)

		if Index == 0 then
			continue
		else

			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0))
			Target.Position = CFramePart.Position

		end

		task.wait(1 / FPS)

	end

end

function BezierCurve.CubicBezierCurvesLookAt(Frame , FPS , Target , Position1 , Position2 , Position3 , Position4)


	local CFramePart = Instance.new("Part")
	CFramePart.Parent = Target
	CFramePart.Transparency = 0.5
	CFramePart.Size = Vector3.new(1,1,1)
	CFramePart.Anchored = true
	CFramePart.CanCollide = false

	local Vector3Test = Vector3.new(0,0,0)

	if typeof(Position1) == typeof(Vector3Test) then
		Position1 = Position1
	else
		Position1 = Position1.Position
	end

	if typeof(Position2) == typeof(Vector3Test) then
		Position2 = Position2
	else
		Position2 = Position2.Position
	end

	if typeof(Position3) == typeof(Vector3Test) then
		Position3 = Position3
	else
		Position3 = Position3.Position
	end
	
	if typeof(Position4) == typeof(Vector3Test) then
		Position4 = Position4
	else
		Position4 = Position4.Position
	end

	for Index = 0 , Frame , 1 do
		
		local Time = Index / Frame
		
		local Lerp1 = BezierCurve.Lerp(Position1 , Position2 , Time)
		local Lerp2 = BezierCurve.Lerp(Position2 , Position3 , Time)
		local Lerp3 = BezierCurve.Lerp(Position3 , Position4 , Time)
		
		local InLerp1 = BezierCurve.Lerp(Lerp1 , Lerp2 , Time)
		local InLerp2 = BezierCurve.Lerp(Lerp2 , Lerp3 , Time)
		
		CFramePart.Position = BezierCurve.Lerp(InLerp1 , InLerp2 , Time)
		
		if Index == 0 then
			continue
		else
			
			Target.CFrame = CFrame.lookAt(Target.Position , CFramePart.Position , Vector3.new(0,1,0))
			Target.Position = CFramePart.Position

		end

		task.wait(1 / FPS)

	end

end

return BezierCurve
