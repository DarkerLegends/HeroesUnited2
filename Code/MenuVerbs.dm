var/FocusPMs=1
mob/var/list/OpenWindows
var/list/PowerUpModes=list("Both","Ki Only","PL Only","Ki then PL","PL then Ki","Nothing")
mob/verb
	Volume()
		var/list/Volumes=list("Effect","Menu","Voice","Music")
		for(var/v in Volumes)
			winset(src,null,"VolumeWindow.[v]Label.text=[src.vars["Volume[v]"]]%;VolumeWindow.[v]Volume.value=[src.vars["Volume[v]"]]")
		winset(src,"VolumeWindow","pos=100,100;is-visible=true")
	ChangedVolume(var/Volume as null|text)
		var/NewVolume=round(text2num(winget(src,"VolumeWindow.[Volume]Volume","value")))
		src.vars["Volume[Volume]"]=NewVolume
		winset(src,"volumeWindow.[Volume]Label","text=[NewVolume]%")
	PrivateMessage(var/KeyMsg as null|text)
		var/KeyIndex=findtext(KeyMsg,",")
		var/ThisKey=copytext(KeyMsg,1,KeyIndex)
		var/ThisMsg=SpamGuard(copytext(KeyMsg,KeyIndex+2))
		if(!ThisMsg)	return
		for(var/mob/M in world)	if(M.key==ThisKey)
			if(M.CreatePrMsgWindow(src))
				winset(M,"PrMsg[src.key]","is-minimized=true;is-visible=true")
				if(global.FocusPMs)	winset(M,"MainWindow.MainMap","focus=true")
			PlaySound(M,'Ring.ogg',VolChannel="Menu")
			M<<output("<b>[src]:</b> [ThisMsg]","PrMsg[src.key].PrMsgOutput")
			src<<output("<b>[src]:</b> [ThisMsg]","PrMsg[ThisKey].PrMsgOutput")
			return
		src<<output("<b>* [ThisKey] is Offline","PrMsg[ThisKey]")
	ChangedChatTab()
		var/NewPane=winget(src,"ChatPanes.ChatTabs","current-tab")
		if(src.ChatPane in ChatRooms)
			ChatRooms[src.ChatPane]-=src
			global.UpdateChatRoomWho(src.ChatPane)
		src.ChatPane=NewPane
		if(src.ChatPane in ChatRooms)
			ChatRooms[src.ChatPane]+=src
			global.UpdateChatRoomWho(src.ChatPane)
	PowerUpMode()
		set hidden=1
		src.PreferredPowerMode=input("Select Power Up Mode","Power Up Mode",src.PreferredPowerMode) as anything in global.PowerUpModes
		if(!src.InTournament)	src.PowerMode=src.PreferredPowerMode
	OpenedWindow(var/WindowID as null|text)
		if(!src.OpenWindows)	src.OpenWindows=list()
		src.OpenWindows+=WindowID
	CloseWindow(var/WindowID as null|text)
		winset(src,"[WindowID]","is-visible=false")
		src.ClosedWindow(WindowID)
	ClosedWindow(var/WindowID as null|text)
		set hidden=1
		if(!src.OpenWindows)	src.OpenWindows=list()
		src.OpenWindows-=WindowID
	SmallIcons()
		set hidden=1
		winset(src,"MainWindow.MainMap","icon-size=24")
	LargeIcons()
		set hidden=1
		winset(src,"MainWindow.MainMap","icon-size=32")
	CloseFullMap()
		set hidden=1
		winset(src,"MainWindow.MainMap","is-default=true;is-visible=true")
		winset(src,"FreeScaleWindow.ScaleMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow","is-visible=false")
		winset(src,"FullMapWindow.FullMap","is-default=false;is-visible=false")
		winset(src,"FullMapWindow","is-visible=false")
	ShiftEast()
		set hidden=1
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=EAST
	ShiftWest()
		set hidden=1
		if(src.icon_state=="Guard" || src.icon_state=="charge")	src.dir=WEST
	ApplyClanManagement()
		set hidden=1
		if(src.Clan==src.ManagingClan)
			if(!src.HasClanRankPower("Management"))	return
			var/datum/Clan/ThisGroup=src.ManagingClan
			var/list/Params=params2list(winget(src,"LevelInput;PowerLevelInput;KiEnergyInput;StrengthInput;DefenseInput;MotDInput;DefaultRankInput","text"))
			src.ManagingClan.MinStats["Level"]=round(max(0,text2num(Params["LevelInput.text"])))
			src.ManagingClan.MinStats["MaxPL"]=round(max(0,text2num(Params["PowerLevelInput.text"])))
			src.ManagingClan.MinStats["MaxKi"]=round(max(0,text2num(Params["KiEnergyInput.text"])))
			src.ManagingClan.MinStats["Str"]=round(max(0,text2num(Params["StrengthInput.text"])))
			src.ManagingClan.MinStats["Def"]=round(max(0,text2num(Params["DefenseInput.text"])))
			var/OrigRank=src.ManagingClan.DefaultRank
			src.ManagingClan.DefaultRank=RemoveHTML(Params["DefaultRankInput.text"])
			var/NewRank=src.ManagingClan.DefaultRank
			spawn(-1)
				if(OrigRank!=NewRank)
					if(alert("You have Changed the Default Clan Rank.\nWould you like all Members Currently Ranked '[OrigRank]' to be '[NewRank]'?","Default Member Ranks","Yes","No")=="Yes")
						if(src.Clan==ThisGroup)
							src.Clan.LogClanLog("[usr] Changed All Members Ranked [OrigRank][ThisGroup.GetRankLevel(OrigRank)] to [NewRank][ThisGroup.GetRankLevel(NewRank)]")
							for(var/v in ThisGroup.Members)	if(ThisGroup.Members[v]==OrigRank)
								ThisGroup.Members[v]=NewRank
								for(var/mob/M in Players)	if(M.key==v && M.ClanRank.name==OrigRank)
									M<<"Your Rank has been Changed to '[NewRank]'"
									M.SetClanRank(NewRank);break
				src.Clan.LogClanLog("Updated Clan Management Settings")
				alert("New Clan Management Settings Applied!","Success!")
			src.ManagingClan.MotD=RemoveHTML(Params["MotDInput.text"])
			src.SetFocus("ClanManagementWindow")
			src.UpdateClanManagementPage()
			SaveClans()
	WinClose(var/WindowName as null|text)
		set hidden=1
		winshow(src,WindowName,0)
	NullTarget()
		set hidden=1
		src.TargetMob(null)
	ScreenShot()
		set hidden=1
		winset(src,,"command=\".screenshot\"")
	SelectKbType(var/NewType as null|text)
		set hidden=1
		usr.CompleteTutorial("Ki Blast Types")
		usr=usr.GetFusionMob()
		usr.KbType=NewType
		usr.KiBlastHUD()
	ViewMotD()
		set hidden=1
		if(MotD)	src<<browse("<title>Message of the Day</title>[MotD]","window=MotD")
		else	src<<"No Global MotD to Display..."
	TextButton()
		set hidden=1
		winset(usr,"MainWindow.child1","splitter=0")
		usr.SetFocus("MainWindow.MainMap")
	InfoButton()
		set hidden=1
		winset(usr,"MainWindow.child1","splitter=100")
		usr.SetFocus("MainWindow.MainMap")
	SplitButton()
		set hidden=1
		winset(usr,"MainWindow.child1","splitter=25")
		usr.SetFocus("MainWindow.MainMap")
	ChangeKiBlast(var/ChangeDir as num)
		set hidden=1
		var/CurNum=KbTypes.Find(src.KbType)
		CurNum+=ChangeDir
		if(CurNum<=1)	CurNum=KbTypes.len
		if(CurNum>KbTypes.len)	CurNum=1
		src.GetFusionMob()
		src.KbType=KbTypes[CurNum]
		src.KiBlastHUD()
	SetFocus(var/Control as null|text)
		set hidden=1
		winset(src,"[Control]","focus=true")
	ToggleTransparency()
		set hidden=1
		src.see_invisible=!src.see_invisible
		if(!src.see_invisible)	src<<"Transparency Off:  Increased Performance for Decreased Gameplay"
		else	src<<"Transparency On:  Decreased Performance for Increased Gameplay"
		src.SetFocus("MainWindow.MainMap")
	ToggleSounds()
		set hidden=1
		src.VolumeMuteAll=!src.VolumeMuteAll
		if(src.VolumeMuteAll)
			src<<"Sounds Off:  Increased Performance for Decreased Gameplay"
			src<<sound(null)
		else	src<<"Sounds On:  Decreased Performance for Increased Gameplay"
		src.SetFocus("MainWindow.MainMap")
	DefaultLagOptions()
		set hidden=1
		src.VolumeMuteAll=initial(src.VolumeMuteAll)
		src.see_invisible=initial(src.see_invisible)
		winset(src,"LagOptionsWindow.HideTransBtn","is-checked=false")
		winset(src,"LagOptionsWindow.MuteSoundsBtn","is-checked=false")
		src<<"Lag Options have been Reset to Default"
		src.SetFocus("MainWindow.MainMap")