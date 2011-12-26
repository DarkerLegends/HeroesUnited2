datum/ScoreBoardDatum
	var/key
	var/Level
	var/PlayTime

var/TopCount=100
var/list/ScoreBoardDatums

mob/verb/ViewScoreBoard()
	set hidden=1
	var
		BgFmt="<body bgcolor=black link=[rgb(255,128,0)] alink=[rgb(255,128,0)] vlink=[rgb(255,128,0)]>"
		TableFmt="<table border=1 bgcolor=[rgb(0,0,64)] width=100%>"
		TdFmt="<b><font color=[rgb(255,128,0)]><center>"
		UL="<u>"
	var/HTML="<title>ScoreBoard</title>[BgFmt]<center>[TableFmt]"
	HTML+="<tr><td colspan=4>[TdFmt]Top [TopCount] DBZ:HU2 Players"
	HTML+="<tr><td>[TdFmt][UL]#<td>[TdFmt][UL]Player<td>[TdFmt][UL]Level<td>[TdFmt][UL]Play Time"
	var/counter=0
	for(var/datum/ScoreBoardDatum/D in ScoreBoardDatums)
		counter+=1
		HTML+="<tr><td>[TdFmt][counter]<td>[TdFmt][D.key]<td>[TdFmt][FullNum(D.Level)]<td>[TdFmt][D.PlayTime]"
	HTML+="</table>"
	usr<<browse(HTML,"window=ScoreBoard")

proc/SaveScoreBoard()
	if(fexists("ScoreBoard.sav"))	fdel("ScoreBoard.sav")
	var/savefile/F=new("ScoreBoard.sav")
	F["ScoreBoardDatums"]<<ScoreBoardDatums

proc/LoadScoreBoard()
	if(fexists("ScoreBoard.sav"))
		var/savefile/S=new("ScoreBoard.sav")
		S["ScoreBoardDatums"]>>ScoreBoardDatums

mob/proc/ScoreBoardRecord()
	if(!ScoreBoardDatums)	ScoreBoardDatums=list()
	var/TopPlayer=0
	if(ScoreBoardDatums.len<TopCount)	TopPlayer=1
	else
		var/datum/ScoreBoardDatum/D=ScoreBoardDatums[TopCount]
		if(src.GetRebirthLevel()>D.Level)	TopPlayer=1
	if(TopPlayer)
		var/datum/ScoreBoardDatum/D
		for(var/datum/ScoreBoardDatum/SearchD in ScoreBoardDatums)	if(SearchD.key==src.key)	{D=SearchD;break}
		if(!D)	D=new/datum/ScoreBoardDatum
		D.key=src.key;D.Level=src.GetRebirthLevel();D.PlayTime=src.DisplayPlayTime()
		ScoreBoardDatums-=D;ScoreBoardDatums+=D
		ScoreBoardDatums=SortScoreBoard(ScoreBoardDatums,"Level")
		if(ScoreBoardDatums.len>=TopCount)	ScoreBoardDatums.Cut(TopCount+1)
		SaveScoreBoard()

proc/SortScoreBoard(var/list/Orig,var/Stat)
	var/list/L=list();L+=Orig
	var/list/SortedList=list()
	while(L.len)
		var/mob/Highest
		for(var/datum/ScoreBoardDatum/M in L)	if(!Highest || M.vars[Stat]>Highest.vars[Stat])	Highest=M
		L-=Highest;SortedList+=Highest
	return SortedList