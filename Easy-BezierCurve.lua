--[[
Made By Aidaren / 究极挨打人
Credit: 老胡家的拖鞋

Version - 1.0.0

ContactMe:
WeChat: AidarenADR
Discord: Aidaren#5009
--]]

--<模块>--
local BezierCurve = {}

function BezierCurve.Lerp(Start , End , Time)
	
	return Start + (End - Start) * Time
	
end

function BezierCurve.GetMiddlePosition1(Start , End)

	local NewVector3 = (Start - End) * 0.5 --一半长度的向量
	local MiddleV3 = Start - NewVector3 --居中向量
	local startYzero = Vector3.new(Start.X,0,Start.Z)
	local endYzero = Vector3.new(End.X,0,End.Z)

	local CrossV3Unit = startYzero:Cross(endYzero).Unit
	local FinalVector3 = MiddleV3 - CrossV3Unit * NewVector3.Magnitude

	if FinalVector3.Y < 0 then

		FinalVector3 = MiddleV3 + CrossV3Unit * NewVector3.Magnitude

	end
	return FinalVector3

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
