# Easy-BezierCurve | Version - 2.0.0

## 中文简介/Chinese Language
**这个模块有什么用？   
此模块可以支持您快捷地创建贝塞尔曲线，并支持将目标物体的朝向变为曲线轨迹朝向！**
### **脚本功能：**
* **便捷地创建贝塞尔曲线**
* **使目标物体朝向为曲线轨迹**
* **获取使曲线曲率趋近于圆周率的P2点三维坐标**
* **更多功能正处于开发中**

## 英文简介/English Language
**What is the use of this module?    
This module allows you to quickly create Bezier curves and to change the orientation of the target object to the orientation of the curve trajectory**
### **Script Feature:**
* **Creating Bezier curves easily**
* **Orient the target object to a curved trajectory**
* **Obtain the three-dimensional coordinates of the point P2 which makes the curvature of the curve converge to the circumference**
* **More features are under development**

## Example Code
```lua 
local Bezier = require(ReplicatedStorage.Utils.BezierCurve)
	local Player = game:GetService("Players").LocalPlayer
	local PlayerCharacter = Player.Character
	local HumanoidRootPart = PlayerCharacter:FindFirstChild("HumanoidRootPart")

	--<获得配置表>--
	local Elasped = 0
	local Connection
	local Start = HumanoidRootPart.Position
	local End = HumanoidRootPart.Position + Vector3.new(10, 0, 0) --<向X轴运动10个单位>--
	local MidPoint = (Start:Lerp(End, 0.33)) + Vector3.new(0, 10, 0) --<将中间点设为两点间中点向上10个单位>--
	local CurveTime = 10 --<总运动时间>--
	local TweenTime = Instance.new("NumberValue")
	TweenTime.Parent = PlayerCharacter
	TweenTime.Value = 0

	game:GetService("TweenService")
		:Create(TweenTime, TweenInfo.new(CurveTime, Enum.EasingStyle.Quart), { Value = CurveTime })
		:Play()

	--<跳跃曲线控制>--
	Connection = game:GetService("RunService").Heartbeat:Connect(function(Delta)
		Elasped += Delta

		local Time = TweenTime.Value * (1 / CurveTime)
		local Curve = Bezier.QuadraticBezierCurves(Time, Start, MidPoint, End)

		if TweenTime.Value >= CurveTime then
			warn("Exceed max time")
			Connection:Disconnect()
			PlayerCharacter:PivotTo(
				CFrame.new(End)
					* CFrame.Angles(
						math.rad(HumanoidRootPart.Orientation.X),
						math.rad(HumanoidRootPart.Orientation.Y),
						math.rad(HumanoidRootPart.Orientation.Z)
					)
			)
			TweenTime:Destroy()
		else
			PlayerCharacter:PivotTo(
				CFrame.new(Curve)
					* CFrame.Angles(
						math.rad(HumanoidRootPart.Orientation.X),
						math.rad(HumanoidRootPart.Orientation.Y),
						math.rad(HumanoidRootPart.Orientation.Z)
					)
			)
		end
	end)

```
### **Made By Aidaren - 究极挨打人**
### **Credits: 老胡家的拖鞋 / 枫**
### **微信: AidarenADR**
### **Discord: Aidaren#5009**
