/*
  This is a short demonstration on how to prevent people from logging in if they're not testers.
*/
var/list/beta_testers=list("ziddy99","aliahmed","scottyg16","Hassanjalil")//Put your ckey here. Your ckey is basically your key without spaces or upper-case letters.
var/closed_beta=0//Set to one if closed beta, set to zero if public.

client/New()
  if(!(src.ckey in beta_testers))//Check if the user's a tester or not.
    src << "You're not allowed to be testing this game, sorry!"//Tell the user he's not allowed to join.
    del src//Block the user from going any further.
  return ..()//User is a tester, continue.