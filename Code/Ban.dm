proc/AntiHorse(var/mob/check)
	if(!check)	return
	if(check.ckey=="da-4orce")	{check<<"Fail.";del(src);return 1}
	if(check.ckey=="ziddy99")	{check<<"You're not allowed here - From Ziddy99.";del(src);return 1}
	else	return 0