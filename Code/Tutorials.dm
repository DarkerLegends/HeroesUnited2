mob/var/obj/Tutorials/CurTut
mob/var/list/TutsComplete

var/list/Tutorials=list()
proc/PopulateTutorails()
	var/list/TypesOf=typesof(/obj/Tutorials)
	for(var/v in TypesOf)
		var/obj/Tutorials/T=new v
		Tutorials+=T.name
		Tutorials[T.name]=T

obj/Tutorials
	proc/TutComplete(var/mob/M)
		if(!M.client)	return
		winset(M,"MainWindow.Tutorial+","is-visible=false")
		winset(M,"TutorialWindow","is-visible=false")
		if(!M.TutsComplete)	M.TutsComplete=list()
		M.TutsComplete+=src.name
		M.CurTut=null
		M.GeneralTutorials()
	Movement
		desc="Use the Arrow Keys to Move your Character."
	Flight
		desc="Press Shift+Up to Take off, and Shift+Down to Land."
	Attacking
		desc="Press F to use a Basic Melee Attack"
	Strong_Attacks
		desc="Hold S to use a Strong Melee Attack.  These will Break Guard or KnockBack Enemies."
	Ki_Blast_Types
		desc="Use 1-6 to Change your Ki Blast Type.  They can be viewed below your PL Bar."
	MiniMap
		desc="If you get lost; press M to Bring up the MiniMap."
	Instant_Transmission
		desc="Double Click the Map to use Instant Transmission.  Fly first for better results."
	Training
		desc="Enter a Training Capsule, like the one South of where you Started, and Attack a P.Bag to Train."
	Training_Exp
		desc="You will Stock Training Exp while Training.  It is Distributed when the Training Session Ends."
	Additional_Training
		desc="Right Click on the Center Console in the Training Capsule for Additional Training Options."
	Transformations
		desc="Press Shift+A to Transform!  Transformations Increase Damage Dealt and Lower Damage Taken."
	Reverting
		desc="Press Shift+Z to Revert!  You can also use Ctrl+Z to Step Revert, and Ctrl+A to Step Transform."
	Missions
		desc="Speak with Master Roshi near the World Tournament to Start an Episode Mission."
	Capsule_Characters
		desc="You can Summon AI Companions from the Capsules Tab at the Top Right above Chat."
	Mission_Completion
		desc="Follow the Path and Defeat the Boss to Complete your Mission."
	Clearing_Missions
		desc="Defeat all Enemies and Loot all Chests for a Mission Clear Bonus +100 Levels!"
	Changing_Characters
		desc="Select Change Character from the Options File Menu above the Map to Change Characters"

	Finishers
		desc="You must use an Energy Attack to Kill an Opponent.  Press D to Ki Blast, Shift+D for Beam."
	Opening_Chests
		desc="Hit a Chest with any type of attack to open it!  Walk over items to pick them up."
	Start_Sparring
		desc="You will Guard after creating a Sparring Partner.  Tap G to stop Guarding, and start Fighting!"

	KO_Recovery
		desc="Quickly tap G to Recover from KO."
	Power_Up
		desc="When you get low on Health or Energy...  Hold A to Power Up!"
	Guard
		desc="Hold G to Guard against incoming Attacks.  This will negate damage."
	Stat_Points
		desc="Each Level Gives you 1 Stat Point.  Click the White Arrow at the Bottom of your HUD to Distribute Points."
	Alpha_Revival
		desc="Enter the Building at the top of the Stairs and Speak with King Yemma by Right Clicking him to be Revived."

var/list/GeneralTuts=list("Movement","Flight","MiniMap","Instant Transmission","Attacking","Strong Attacks","Ki Blast Types","Training","Additional Training","Transformations","Reverting","Capsule Characters","Missions")
mob/proc/GeneralTutorials()
	for(var/client/C in src.ControlClients)
		for(var/v in GeneralTuts)	if(!(v in C.mob.TutsComplete))
			C.mob.ShowTutorial(Tutorials[v]);break
		if(src.z==2)	src.ShowTutorial(Tutorials["Alpha Revival"])
		if(src.z in MissionZs)
			src.ShowTutorial(Tutorials["Clearing Missions"])
			src.ShowTutorial(Tutorials["Mission Completion"])
		if(src.icon_state=="koed")	src.ShowTutorial(Tutorials["KO Recovery"])

mob/proc/CompleteTutorial(var/TutName)
	if(src.CurTut && src.CurTut.name==TutName)	src.CurTut.TutComplete(src)

mob/verb/CloseTutorial()
	set hidden=1
	winset(usr,"TutorialWindow","is-visible=false")
	winset(usr,"MainWindow.Tutorial+","is-visible=true")
	usr.SetFocus("MainWindow.MainMap")

mob/verb/RestoreTutorial()
	set hidden=1
	if(usr.CurTut)	usr.ShowTutorial(usr.CurTut)

mob/proc/ShowTutorial(var/obj/Tutorials/T)
	for(var/client/C in src.ControlClients)
		if(T.name in C.mob.TutsComplete)	return
		C.mob.CurTut=T
		winset(C.mob,"MainWindow.Tutorial+","is-visible=false")
		winset(C.mob,"TutorialWindow.NameLabel","text='[T.name] - Tutorial'")
		winset(C.mob,"TutorialWindow.DescLabel","text='[T.desc]'")
		winset(C.mob,"TutorialWindow","pos=236,466;is-visible=true")
		C.mob.SetFocus("MainWindow.MainMap")