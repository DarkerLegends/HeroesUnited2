mob/var/list/ButtonCombos
mob/var/ButtonComboing=0
mob/var/ButtonComboInfo=""
mob/var/ButtonFailed=0

mob/proc/CancelButtonCombo()
	src.ButtonComboing=0
	src.RemoveTrainingBG()
	src.UpdateHUDText("TrainingDesc")
	src.UpdateHUDText("TrainingCombo")
	src.ButtonCombos=list()

mob/proc/StartButtonCombo(var/ThisMsg="Quickly Press the Arrow Keys!",var/CanFail)
	if(src.ButtonComboing)	return
	src.AddHudProtection()
	src.ButtonFailed=0;src.ButtonComboing=1
	src.ButtonCombos=list();src.AddTrainingBG(CanQuit=0)
	src.UpdateHUDText("TrainingDesc","[ThisMsg]")
	for(var/i=1;i<=5;i++)	src.ButtonCombos+=pick(1,2,4,8)
	src.UpdateButtonCombos()
	if(!src.ControlClients)	spawn(rand(25,50))	src.ButtonComboing=0
	while(src.ButtonComboing)
		if(CanFail && src.ButtonFailed)	break
		sleep(1)
	src.RemoveHudProtection()
	src.ButtonComboing=0;src.RemoveTrainingBG()
	src.UpdateHUDText("TrainingDesc");src.UpdateHUDText("TrainingCombo")
	if(CanFail && src.ButtonFailed)	{src.TrackStat("Button Combos Failed",1);return 0}
	src.TrackStat("Button Combos Completed",1)
	return 1

mob/proc/UpdateButtonCombos()
	var/String=""
	for(var/i=src.ButtonCombos.len;i<5;i++)	String+="  "
	for(var/v in src.ButtonCombos)	switch(v)
		if(1)	String+="ô "
		if(2)	String+="ö "
		if(4)	String+="ò "
		if(8)	String+="º "
	src.UpdateHUDText("TrainingCombo","[String][src.ButtonComboInfo]")

mob/proc/ButtonHit(var/Dir)
	if(!src.ButtonCombos)	return
	if(Dir==src.ButtonCombos[1])
		PlaySound(src,pick('Swing1.ogg','Swing2.ogg'))
		src.ButtonCombos.Cut(1,2);src.UpdateButtonCombos()
		if(!src.ButtonCombos.len)	src.ButtonComboing=0
	else
		src.ButtonFailed=1
		PlaySound(src,'NoBuzz.ogg')