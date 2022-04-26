# Easy-BezierCurve | Version - 1.2.0

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
local BezierCurve = require(Modules.Auxiliary.Math.BezierCurve)
local MiddlePosition1 = BezierCurve.GetMiddlePosition(PlayerWeapon.Position , Target.HumanoidRootPart.Position , 45)

spawn(function()
	BezierCurve.QuadraticBezierCurvesLookAt(25 , 100 , PlayerWeapon , PlayerPositionPart , MiddlePosition1 , Target.HumanoidRootPart)
end)

--This code will move the player's weapon along a curve in the second quadrant for 25 frames

```
### **Made By Aidaren - 究极挨打人**
### **Credit: 老胡家的拖鞋**
### **微信: AidarenADR**
### **Discord: Aidaren#5009**
