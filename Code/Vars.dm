var
	list/ChatRooms=list("ChatPaneClan"=list(),"ChatPaneRP"=list())
	list/CompletedProcs=list()
	list/MissionZs=list(5,6)
	list/Players=list()
	PlayerLimit=999
	LogoutLink
	MotD
	GameVersion=76
mob/proc/GetRebirthLevel(/**/)
	return src.Level+(src.GetTrackedStat("Character Rebirths",src.RecordedTracked)*999999)

mob/var
	Team
	mob/Owner
	PowerMode="Both"
	ChatPane="ChatPaneGlobal"
	PreferredPowerMode="Both"
	IgnoreDuels=0
	Charging=0
	InCombat=0
	//GuardLeft=100
	//GuardBroken=0
	GuardTapping=0
	GuardTapCooling=0
	TeleCountering
	TeleCounteringID
	LastBlast=0
	LastAttack
	PoweringUp=0
	CanRecover=1
	HitStun=0
	Attacking=0
	ComboCount=0
	BeamOverCharge=0
	StrongAttacking=0
	StrongAttackCharge=0
	KoCount=0
	CurTrans=0
	datum/TransDatum/TransDatum
	mob/Target
	mob/ThrownBy
	ThrownDamage
	KbType="DeathKB"
	InstanceLoc
	PreInstanceLoc
	obj/TurfType/Instances/InstanceObj
	PlayTimeTicks	//was used in TickLoop, kept around for playtime conversions
	PlayTimeSeconds
	PlayTimeMinutes
	PlayTimeHours
	list/Targeters=list()
	mob/SparringPartner
	obj/Characters/Character
	list/CapsuleChars
	list/OnlineFriends
	list/Friends
	GhostMode=0
	ITing=0
	LastOnline

	Title	//Medal Based Title
	IsDead

	VolumeMuteAll=0
	VolumeEffect=100
	VolumeVoice=100
	VolumeMenu=100
	VolumeMusic=100

	Level=1
	Exp=0
	PL=1000
	MaxPL=1000
	Ki=1000
	MaxKi=1000
	Str=100
	Def=50
	Zenie=0
	BankedZenie=0
	TraitPoints=0	//Stat Points Now
	PerkPoints=0
	Alignment=50
	Traits	//Stats Now
	DamageMultiplier=1.0
	tmp/SelectedPerk
