var/list/BanList=list()
var/list/MuteList=list()
mob/GM/verb
	Ban()
		set category="GM"
		var/list/L=list()
		for(var/mob/M in world)	if(M.client)	L+=M
		var/mob/M=input("Select Player to Ban","Ban Player") as null|anything in L
		if(!M || !M.client || M==usr)	return
		if(!BanList)	BanList=list()
		BanList+=M.key;BanList+=M.client.address
		world<<"[M] has been Banned by [usr]"
		del M.client
	UnBan()
		set category="GM"
		var/M=input("Select Player to UnBan","UnBan Player") as null|anything in BanList
		if(!M)	return
		BanList-=M;usr<<"[M] has been UnBanned"
	Mute()
		set category="GM"
		var/list/L=list()
		for(var/mob/M in world)	if(M.client)	L+=M
		var/mob/M=input("Select Player to Mute","Mute Player") as null|anything in L
		if(!M || !M.client || usr==M)	return
		if(!MuteList)	MuteList=list()
		MuteList+=M.key;MuteList+=M.client.address
		world<<"[M] has been Muted by [usr]"
	UnMute()
		set category="GM"
		var/M=input("Select Player to UnMute","UnMute Player") as null|anything in MuteList
		if(!M)	return
		MuteList-=M;usr<<"[M] has been UnMuted"
	Host()
		set category="GM"
		winset(src,,"command=.host")
	Player_Limit()
		set category="GM"
		global.PlayerLimit=round(input("Input Player Limit","Input Player Limit",global.PlayerLimit) as num)
		src<<"Player Limit set to [global.PlayerLimit].  Setting does not Save!"
	Add_Popup()
		set category="GM"
		src.verbs+=typesof(/mob/GM/RightClick/verb)
	Remove_Popup()
		set category="GM"
		src.verbs-=typesof(/mob/GM/RightClick/verb)
	Watch_Player()
		set category="GM"
		if(src.client.eye!=src)	{src.client.eye=src;return}
		var/mob/M=input("Select the Player to Spy On","Watch Player") as anything in Players
		if(M)	usr.client.eye=M
		if(M.FusionMob)	usr.client.eye=M.FusionMob
	Download_LogFile()
		set category="GM"
		usr<<ftp(file("LogFile.txt"))
	Play_Music()
		set category="GM"
		var/F=input("Select midi or .wav to Play","Play Music") as null|file
		if(F)
			world<<"<b>* [usr] is Playing: [F]"
			world<<sound(null)
			world<<sound(F)
		else	world<<sound(null)
	Get_DragonBalls()
		set category="GM"
		for(var/obj/Items/DragonBalls/B in world)	B.loc=usr.loc
		usr<<"DragonBalls Summoned"
	Refresh_Fonts()
		set category="GM"
		LoadRestrictedFonts(0)
	Refresh_Subs()
		set category="GM"
		LoadSubs(0)
	Refresh_Points()
		set category="GM"
		LoadCashPointPurchases(0)
	Refresh_Bans()
		set category="GM"
		LoadGlobalBans(0)
	Refresh_Mutes()
		set category="GM"
	Refresh_Offensive_Words()
		set category="GM"
		//LoadOffensiveWords(0)
	Reboot()
		set category="GM"
		if(alert("Reboot the Server?","Reboot","Reboot","Cancel")=="Reboot")
			world<<"<font size=5 color=red>[usr] is Rebooting the Server!"
			sleep(1);world.Reboot()
	Send_Logout_Link()
		set category="GM"
		for(var/mob/M in world)	M.LogoutLink()
		usr<<"Link Sent"
	Shut_Down()
		set category="GM"
		if(alert("Shut Down the Server?","Shut Down","Shut Down","Cancel")=="Shut Down")
			world<<"<font size=5>[usr] is Shutting Down the Server!"
			sleep(1);shutdown()
	Set_MotD()
		set category="GM"
		MotD=input("Input the new MotD","MotD",MotD) as message
		usr.ViewMotD()
	Set_Logout_Link()
		set category="GM"
		LogoutLink=input("Input the link to be displayed when exiting the game:","Logout Link",LogoutLink) as text
	Upload_Package()
		set category="GM"
		var/F=input("Select the Updated Game Files to Upload","Upload Package") as file
		fcopy(F,"[F]")
		usr<<"<i><u>[F]</i></u> Replaced in Directory"
	Download_Chat_Log()
		set category="GM"
		usr<<ftp(file(input("Input the File to Download","Download File","ChatLogs/[time2text(world.timeofday,"YYYYMMMDD")].txt") as text))


