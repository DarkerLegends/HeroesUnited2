mob/verb/Change_Character()
	set hidden=1
	set category="Options"
	src.CompleteTutorial("Changing Characters")
	var/obj/Choice=input("Choose New Character","Change Character") as null|anything in AllCharacters
	if(!Choice || !src.CanAct())	{src<<"Can't change characters at this time...";return}
	src.Character=new Choice.type
	src.Revert()
	if(src.Training=="Focus Training")	src.AddAura()
	src.icon=src.Character.icon
	src.UpdatePartyIcon()
	src.UpdateFaceHUD()
	src.ResetSuffix()

datum/TransDatum
	var/name
	var/icon
	var/ReqPL
	var/CustAura
	var/CharSpecials/BeamSpecial

proc/cTrans(var/Icon,var/NewPL,var/NewSpecial,var/NewCA)
	var/datum/TransDatum/T=new()
	T.name="[Icon]"
	T.icon=Icon;T.ReqPL=NewPL
	T.BeamSpecial=NewSpecial
	T.CustAura=NewCA
	return T

mob/proc/ApplyTransDatum(/**/)
	if(src.CurTrans)
		src.TransDatum=src.Character.Transes[src.CurTrans]
		src.icon=src.TransDatum.icon
	else
		src.TransDatum=null
		src.icon=src.Character.icon
	src.UpdatePartyIcon()

var/list/AllCharacters=typesof(/obj/Characters)-/obj/Characters
proc/PopulateAllChars()
	for(var/v in AllCharacters)
		AllCharacters+=new v
		AllCharacters-=v

