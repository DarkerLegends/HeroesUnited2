var/datum/ConceptLists/CLD=new()
datum/ConceptLists
	var/list
		ConceptPieces=list()
		ConceptFillers=list()
		ConceptStarters=list()
		CityConceptPieces=list()
		CityConceptFillers=list()
		CityConceptStarters=list()
		ConceptBosses=list()

mob/var/obj/TempCpHolder/CurrentCP

obj/TempCpHolder
	var/list/Users=list()
	var/Boss

obj/ConceptPiece
	var/Top=0
	var/Bottom=0
	var/Left=0
	var/Right=0
	var/Filler=0
	var/Boss
	New()
		if(src.Boss)	CLD.ConceptBosses+=src
		else	if(src.Filler)
			if(src.x<=170)	CLD.ConceptFillers+=src
			else	CLD.CityConceptFillers+=src
		else	if(src.Top && !src.Bottom && !src.Left && !src.Right)
			if(src.x<=170)	CLD.ConceptStarters+=src
			else	CLD.CityConceptStarters+=src
		else
			if(src.x<=170)	CLD.ConceptPieces+=src
			else	CLD.CityConceptPieces+=src
		return ..()

mob/proc/ExitCP(/**/)
	src.ResetIS()
	src.DropFlag("Exit")
	src.CancelBeamBattle()
	src.ForceCancelTraining()
	if(src.client)
		src.ClearForcedMiniMap()
		src.client.screen-=global.TWMMMs
		src.client.screen-=global.FWMMMs
	if(src.GhostMode)	{src.GhostMode=2;src.Respawn()}
	if(src.CurrentCP)
		src.CurrentCP.Users-=src
		if(src.CurrentCP.Users.len<=0)	DeleteCpMap(src.CurrentCP.x+7+13,src.CurrentCP.y-6,src.CurrentCP.z)
		src.CurrentMission=null
		src.CurrentCP=null
	src.ExitInstance()

proc/GenerateConceptPieceMap(var/mob/M,var/datum/Missions/ThisMission)
	for(var/obj/TempCpHolder/H in world)	if(!H.Users.len)
		ThisMission=new ThisMission.type
		H.Boss=ThisMission.Boss[1]
		var/obj/ConceptPiece/CP
		var/CurY=H.y-6
		var/CurX=H.x+7+13
		var/Column=2
		var/list/Columns=list("Left","Middle","Right")
		var/list/AllLocs=DeleteCpMap(CurX,CurY,H.z)
		var/list/WalkableTurfs=list()
		var/list/EnemyLocSections=list()
		for(var/i=1;i<=9;i++)
			if(!CP)	CP=pick(CLD.vars["[ThisMission.ChipSet]ConceptStarters"])
			else
				var/Dir2Match;var/Dir2Check
				if(CP.Top)	{Dir2Check="Bottom";Dir2Match=CP.Top}
				else	if(CP.Left)	{Dir2Check="Right";Dir2Match=CP.Left}
				else	if(CP.Right)	{Dir2Check="Left";Dir2Match=CP.Right}
				var/list/MatchingCPs=list()
				var/list/MatchingBossCPs=list()
				var/list/ChipSet=CLD.vars["[ThisMission.ChipSet]ConceptPieces"]
				for(var/obj/ConceptPiece/C in ChipSet+CLD.ConceptBosses)
					if(i>=9 && C.Boss==ThisMission.Boss[1] && C.Bottom==Dir2Match)	MatchingBossCPs+=C
					else	if(C.vars[Dir2Check]==Dir2Match)
						if(C.Boss)	continue
						if(i>=8 && !C.Top)	continue
						if(Dir2Check=="Left" || Dir2Check=="Right")
							if(C.Bottom)	continue
						if(Column==2 && C.Left && C.Right)	continue
						if(Column==1 && C.Left && !C.Top)	continue
						if(Column==Columns.len && C.Right && !C.Top)	continue
						MatchingCPs+=C
				if(MatchingBossCPs.len)	CP=pick(MatchingBossCPs)
				else	CP=pick(MatchingCPs)
				if(CP.Left && CP.Right)
					if(Dir2Check=="Left")	{i-=1;CurX+=13;CurY-=13;Column+=1}
					else	{i-=1;CurX-=13;CurY-=13;Column-=1}
				else
					if(CP.Left && !CP.Bottom)	{i-=1;CurX+=13;CurY-=13;Column+=1}
					if(CP.Right && !CP.Bottom)	{i-=1;CurX-=13;CurY-=13;Column-=1}
			CurY+=13;var/turf/DrawLoc=locate(CurX,CurY,H.z)
			AllLocs-=DrawLoc;WalkableTurfs+=DrawLoc
			var/list/EnemyLocs=list()
			for(var/atom/A in oview(6,CP))
				if(isarea(A))	continue
				var/DistX=A.x-CP.x;var/DistY=A.y-CP.y
				var/atom/NewAtom=new A.type(locate(DrawLoc.x+DistX,DrawLoc.y+DistY,DrawLoc.z))
				MatchVars(NewAtom,A)
				var/list/SpawnableLocs=list("Dirt","Road")
				if(istype(NewAtom) && (NewAtom.name in SpawnableLocs))	EnemyLocs+=NewAtom
			if(i>1 && i<=8)
				EnemyLocSections+="[i]"
				EnemyLocSections["[i]"]=EnemyLocs
			if(i>=9)
				var/mob/CombatNPCs/Enemies/E=new(locate(DrawLoc.x,DrawLoc.y-1,DrawLoc.z))
				E.StartLoc=E.loc;E.SetCharacter(ThisMission.Boss[1]);E.DamageMultiplier=ThisMission.Boss[3]
		for(var/list/L in ThisMission.Enemies)	for(var/R=1;R<=rand(1,L[2]);R++)
			var/list/LocSet=pick(EnemyLocSections)
			LocSet=EnemyLocSections[LocSet]
			var/mob/CombatNPCs/Enemies/E=new(pick(LocSet))
			E.SetCharacter(L[1]);E.DamageMultiplier=L[3]
			ThisMission.EnemyCount+=1;E.StartLoc=E.loc
		for(var/i=1;i<=rand(1,3);i++)	{new/obj/Items/Destroyable/Chests/Chest(pick(WalkableTurfs));ThisMission.ChestCount+=1}
		for(var/v in AllLocs)	DrawFiller(v,ThisMission.ChipSet)
		var/list/PartyList=M.Party
		if(!PartyList.len)	PartyList=list(M)
		for(var/mob/P in PartyList)	P.JoinMission(H,ThisMission)
		return	1