mob/GM/RightClick/verb
	Steal_Icon(var/atom/A in world)
		set category="GM"
		src<<ftp(A.icon,"[A.icon]")
	CheckIP(var/mob/M in world)
		set category="GM"
		for(var/client/C in M.ControlClients)	usr<<"[C.mob.key]	<b>[C.mob.client.computer_id]</b>	[C.mob.client.address]"
	Goto(var/mob/M in world)
		set category="GM"
		usr.loc=M.loc
		world<<"[usr] has Teleported to [M]"
	Bring(var/mob/M in world)
		set category="GM"
		M.loc=usr.loc
		world<<"[usr] has Summoned [M]"
	Delete(var/atom/A in world)
		set category="GM"
		if(A && alert("Are you sure you want to Delete [A]?","Delete [A]","Delete","Cancel")=="Delete")
			if(ismob(A) && A:client)	del A:client
			else	del A
	Edit(var/datum/A in world)
		set category="GM"
		var/Var2Edit=input("Select Variable to Edit:","Edit [A]") as null|anything in A.vars
		if(!Var2Edit)	return
		var/default;var/VarValue = A.vars[Var2Edit]
		if(Var2Edit=="GM"||Var2Edit=="startx"||Var2Edit=="starty"||Var2Edit=="startz")
			usr<<"Contains: [VarValue]"
			usr<<"This cannot be edited!"
			return
		if(isnull(VarValue))	usr << "Variable appears to be <b>NULL</b>."
		if(isnum(VarValue))	{usr << "Variable appears to be <b>NUM</b>.";default = "num"}
		if(istext(VarValue))	{usr << "Variable appears to be <b>TEXT</b>.";default = "text"}
		if(isloc(VarValue))
			usr << "Variable appears to be <b>REFERENCE</b>.";default = "reference"
			if(alert("Switch to Editing this Object?","Edit New Reference","Yes","No")=="Yes")	{Edit(VarValue);return}
		if(istype(VarValue,/atom) || istype(VarValue,/datum))	{usr << "Variable appears to be <b>PATH</b>.";default = "type"}
		if(istype(VarValue,/list))
			usr << "Variable appears to be <b>LIST</b>."
			if(alert("Switch to Editing this List?","Edit List Entries","Yes","No")=="Yes")
				var/NewEdit=input("Select List Datum to Edit from list '[Var2Edit]'","Edit List") as anything in VarValue
				if(!istype(NewEdit,/datum))	{usr<<"Not a Datum...";return}
				Edit(NewEdit);return
			usr << "*** Warning!  Lists are uneditable in s_admin! ***"
			usr << "* List.len = [VarValue:len]"
			default = "cancel"
		if(istype(VarValue,/client))
			usr << "Variable appears to be <b>CLIENT</b>."
			usr << "*** Warning!  Clients are uneditable in s_admin! ***"
			default = "cancel"
		if(isicon(VarValue))
			usr << "Variable appears to be <b>ICON</b>."
			VarValue = "\icon[VarValue]"
			default = "icon"
		else	if(isfile(VarValue))	{usr << "Variable appears to be <b>FILE</b>.";default = "file"}
		usr << "Variable contains: [VarValue]"
		var/class = input("What kind of variable?","Variable Type",default) in list("text","num","type","reference","icon","file","restore to default","nullify","cancel")
		switch(class)
			if("cancel")	return
			if("nullify")	A.vars[Var2Edit] = null
			if("reference")	A.vars[Var2Edit] = input("Select reference:","Reference",A.vars[Var2Edit]) as anything in world
			if("restore to default")	A.vars[Var2Edit] = initial(A.vars[Var2Edit])
			if("num")	A.vars[Var2Edit] = input("Enter new number:","Num",A.vars[Var2Edit]) as num
			if("text")	A.vars[Var2Edit] = input("Enter new text:","Text",A.vars[Var2Edit]) as text
			if("type")	A.vars[Var2Edit] = input("Enter type:","Type",A.vars[Var2Edit]) in typesof(/obj,/mob,/area,/turf)
			if("file")	A.vars[Var2Edit] = input("Pick file:","File",A.vars[Var2Edit]) as file
			if("icon")	A.vars[Var2Edit] = input("Pick icon:","Icon",A.vars[Var2Edit]) as icon