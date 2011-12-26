mob/verb
	Full_Screen()
		set hidden=1
		set category="Options"
		winset(src,"MainWindow.MainMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow.ScaleMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow","is-visible=false")
		winset(src,"FullMapWindow.FullMap","is-default=true;is-visible=true")
		winset(src,"FullMapWindow","pos=100,100;size=544x544;is-maximized=true;is-visible=true")
	FreeScaleMode()
		set hidden=1
		set category="Options"
		winset(src,"MainWindow.MainMap","is-default=false;is-visible=false")
		winset(src,"FreeScaleWindow.ScaleMap","is-default=true;is-visible=true")
		winset(src,"FreeScaleWindow","pos=0,0;size=544x544;is-visible=true")
	Ignore_Duels()
		set hidden=1
		set category="Options"
		usr.IgnoreDuels=!usr.IgnoreDuels
		if(usr.IgnoreDuels)	usr<<"You are now Ignoring all Duel Requests"
		else	usr<<"You are now Accepting Duel Requests"

	Reset_Tutorials()
		set hidden=1
		//set name="Tutorial: Reset"
		set category="Options"
		if(alert("Clear all Completed Tutorial Tips?","Reset Tutorials","Reset","Cancel")=="Reset")	usr.TutsComplete=list()
		usr.GeneralTutorials()
	Review_Tutorials()
		set hidden=1
		//set name="Tutorial: Review"
		set category="Options"
		var/Choice=input("Select the Tutorial Tip to Review","Review Tutorials") as null|anything in usr.TutsComplete
		if(!Choice)	return
		var/obj/Tutorials/T=Tutorials[Choice]
		alert(T.desc,T.name)