mob/proc/JoinMission(var/obj/TempCpHolder/H,var/datum/Missions/ThisMission)
	src=src.GetFusionMob()
	if(src.InTournament)	return
	src.ExitCP()
	H.Users+=src;src.CurrentCP=H
	src.CurrentMission=ThisMission
	src.PreInstanceLoc="[src.x]&[src.y]&[src.z]"
	src.dir=NORTH;src.loc=locate(H.x+20,H.y+5,H.z)
	src.ForceCancelTraining()
	src.LoadMiniMapBG()
	src.ResetTrackedStats(list("Chests Opened","Damage Dealt","Damage Taken","NPCs Killed"))

proc/DeleteCpMap(var/CurX,var/CurY,var/HZ)
	var/list/AllLocs=list()
	for(var/i=1;i<=9;i++)
		CurY+=13
		var/Loc1=locate(CurX-13,CurY,HZ);var/Loc2=locate(CurX,CurY,HZ);var/Loc3=locate(CurX+13,CurY,HZ)
		AllLocs.Add(Loc1,Loc2,Loc3)
		for(var/turf/T in view(6,Loc1)+view(6,Loc2)+view(6,Loc3))
			for(var/obj/A in T.contents)	A.loc=null
			for(var/mob/CombatNPCs/Enemies/A in T.contents)	del A
	return AllLocs

proc/MatchVars(var/obj/New,var/obj/Settings)
	New.dir=Settings.dir
	New.layer=Settings.layer
	New.density=Settings.density
	New.pixel_x=Settings.pixel_x
	New.pixel_y=Settings.pixel_y
	New.icon_state=Settings.icon_state
	if(isturf(New) && isturf(Settings))
		New.overlays+=Settings.overlays
		New.underlays+=Settings.underlays

proc/DrawFiller(var/turf/DrawLoc,var/ChipSet)
	var/obj/ConceptPiece/CP=pick(CLD.vars["[ChipSet]ConceptFillers"])
	for(var/atom/A in oview(6,CP))
		if(isarea(A))	continue
		var/DistX=A.x-CP.x;var/DistY=A.y-CP.y
		var/atom/NewAtom=new A.type(locate(DrawLoc.x+DistX,DrawLoc.y+DistY,DrawLoc.z))
		MatchVars(NewAtom,A)
		//if(isturf(NewAtom))	{NewAtom:density=1;NewAtom:SuperDensity=1}
		//limits missions to the path only