obj/Characters
	var
		Aura="Blue"
		Race="Baby Panda"
		list/Transes=list()
		CharSpecials/BeamSpecial
	Kid_Goku
		Race="Saiyan"
		icon='KidGoku.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Goku
		Race="Saiyan"
		icon='Goku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('GokuKaioken.dmi',1000,NewCA="Red"),cTrans('GokuSS1.dmi',100000),cTrans('GokuSS2.dmi',250000),cTrans('GokuSS3.dmi',500000),cTrans('GokuSS4.dmi',750000),cTrans('GokuSS5.dmi',999999,NewCA="White"))
	Shirtless_Goku
		Race="Saiyan"
		icon='ShirtlessGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('ShirtlessGokuFalseSS.dmi',50000),cTrans('AltGokuSS4.dmi',750000))
	Super_Goku
		Aura="Yellow"
		Race="Saiyan"
		icon='SuperGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('AltGokuSS4.dmi',750000))
	Yardrat_Goku
		Race="Saiyan"
		icon='YardratGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('YardratGokuSS.dmi',100000),cTrans('AltGokuSS4.dmi',750000))
	Saiyan_Armor_Goku
		Race="Saiyan"
		icon='SAGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('SAGokuSS.dmi',100000),cTrans('SAGokuUSS.dmi',250000),cTrans('AltGokuSS4.dmi',750000))
	GT_Goku
		Race="Saiyan"
		icon='GTGoku.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
		New()	Transes=list(cTrans('GTGokuSS1.dmi',100000),cTrans('GTGokuSS3.dmi',500000),cTrans('AltGokuSS4.dmi',750000,new/CharSpecials/KameHameHa))
	Adult_GT_Goku
		Race="Saiyan"
		icon='AdultGTGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('AdultGTGokuSS1.dmi',100000),cTrans('AdultGTGokuSS2.dmi',250000),cTrans('AltGokuSS4.dmi',750000))
	Great_SaiyaGoku
		Aura="Yellow"
		Race="Saiyan"
		icon='GreatSaiyaGoku.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('AltGokuSS4.dmi',750000))
	Goku_Jr
		Aura="Yellow"
		Race="Saiyan"
		icon='GokuJr.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Kid_Gohan
		Race="Half Saiyan"
		icon='KidGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Piccolo_Trained_Gohan
		Race="Half Saiyan"
		icon='PiccoloTrainedGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_Masenko
	Namek_Gohan
		Race="Half Saiyan"
		icon='NamekGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Saiyan_Armor_Gohan
		Race="Half Saiyan"
		icon='SAGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
		New()	Transes=list(cTrans('SAGohanSS.dmi',100000),cTrans('SAGohanSS2.dmi',250000))
	Teen_Gohan
		Race="Half Saiyan"
		icon='TeenGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
		New()	Transes=list(cTrans('TeenGohanSS.dmi',100000))
	Bojack_Gohan
		Race="Half Saiyan"
		icon='BojackGohan.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
		New()	Transes=list(cTrans('BojackGohanSS1.dmi',100000))
	Adult_Gohan
		Race="Half Saiyan"
		icon='AdultGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GohanSS4.dmi',750000))
	Adult_Piccolo_Gohan
		Race="Half Saiyan"
		icon='AdultPiccoloGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GohanSS4.dmi',750000))
	Great_Saiyaman
		Race="Half Saiyan"
		icon='GreatSaiyaman.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GreatSaiyaman1.dmi',100000,NewCA="Blue"),cTrans('GreatSaiyamanSS.dmi',250000),cTrans('GreatSaiyamanSS2.dmi',500000),cTrans('GohanSS4.dmi',750000))
	Buu_Gohan
		Race="Half Saiyan"
		icon='BuuGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GohanSS4.dmi',750000))
	Mystic_Gohan
		Race="Half Saiyan"
		icon='MysticGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('MysticGohanSS.dmi',100000),cTrans('MysticGohanSS2.dmi',250000),cTrans('MysticGohanMystic.dmi',500000),cTrans('GohanSS4.dmi',750000))
	Elder_Kai_Gohan
		Race="Half Saiyan"
		icon='ElderKaiGohan.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('ElderKaiGohanSword.dmi',750000),cTrans('GohanSS4.dmi',750000))
	Future_Gohan
		Aura="Yellow"
		Race="Half Saiyan"
		icon='FutureGohanSS.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GohanSS4.dmi',750000))
	Future_Gohan_Aftermath
		Race="Half Saiyan"
		icon='FutureGohanAftermath.dmi'
		BeamSpecial=new/CharSpecials/Gohan_KameHameHa
		New()	Transes=list(cTrans('GohanSS4.dmi',750000))
	Goten
		Race="Half Saiyan"
		icon='Goten.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('GotenSS.dmi',100000),cTrans('GotenSS2.dmi',250000))
	Teen_Goten
		Race="Half Saiyan"
		icon='TeenGoten.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	GT_Goten
		Aura="Yellow"
		Race="Half Saiyan"
		icon='GTGoten.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa

	Prince_Vegeta
		Race="Saiyan"
		icon='PrinceVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('PrinceVegetaSS.dmi',100000))
	Scouter_Vegeta
		Race="Saiyan"
		icon='ScouterVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
		New()	Transes=list(cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	Saiyan_Armor_Vegeta
		Race="Saiyan"
		icon='SAVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('SAVegetaSS.dmi',100000),cTrans('SAVegetaUSS.dmi',250000,new/CharSpecials/Final_Flash),cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	Vegeta
		Race="Saiyan"
		icon='Vegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
		New()	Transes=list(cTrans('VegetaSS.dmi',100000,new/CharSpecials/Final_Flash),cTrans('VegetaMajin.dmi',250000,new/CharSpecials/Final_Flash),cTrans('VegetaSS3.dmi',500000,new/CharSpecials/Final_Flash),cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	Alternate_Vegeta
		Race="Saiyan"
		icon='AltVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('AltVegetaMajin.dmi',250000,new/CharSpecials/Final_Flash),cTrans('AltVegetaSS2.dmi',250000),cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	GT_Vegeta
		Race="Saiyan"
		icon='GTVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('GTVegetaSS.dmi',100000,new/CharSpecials/Final_Flash),cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	Alternate_GT_Vegeta
		Race="Saiyan"
		icon='AltGTVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
		New()	Transes=list(cTrans('AltGTVegetaSS.dmi',100000),cTrans('VegetaSS4.dmi',750000,new/CharSpecials/Final_Shine))
	Baby_Vegeta
		Aura="White"
		Race="Saiyan"
		icon='BabyVegeta.dmi'
		BeamSpecial=new/CharSpecials/Big_Bang_Attack
	Kid_Trunks
		Race="Half Saiyan"
		icon='KidTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('KidTrunksSS.dmi',100000))
	Future_Trunks
		Race="Half Saiyan"
		icon='FutureTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('FutureTrunksSS.dmi',100000))
	Trunks
		Race="Half Saiyan"
		icon='Trunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('TrunksSS.dmi',100000,new/CharSpecials/Burning_Attack),cTrans('TrunksSS2.dmi',250000,new/CharSpecials/Burning_Attack),cTrans('TrunksSS3.dmi',500000),cTrans('TrunksSS4.dmi',750000,new/CharSpecials/Burning_Attack))
	Super_Trunks
		Aura="Yellow"
		Race="Half Saiyan"
		icon='SuperTrunksSS.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('SuperTrunksSS2.dmi',250000))
	Saiyan_Armor_Trunks
		Race="Half Saiyan"
		icon='SATrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('SATrunksSS.dmi',100000,new/CharSpecials/Finish_Buster),cTrans('SATrunksUSS.dmi',250000,new/CharSpecials/Burning_Attack),cTrans('SATrunksSS3.dmi',500000,new/CharSpecials/Burning_Attack))
	Bojack_Trunks
		Race="Half Saiyan"
		icon='BojackTrunks.dmi'
		BeamSpecial=new/CharSpecials/Finish_Buster
	GT_Trunks
		Race="Half Saiyan"
		icon='GTTrunks.dmi'
		BeamSpecial=new/CharSpecials/Buster_Cannon
		New()	Transes=list(cTrans('GTTrunksSS.dmi',100000))

	Gotenks
		Race="Half Saiyan"
		icon='Gotenks.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('GotenksSS1.dmi',100000),cTrans('GotenksSS3.dmi',500000))
	Vegetrunks
		Race="Saiyan"
		icon='Vegetrunks.dmi'
		BeamSpecial=new/CharSpecials/Final_Flash
		New()	Transes=list(cTrans('VegetrunksSS.dmi',100000))
	Broku
		Aura="Green"
		Race="Saiyan"
		icon='Broku.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell
	Vegito
		Race="Saiyan"
		icon='Vegito.dmi'
		BeamSpecial=new/CharSpecials/BBK
		New()	Transes=list(cTrans('VegitoSS.dmi',100000))
	Gogeta
		Race="Saiyan"
		icon='Gogeta.dmi'
		BeamSpecial=new/CharSpecials/BBK
		New()	Transes=list(cTrans('GogetaSS.dmi',100000),cTrans('GogetaSS4.dmi',750000))

	Master_Roshi
		Race="Human"
		icon='MasterRoshi.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
	Black_Suit_Roshi
		Race="Human"
		icon='BlackSuitRoshi.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
	Yajirobe
		Race="Human"
		icon='Yajirobe.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Krillin
		Race="Human"
		icon='Krillin.dmi'
		BeamSpecial=new/CharSpecials/Destructo_Disk
	GT_Krillin
		Race="Human"
		icon='GTKrillin.dmi'
		BeamSpecial=new/CharSpecials/Destructo_Disk
	Yamcha
		Race="Human"
		icon='Yamcha.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
	Tien
		Race="Alien"
		icon='Tien.dmi'
		BeamSpecial=new/CharSpecials/TriBeam
	Chiaotzu
		Race="Alien"
		icon='Chiaotzu.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
	Piccolo
		Aura="Green"
		Race="Namekian"
		icon='Piccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
		New()	Transes=list(cTrans('PiccoloForm2.dmi',100000),cTrans('PiccoloForm3.dmi',250000))
	Nail
		Aura="Green"
		Race="Namekian"
		icon='Nail.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Lord_Slug
		Aura="Green"
		Race="Namekian"
		icon='LordSlug.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Pikkon
		Aura="Green"
		Race="Alien"
		icon='Pikkon.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Olibu
		Race="Human"
		icon='Olibu.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch
	ChiChi
		Race="Human"
		icon='ChiChi.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
	Pan
		Race="Half Saiyan"
		icon='Pan.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('PanSS.dmi',100000))
	Saiyan_Armor_Bulma
		Race="Human"
		icon='SABulma.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
	Videl
		Race="Human"
		icon='Videl.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
		New()	Transes=list(cTrans('GreatSaiyagirl.dmi',1000))
	Great_Saiyagirl
		Race="Human"
		icon='GreatSaiyagirl.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
	Hercule
		Race="Human"
		icon='Hercule.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch
	Uub
		Race="Human"
		icon='Uub.dmi'
		BeamSpecial=new/CharSpecials/Kid_Gohan_KameHameHa
	Turtle
		Race="Animal"
		icon='Turtle.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch

	Raditz
		Aura="Red"
		Race="Saiyan"
		icon='Raditz.dmi'
		BeamSpecial=new/CharSpecials/Watch_the_Birdie
		New()	Transes=list(cTrans('RaditzSS3.dmi',500000))
	Saibaman
		Aura="Green"
		Race="Creature"
		icon='Saibaman.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Nappa
		Aura="Red"
		Race="Saiyan"
		icon='Nappa.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Guldo
		Aura="Green"
		Race="Alien"
		icon='Guldo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Burter
		Race="Alien"
		icon='Burter.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Jeice
		Aura="Red"
		Race="Alien"
		icon='Jeice.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Recoome
		Race="Alien"
		icon='Recoome.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Captain_Ginyu
		Aura="Red"
		Race="Alien"
		icon='CaptainGinyu.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Henchman
		Race="Alien"
		icon='FriezaHenchman.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Zarbon
		Race="Alien"
		icon='Zarbon.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Dodoria
		Aura="Red"
		Race="Alien"
		icon='Dodoria.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Frieza
		Aura="White"
		Race="Alien"
		icon='Frieza.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
		New()	Transes=list(cTrans('FriezaForm3.dmi',250000),cTrans('FriezaForm4.dmi',500000))
	Cooler
		Aura="White"
		Race="Alien"
		icon='Cooler.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Cell
		Aura="Green"
		Race="BioAndroid"
		icon='Cell.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('CellForm2.dmi',100000),cTrans('CellPerfectForm.dmi',750000))
	Cell_Jr
		Race="BioAndroid"
		icon='CellJr.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
	Android_19
		Race="Android"
		icon='Android19.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Android_17
		Race="Android"
		icon='Android17.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Dabura
		Aura="Red"
		Race="Demon King"
		icon='Dabura.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	Babidi
		Race="Alien"
		icon='Babidi.dmi'
		BeamSpecial=new/CharSpecials/Goten_KameHameHa
	Buu
		Race="Pink"
		icon='SuperBuu.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
		New()	Transes=list(cTrans('KidBuu.dmi',750000))
	Omega_Shenron
		Aura="White"
		Race="Dragon"
		icon='OmegaShenron.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell

	King_Piccolo
		Aura="Green"
		Race="Namekian"
		icon='KingPiccolo.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon
	General_Tao
		Race="Human"
		icon='GeneralTao.dmi'
		BeamSpecial=new/CharSpecials/Falcon_Punch

	Salza
		Race="Alien"
		icon='Salza.dmi'
		BeamSpecial=new/CharSpecials/Special_Beam_Cannon

	Bardock
		Race="Saiyan"
		icon='Bardock.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
		New()	Transes=list(cTrans('BardockSS1.dmi',100000),cTrans('BardockSS4.dmi',750000))
	Tora
		Race="Saiyan"
		icon='Tora.dmi'
		BeamSpecial=new/CharSpecials/KameHameHa
	King_Vegeta
		Race="Saiyan"
		icon='KingVegeta.dmi'
		BeamSpecial=new/CharSpecials/Galick_Gun
		New()	Transes=list(cTrans('KingVegetaSS.dmi',100000),cTrans('KingVegetaSS2.dmi',250000))
	Broly
		Aura="Green"
		Race="Saiyan"
		icon='Broly.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell
		New()	Transes=list(cTrans('NightmareBroly.dmi',100000,NewCA="Green"),cTrans('BrolySS1.dmi',250000),cTrans('BrolySS3.dmi',500000))
	Janemba
		Aura="Red"
		Race="Alien"
		icon='Janemba.dmi'
		BeamSpecial=new/CharSpecials/Blaster_Shell