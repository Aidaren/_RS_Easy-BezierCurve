# Easy-BezierCurve | Version - 1.3.1

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
-- PlayerWeapon = P1
-- Target = P3
-- 45 = The angle offset of the P2

spawn(function()
	BezierCurve.QuadraticBezierCurvesLookAt(25 , 100 , PlayerWeapon , PlayerPositionPart , MiddlePosition1 , Target.HumanoidRootPart)
	-- 25 = Frame on your path, more frame mean more smoother animation but slower play speed
	-- 100 = FPS: Frame per second, but if fps is bigger than 17, it's will not be more faster, try to reduce your frame
	-- PlayerWeapon = The thing that will follow the path move, or like ↓
	-- The Projectile that will follow the beizer path (e.g a fireball)
	-- playerPositionPart = Where the curve begin
	-- MiddlePosition1 = The P2 (Curvature) that will change your curve's curvature
	-- Target = Where the curve end
end)

--This code will move the player's weapon along a curve in the second quadrant for 25 frames

```
### **Made By Aidaren - 究极挨打人**
### **Credits: 老胡家的拖鞋 / 枫**
### **微信: AidarenADR**
### **Discord: Aidaren#5009**
