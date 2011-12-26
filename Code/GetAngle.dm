proc/GetAngle(var/atom/A1,var/atom/A2)
	var/dx=A2.x-A1.x
	var/dy=A2.y-A1.y
	var/Angle=(dy>=0)?(arccos(dx/sqrt(dx*dx+dy*dy))):(-arccos(dx/sqrt(dx*dx+dy*dy)))
	if(Angle<1)	Angle=360+Angle
	return Angle

var/list/CloseScreenLocAngles=list("1"="9,8","2"="9,10","4"="10,9","8"="8,9","5"="10,10","6"="10,8","9"="8,10","10"="8,8")

var/list/AngleHUDs=list()
obj/Supplemental/AngleHUD
	var/Angle
	New()
		src.Angle=GetAngle(locate(9,9,1),src)
		src.screen_loc="[src.x],[src.y]"
		AngleHUDs+=src
		src.loc=null