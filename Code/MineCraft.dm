mob/var/list/Materials

mob/proc/CollectMaterial(var/MatType)
	if(!islist(src.Materials))	src.Materials=list()
	for(var/obj/Building/Materials/M in src.Materials)	if(M.name==MatType)
		M.suffix="[text2num(M.suffix)+1]";return
	var/obj/Building/Materials/M=new()
	M.icon_state="[MatType]";M.suffix="1"
	M.mouse_drag_pointer=M.icon_state
	M.name=M.icon_state;src.Materials+=M

mob/proc/RemoveMaterial(var/MatType)
	if(!islist(src.Materials))	src.Materials=list()
	for(var/obj/Building/Materials/M in src.Materials)	if(M.name==MatType)
		M.suffix="[text2num(M.suffix)-1]"
		if(text2num(M.suffix)<=0)	src.Materials-=M
		return

obj/Building/Materials
	icon='MineCraft.dmi'
	MouseDrop(atom/over_object,src_location,over_location,src_control,over_control,params)
		if(istype(over_object,/turf/MineCraft/Grass))	if(over_object:name!=src.name)
			if(!usr.Clan || !over_object:TWFlag || over_object:TWFlag.ClanOwner!=usr.Clan.name)
				usr<<"No Building Enemy Territory - Secure the Flag";return
			over_object:ApplyMaterial(src.name);usr.RemoveMaterial(src.name)
			over_object:SaveMaterial()

var/list/DigMaterials=list("Grass","Dirt","Stone","Water","Obsidian","Lava")
proc/PopulateDigMats()
	for(var/v in DigMaterials)
		var/TextPath=text2path("/obj/MineCraft/[v]")
		DigMaterials[v]=new TextPath

proc/LoadMaterials()
	if(fexists("MineCraft.sav"))
		var/savefile/F=new("MineCraft.sav")
		for(var/v in F.dir)
			var/ParamList=params2list(F[v])
			var/turf/MineCraft/Grass/T=locate(text2num(ParamList[1]),text2num(ParamList[2]),10)
			T.ApplyMaterial(ParamList[3])

turf/MineCraft
	icon='MineCraft.dmi'
	var/CanCollect=1
	var/obj/TerritoryWars/Territory_Flag/TWFlag
	Grass
		icon_state="Grass"
		mouse_drag_pointer="Grass"
		MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
			if(!src.CanCollect || !src.TWFlag)	return
			if(!usr.Clan || src.TWFlag.ClanOwner!=usr.Clan.name)	{usr<<"No Mining Enemy Territory - Secure the Flag";return}
			if(over_control=="InfoPane.MainInfo")
				usr.CollectMaterial(src.name)
				var/NextMatID=DigMaterials.Find(src.name)+1
				src.ApplyMaterial(DigMaterials[min(DigMaterials.len,NextMatID)])
				src.SaveMaterial()
		proc/SaveMaterial()
			var/savefile/F=new("MineCraft.sav")
			F["[src.x],[src.y]"]<<list2params(list("[src.x]x","[src.y]y",src.name))
		proc/ApplyMaterial(var/obj/MineCraft/NewMat)
			NewMat=DigMaterials[NewMat];src.name=NewMat.name
			src.density=NewMat.density;src.SuperDensity=NewMat.SuperDensity
			src.icon_state=NewMat.icon_state;src.CanCollect=NewMat.CanCollect
			if(src.CanCollect)	src.mouse_drag_pointer=src.icon_state
			else	src.mouse_drag_pointer=null
	GrassDirt
		icon_state="GrassDirt"
	Stone
		icon_state="Stone"
	Water
		density=1
		icon_state="Water"

obj/MineCraft
	var/CanCollect=1
	var/SuperDensity=0
	Grass
		icon_state="Grass"
	Dirt
		icon_state="Dirt"
	Stone
		icon_state="Stone"
	Water
		density=1
		icon_state="Water"
	Obsidian
		icon_state="Obsidian"
	Lava
		density=1
		CanCollect=0
		icon_state="Lava"
	Cobblestone
		density=1;SuperDensity=1
		icon_state="Cobblestone"