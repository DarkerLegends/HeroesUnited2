mob/verb/ViewCredits()
	set hidden=1
	usr<<""
	usr<<"Original Concepts and Designs: Funimation"
	usr<<"Programming: Strai"
	usr<<"Most Graphics: GBA's Legacy of Goku"
	usr<<"New Icons (to HU2): http://www.Picceta.com"
	usr<<"Special Thanks to:"
	usr<<"Gebbo for Helping Test"
	usr<<"Tenza for ReDesigning the HUD"
	usr<<"SS57goku for Linking to Map Packs"
	usr<<"Boronks23 for Providing Additional Graphics"
	usr<<"Everyone in the Updates for Contributing Icons, Bug Reports, and Suggestions!"
	usr<<"Falacy for creating HU2"
	usr<<"ZIDDY99 For continuing HU2"
	usr<<"Hassanjalil for helping me continue HU2!"
	usr<<"Darker Legends for letting me use his VPS and helping me continue it!"
	usr<<""
mob/verb
	ViewUpdates()
		set hidden=1
		src<<browse({"
			<title>HU2 Update Notes</title>
			<body link=blue alink=blue vlink=blue>
			<font face="Arial Unicode MS" size=2 color=[rgb(0,150,180)]>

			Recent Updates - Most Recent at Top<br>
			<b>Help Keep the Game Running Smoothly<br>
			Post any Bugs you Find on the Forums</b><br>
			<a href="http://www.byond.com/members/ZIDDY99/forum" target="Z">Report A Bug</a><p>

			24-12-11<br>
			-Version 84<br>
            -Fixed Spelling on defense.<br>
            -Remove Duels until further notice<br>
            -Removed some medals<br>
            -Added Dballs on map<br>
            -Fixed tourny bug<br>
            -Fixed serious cpu and lag issues<br>
            -Added gone afk and return from afk message.<p>


			12-11-11<br>
			-Version 83<br>
			-Removed rush combo<br>
			-Fixed dueling<p>

			10-11-11<br>
			-Version 82<br>
			-Added song in background ( If sound is muted and unmuted, the song won't play )<p>

			07-11-11<br>
			-Version 81<br>
			-Made dueling impossible on instant maps<br>
			-Removed capsule characters<p>

			05-11-11<br>
			-Version 80<br>
			-Removed you can't send messages with links! Filter<br>
			-Removed byond:// filter<br>
			-Removed carriage return filter<p>

			04-11-11<br>
			-Verson 79<br>
			-Removed offensive filter<br>
			-In process of changing sub system<br>
			-Edited a little bit of systems<br>
			-Re-added Focus training<br>
			-Added Timme as GM<br>
			-Added Tmx85 as GM<br>
			-Changed sub list<br>
			-Edited focus training system<p>

			03-11-11<br>
			-Version 78<br>
			-Readded Duels<br>
			-Removed TW<br>
			-Removed CW<br>
			-Removed Focus Training<br>
			-Removed Guardbar<br>
			-Removed Gloabl Mute system<br>
			-Removed FC and FS<br>
			-Removed DB Appearing on map<br>
			-Increased size on Update log<br>
			-Changed font on Update Log<br>
			-Removed Lag window popping up everytime you say Lag<p>

			??-??-??<br>
			-Version 77<br>
			-Changed Fusion Names to be Key Based<br>
			-Changed Capsule AI to Target Assist Owners<br>
			-Changed All Output Controls to 100 Max Lines<br>
			-Changed Guard Meter to Effect Movement Speed (Fzero30)<br>
			-Disabled Turf Animations<br>
			-Disabled IT while Carrying Flags<br>
			-Fixed Bugs:<br>
			* Getting KOed in Ghost Mode<br>
			* Max IT Range was 1 Tile Short<br>
			* IT Status not Setting when ITing<br>
			* Halos Never Clearing (CoolTom1337)<br>
			* WT Locating after Instancing (Cc-p)<br>
			* ITing while Beam Battling (Multiple)<br>
			* IT Cheating for WT Face Offs (Multiple)<br>
			* ITing Long Distances in Restricted Zones (NicolePhree)<p>

			03-08-11<br>
			-Version 76<br>
			-Added Perk: Flash Combo<br>
			-Added Spent Clan Exp Tracking<br>
			-Added a Reason on Leech Exp Gains<br>
			-Added Friend & Watcher Info at Login<br>
			-Added Systems to Reset Clan Exp/Upgrades<br>
			-Added an Effect when Guarding Tele Counters<br>
			-Added Guard Damage when Blocking Tele Counters<br>
			-Changed Description on Energy Boost Perk<br>
			-Changed all while(src) loops with while(1)<br>
			-Changed ResetOverlays() to SetupOverlays()<br>
			-Changed All Clan Upgrades to Cost 10x Less<br>
			-Changed Leech Exp to Clan Leech (KingNaman)<br>
			-Changed the No Repeat Filter to Exact Messages<br>
			-Changed Directional Calculations on Tele Counters<br>
			-Changed Focus to Map after Unlocking Char Capsules<br>
			-Changed Team Reset from ExitCP to Exiting Ter.Wars<br>
			-Disabled AI Following while in Party WTs<br>
			-Disabled HUD X Usage for Exiting Ter.Wars<br>
			-Fixed RunTime Error from Viewing Clans and Ranks<br>
			-Fixed Bugs:<br>
			* Clan Upgrade Buttons Missing a Space<br>
			* Not Gaining Ki when Attacks were Blocked<br>
			* Item Drops Never Disappearing (KingNaman)<br>
			* Hold Charge Working Without a Full Charge<br>
			* Char Capsules Only Unlocking on Boss Kills<br>
			* Unlocking Vegeta's Char Capsule (KingNaman)<br>
			* Clan Upgrade Buttons not Showing Correct Info<br>
			* AIs not Acquiring WT Targets after Owner Dies<br>
			* Training Exp Resetting with Gravity On (Mner2)<p>

			02-18-11<br>
			-Version 75<br>
			-Added New Clan Upgrades<br>
			-Added Clan Exp Bonus from TW Flags<br>
			-Added NPC Guards in Territory Wars<br>
			-Added Fully Customizable Clan Ranks<br>
			-Added Clan Exp for Clearing Missions<br>
			-Added Character Capsules: Nappa, Vegeta<br>
			-Added New Perks: Hold Charge, Combat Shield<br>
			-Changed Logic Order in CanPVP<br>
			-Changed Double Tap Sprint Time<br>
			-Changed how Movement is Handled<br>
			-Changed Teams to Reset in ExitCP<br>
			-Changed Clan Upgrades Tab's Layout<br>
			-Changed Healing Blasts to Recover from KO<br>
			-Changed HUD X to Also Quit Missions (101kenny)<br>
			-Changed IT KameHameHa Perk: Beam Must be Fully Charged<br>
			-Disabled Joning Parties During WT<br>
			-Disabled Guard Recharge during HitStun<br>
			-Disabled Guard Recharge when Invincible<br>
			-Removed Clan Logging of Every Exp Point Gain<br>
			-ReEnabled Dueling - Source of CPU Fail UnKnown<br>
			-Fixed RunTime Error from Tele Countering Melees<br>
			-Fixed RunTime Error from UnTargetted Guard Meters<br>
			-Fixed RunTime Error from Training Tutorial Logouts<br>
			-Fixed Bugs:<br>
			* AI Going Berserk<br>
			* Enemy Locations not Resetting<br>
			* Default Enemy Guard Meter Display<br>
			* AI Always Canceling Strong Attacks<br>
			* Tele Counters Disabled by Guard Meter<br>
			* Enemy Guard Meters Not Updating Properly<br>
			* Guard Escaping From Situations (Joshua m)<br>
			* Guard Break Hits when Invincible (Fzero30)<br>
			* Fusion Guard not Recharging (The Final Duelist)<p>

			01-25-11<br>
			-Version 74<br>
			-Added Guard Meter Systems<br>
			-Added Free Scale Map Mode<br>
			-Added ToolTips to Basic HUD<br>
			-Added F1 Macro for Tutorials<br>
			-Added PMing by Right Clicking<br>
			-Added KO State for Great SaiyaGoku<br>
			-Changed how Guard Break KBs Work<br>
			-Changed Ignore Menus to be Checkable<br>
			-Changed Toggle Invite Menus to Ignores<br>
			-Changed how Strong Attacks Break Guard<br>
			-Changed mouse_opacity on HUD Text and Bars<br>
			-Minor Tweaks to Various Systems<br>
			-ReNamed Large Icons to Normal Icons<br>
			-Removed Attack Delay Caused by Guarding<br>
			-Fixed RunTime Error from UnOwned TW Tiles<br>
			-Fixed Bugs:<br>
			* Focus Reset After Fusions<br>
			* Companion Positioning in WTs<br>
			* SpamGuard not Logging Messages<br>
			* Inaccessible Ignore Clans Command<br>
			* AI not Attacking Guarding Opponents<br>
			* No Enemy Damage Multipliers (Fzero30)<p>

			01-17-11<br>
			-Version 73<br>
			-Added Volume Options<br>
			-Added PM Sound Effect<br>
			-Added Part: Blank Chip<br>
			-Added Item Info ToolTips<br>
			-Added Counter Counters to AI<br>
			-Added Missions: Buu is Hatched!<br>
			-Added Tutorial Tip: Changing Characters<br>
			-Changed Add Friend to Friend<br>
			-Changed Party Invite to Party<br>
			-Changed AI Beam Battle Triggers<br>
			-Changed TW Capture Announcements<br>
			-Changed DB Collection Sound Effect<br>
			-Changed RGB Chips to Advanced Parts<br>
			-Changed how Mission Enemies are Stored<br>
			-Changed Collector Medal to Completionist<br>
			-Changed Sparring Partners to Random Characters<br>
			-ReEnabled Dueling Partially<br>
			-ReNamed Frieza Henchman to Henchman<br>
			-ReEnabled Flag Wars without Rewards<br>
			-Reduced Chance of Advanced Parts Dropping<br>
			-Fixed Bugs:<br>
			* Companions Still Dropping Loot<br>
			* Building in UnOwned Territories<br>
			* Teleport Counters Rarely Triggering<br>
			-Fixed RunTime Error from Fusions Collecting DBs<p>

			01-14-11<br>
			-Version 72<br>
			-Added Parts Inventory Stat<br>
			-Added Item/Part Loot Drops<br>
			* Part Icons by Andyextreme42king<br>
			-Added Territory Wars Capturing<br>
			-Changed Options Menu Layout<br>
			-Changed TW Mining Restrictions<br>
			-Changed Materials Tab to Inventory<br>
			-Changed how DragonBalls are Collected (Shiver08)<br>
			-Disabled Summoning Capsule Characters while Fused<br>
			-Minor Tweaks to Various Systems<br>
			-Removed the Damage Boost from Super Saiyan 5<br>
			* Damage Boost Still Exists on Ultimate Power Perk<br>
			-Fixed Bugs:<br>
			* Companions Dropping Loot<br>
			* Attempted Focus Fix for PMs<br>
			* Medals with 's Display Error<br>
			* Chat Room Who Lists MultiListing<br>
			* Royale Winner Settings (Shiver08)<br>
			* Dismissing NPCs During Beam Battles<br>
			* Target Names Showing @key (Shiver08)<br>
			* Changing Ki Blasts when Fused (KingNaman)<p>

			01-05-11<br>
			-Version 71<br>
			-Added Private Messages<br>
			-Added Chat Click Options<br>
			-Added Clan Rename Upgrade<br>
			-Added Chat Room Who Lists<br>
			-Added Clear Clan Log Button<br>
			-Added Attack Delay after Blocking<br>
			-Added Wish Display in Stats Tab (Ganing)<br>
			-Changed WT PvP Check to Battle Only (SetsunaTheGundam)<br>
			-Disabled Duels for CPU Usage<br>
			-Minor Tweaks to Various Systems<br>
			-ReAnimated Cloud & Water Movement (Da-4orce)<br>
			-Fixed Bugs:<br>
			* AI Team Targeting<br>
			* Companions not Losing WTs<br>
			* Materials Saving after Loading<br>
			* Defusing Inside the Ring (Mner2)<br>
			* Year+ Date Reporting (Ocean King)<br>
			* Clan Management Changes not Logging<br>
			* Companions Dismissing for Party WTs<br>
			* Changing Clan Ranks after Leaving Clans<p>

			12-25-10<br>
			-Version 70<br>
			-Christmas!<br>
			-Added Characters:<br>
			* Zarbon (Da-4orce)<br>
			* Dodoria (Da-4orce)<br>
			* SS2 Goten (Da-4orce)<br>
			-Added More Info to Clan List<br>
			-Added Restricted Font Systems<br>
			-Added Clicking a Party Icon to Set Target<br>
			-Changed Speed of Homing Blasts<br>
			-Changed TW Lava to UnCollectable<br>
			-Changed TW Info onto the Interace<br>
			-Minor Tweaks to Various Systems<br>
			-Ran a Global Respec on Rebirthed Characters<br>
			-Fixed Bugs:<br>
			* Initial HUD Text not ReDrawing<br>
			* Speed not Effecting Homing Blasts<br>
			* Relogging into Instances (Ocean King)<br>
			* Character Rebirths not Saving (Joshua m)<br>
			* First Collected TW Material not Counting<br>
			* HUD Displaying name@key on Login (Shiver08)<p>

			12-24-10<br>
			-Version 69<br>
			-Added Characters:<br>
			* Babidi (Da-4orce)<br>
			* Cooler (Da-4orce)<br>
			* SS1 Adult GT Goku (Da-4orce)<br>
			* SS2 Adult GT Goku (Da-4orce)<br>
			-Added GSG Trans for Videl<br>
			-Changed Ghost CanBeHit<br>
			-Changed Tele Counters to be Blockable<br>
			-Changed Healing Blasts to Cost PL (KingNaman)<br>
			-Disabled Clan Wars<br>
			-Minor Tweaks to Various Systems<br>
			-Ran a Global Character Respec<br>
			-Removed Duel Flags Again<br>
			-Removed C key Counter Attacks<br>
			-Removed Clan Exp Earns from the Clan Log<br>
			-ReEnabled Duels (Still Testing CPU Usage)<br>
			-Fixed Tele Countering after Extended Guarding<br>
			-Fixed Exploit with Entering TW During WTs (Sonic2231)<br>
			-Fixed RunTime Error with Fusion FW Registration<br>
			-Fixed Bug with Rebirth Levels and Respecs (Brembo)<br>
			-Fixed Bug with Clan Last Online Display (KingNaman)<br>
			-Fixed Bug with Balanced Damage when Dueling in PvP Instances (SetsunaTheGundam)<p>

			12-17-10<br>
			-Version 68<br>
			-Changed FW Flags per Entrant<br>
			-Changed Flag Score Respawn Time<br>
			-Changed When Tele Counters Trigger<br>
			-Changed Tele Counters Against Walls<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Level Rewards from Medals<br>
			-Fixed RunTime Error from Opening the MiniMap<br>
			-Fixed Bug with Online Members Window Popping Up<br>
			-Fixed Bug with Teen Gohan's Charging Icon (N27flame)<br>
			-Fixed Bug with Flags Resetting while Captured (Jamie.ds)<br>
			-Fixed Bug with FW MiniMap Not Showing (The Final Duelist)<p>

			12-15-10<br>
			-Version 67<br>
			-Added Chat Tabs<br>
			-Added Last Online Date Systems<br>
			-Added Reason Display on Flag Dropping<br>
			-Added Clan Wars Registration Restriction by ID<br>
			-Changed Wish Announcement Info Layout<br>
			-Changed Toggle Invites to Toggle Clans<br>
			-Changed Toggle Clans from Tab to Menu Bar<br>
			-Changed Territory Wars to Spawn in as Ghost<br>
			-Changed Flags to Reset Position when Dropped<br>
			-Changed Flags to Spawn 1 for every 6 Entrants<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Clan Chat from Clan Interface<br>
			-Fixed Bug with FW MiniMap Showing After FWs<br>
			-Fixed Bug with Blue Flag Alignment (Jamie.ds)<br>
			-Fixed Bug with FW MiniMap Appearing Under Water<br>
			-Fixed Bug with GenericInstance Death Announcements<br>
			-Fixed Bug with Companions and Mission Clearing (Nicole Phree)<p>

			12-13-10<br>
			-Version 66<br>
			-Added PvP Flight Collision<br>
			-Added Territory War Systems<br>
			-Added New Info to Flag Wars Alert<br>
			-Changed Companion FoE Targeting AI<br>
			-Changed Zenie LifeSpan to Randomize<br>
			-Changed ScoreBoard Levels to FullNum<br>
			-Changed Flag Score Message to Everyone<br>
			-Changed Failed Trans Sound to User (Jamie.ds)<br>
			-Removed the UnShakable Perk<br>
			-Fixed Bug with Leaving Parties Quitting CWs<br>
			-Fixed Bug with WT Ring Outs During CWs (Flysbad)<br>
			-Fixed Bug with Initial HUD Writes not Logging Text<br>
			-Fixed Bug with Rank Changes Quitting CWs (Shiver08)<br>
			-Fixed Bug with UnShakable Negating Flag Drops (Multiple)<p>

			12-11-10<br>
			-Version 65<br>
			-Added Medals:<br>
			* Flag Bearer<br>
			* Flag Buddies<br>
			-Added Stat Tracking:<br>
			* Flag Drops<br>
			* Flag Scores<br>
			* Flag Captures<br>
			* Clan Exp Earned<br>
			-Added Green Numbers for Healing<br>
			-Added Clan Interface Exp Display<br>
			-Added an Alert about Flag War Goals<br>
			-Added Black & White Flag Wars Flags<br>
			-Added 10 Sec LifeSpan on Homing Blasts<br>
			-Added Clans on Capture & Drop in Flag Wars<br>
			-Changed Hit Stun to Cause Flag Drop<br>
			-Changed Flag War Messages to Entrants Only<br>
			-Changed Speed when Carrying Flags (N27flame)<br>
			-Changed Player Position to Update when Zoning<br>
			-Disabled Powering while Teleport Countering<br>
			-Disabled IT To in All PvP Instances (N27flame)<br>
			-Replaced Flag Wars Arrows with a MiniMap<br>
			-Fixed Bug with "0 has Dropped a Flag"<br>
			-Fixed Bug with Clan Wars Entrants Display<br>
			-Fixed Bug with Only Healing Party Members<br>
			-Fixed Bug with ReJoining Missions after WTs<br>
			-Fixed Bug with Non-Damaging Throws Animating<br>
			-Fixed Bug with Clan Wars Stealing WT Entrants<br>
			-Fixed Bug with Balanced Clan PvP Friendly Fire (Multiple)<p>

			12-09-10<br>
			-Version 64<br>
			-Added IT To Player<br>
			-Added Clan Wars Systems<br>
			-Added Key Holding Systems<br>
			-Added Strong Attack Queuing<br>
			-Added Clan Wars Mode: Flag Wars<br>
			-Added KOed State to Super Trunks<br>
			-Added Dismiss to the Capsule Menu<br>
			-Added Stat Tracking:<br>
			* Medals Earned<br>
			* Perks Unlocked<br>
			* Companion Kills<br>
			* Characters Unlocked<br>
			* Levels from 'Reason'<br>
			-Changed Auto WTs to 10 Minutes<br>
			-Changed NPCs to Dismiss for WTs<br>
			-Changed NPCs to Dismiss when AFK<br>
			-Changed Precedence of Powering Up<br>
			-Changed Strong Attack Restrictions<br>
			-Changed realtime uses to timeofday<br>
			-Changed All Broly Fusions to Broku<br>
			-Changed islist() to istype(var,/list)<br>
			-Changed Homing Ki Blast Flight Collision<br>
			-Changed Fusions of Vegeta and Trunks to Vegetrunks<br>
			-Minor Tweaks to Various Systems<br>
			-Replaced Server Link with Time Zone<br>
			-Fixed Bug with NPCs Replacing WT Parties<br>
			-Fixed Bug with Capsule Characters DeListing<br>
			-Fixed Bug with Suffixes not Updating on Level<br>
			-Fixed Bug with Fusion Respawns (Falcon lazorz)<br>
			-Fixed Bug with PowerUp Restrictions (Mastermrgt)<br>
			-Fixed Bug with IT Powering Still Working (Joshua m)<p>

			12-08-10<br>
			-Version 63<br>
			-My Birthday Today!<br>
			-Added CanMove() Checks<br>
			-Added New Ki Blast Types<br>
			-Added Ghost Respawn Mode<br>
			-Added Friend List Systems<br>
			-Added Subscribe HUD Button<br>
			-Added Capsule Character Systems<br>
			-Added Online Members to Clan Chat<br>
			-Added +1 Daily Wishes for Subscribers<br>
			-Added Buttons on Clan Member Management<br>
			-Added Perks:<br>
			* Pull<br>
			* Pickpocket<br>
			-Added Medals:<br>
			* Thief<br>
			* Medic<br>
			* Friendly<br>
			* Millennial<br>
			* Ghost Buster<br>
			-Added New Tutorial Tips:<br>
			* Ki Blast Types<br>
			* Capsule Characters<br>
			-Added Capsule Characters:<br>
			* Goku<br>
			* Raditz<br>
			* Piccolo<br>
			* Saibaman<br>
			-Added Characters:<br>
			* Turtle (Multiple)<br>
			* SS5 Goku (Tristen33)<br>
			* Vegetrunks (Da-4orce)<br>
			* Teen Gohan (Da-4orce)<br>
			* USS SA Goku (Da-4orce)<br>
			* SS SA Trunks (Ismel01)<br>
			* SS GT Trunks (Mateus69)<br>
			* Super Buu (Timme557711)<br>
			* Alt Vegeta (Sayainarsil)<br>
			* USS SA Trunks (Da-4orce)<br>
			* SS3 SA Trunks (Da-4orce)<br>
			* SS Vegetrunks (Da-4orce)<br>
			* SS Alt GT Vegeta (Kakarots)<br>
			* Alt GT Vegeta (Timme557711)<br>
			* Tora (Sayainarsil/Da-4orce)<br>
			* SS2 Alt Vegeta (Saiyanarsil)<br>
			* Scouter Vegeta (Sayainarsil)<br>
			* SS Super Trunks (Crackenguy)<br>
			* SS Yardrat Goku (Sayainarsil)<br>
			* SS2 Super Trunks (Principe Gui)<br>
			* SS GT Vegeta (Mateus69/Da-4orce)<br>
			** All Icons Since Last IconShare Wipe<br>
			-Changed how NPC AI Finds Targets<br>
			-Changed Janemba's Face (Shiver08)<br>
			-Changed NPC Power Mode to Ki Only<br>
			-Changed default_verb_category to null<br>
			-Changed Default Clan Tab to Clan Chat<br>
			-Changed Reverting to Consume 1 Ki Bar<br>
			-Changed Formatting of PlayTime Display<br>
			-Changed Mission Boss to Scouter Vegeta<br>
			-Disabled Powering while ITing (Multiple)<br>
			-Improved NPC Combat AI<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Revive from Commands Tab<br>
			-Removed Q&R For Ki Blast Switching<br>
			-Fixed Bug with MainWindow Size at Login<br>
			-Fixed Bug with Step Reverting (Buzcut1910)<br>
			-Fixed Bug with Average PlayTime not Rounding<br>
			-Fixed Bug with Hub ScoreBoard Medal Processing<br>
			-Fixed Bug with MiniMap not Updating when Zoning<br>
			-Fixed Bug with ITing on Restricted Maps (Fzero30)<br>
			-Fixed Bug with Clans not Displaying All Members (Multiple)<br>
			-Fixed Bug with UnShakable Negating Strong Attacks (Joshua m)<br>
			-Fixed Bug with Clan Kicks Only Logging Online Members (KingNaman)<p>

			11-30-10<br>
			-Version 62<br>
			-Added Clan Log TimeStamps<br>
			-Added Graphical HitStun from Teleport Counters<br>
			-Nerfed IT KameHameHa Perk:<br>
			* Removed Full Charge Damage Bonus<br>
			* IT Beams can be Blocked and Countered<br>
			-Changed Perks to Sort A-Z Instead of Z-A<br>
			-Changed ScoreBoard from Top 10 to Top 100<br>
			-Changed the Clan Members Grid to a Browser<br>
			-Changed SS4 GT Goku's KameHameHa (N27flame)<br>
			-Changed Clan Chat to Display Rank (KingNaman)<br>
			-Changed ScoreBoard to Rebirth Levels (KingNaman)<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Bug with Fusion Transformations<br>
			-Fixed Bug with Logging Clan Color Changes<br>
			-Fixed Bug with Wish Window Saying 100 Clan Exp<br>
			-Fixed Bug with Clan Contributor Medal (KingNaman)<br>
			-Fixed Bug with Party Names not Updating (Eric961996)<br>
			-Fixed Bug with Strong Attacks not Passing HitStunner<br>
			-Fixed Bug with Transforming While Training (Eric961996)<br>
			-Fixed Bug with Transforming not Completing the Tutorial<p>

			11-29-10<br>
			-Version 61<br>
			-Added New Wishes<br>
			-Added Clan Exp Systems<br>
			-Added Clan Logs (Tmx85)<br>
			-Added New Tutorial Tips<br>
			-Added AFK Stat Panel Mode<br>
			-Added Step Revert with Ctrl+Z<br>
			-Added Missing Outline on P1 HUD BG<br>
			-Added Hercule City Bank (Ssj1recount)<br>
			-Added Medals Earned to the ScoreBoard<br>
			-Added Perks Unlocked to the ScoreBoard<br>
			-Added Full Transform with Shift+A (N27flame)<br>
			-Added Medals:<br>
			* Reborn<br>
			* Perkfect<br>
			* Collector<br>
			* Duelicious<br>
			* Even Lazier<br>
			* Focused Trainer<br>
			* Clan Contributor<br>
			-Added Perks:<br>
			* IT KameHameHa (Goku1515)<br>
			* Intense Training (Muhuhahahaha)<br>
			-Added Characters<br>
			* Salza (Da-4orce)<br>
			* SS3 Raditz (Cc-p)<br>
			* SS3 Trunks (AntM)<br>
			* SS4 Trunks (Keane00100)<br>
			* SS1 Prince Vegeta (Cc-p)<br>
			* Saiyan Armor Trunks (Mner2)<br>
			-Changed HUD Layout<br>
			-Changed Clan Interfaces<br>
			-Changed PlayTime Tracking<br>
			-Changed Wish Window Display<br>
			-Changed Perks to Sort by Name<br>
			-Changed Full Revert to Shift+Z<br>
			-Changed Step Transform to Ctrl+A<br>
			-Changed How Training Exp is Earned<br>
			-Changed Collected DBs to Hide on MiniMap<br>
			-Changed Millionaire Medal to Banked Zenie<br>
			-Changed Damage Multiplier Boost Based on Trans PL<br>
			-Disabled Strong Attacks while Training (ZIDDY99)<br>
			-Improved Functionality of Teleport Countering<br>
			-Minor Tweaks to Various Systems<br>
			-ReAdded Clan Chat in the Clan Interface<br>
			-Removed the Wide Awake Perk<br>
			-Fixed Bug with Deaths in Party WTs<br>
			-Fixed Bug with Green & Red Flight Auras<br>
			-Fixed Bug with Teleport Countering (Fzero30)<br>
			-Fixed Bug with Stat Respecs Respeccing Perks (Ocean King)<br>
			-Fixed Bug with Party Tournament Resigns in Single Modes (Cc-p)<br>
			-Fixed Bug with MiniMap DBs when Changing Planets (Minutedude64)<br>
			-Fixed Bug with Hope of the Universe Medal on Kaioken (DarthVegeta)<p>

			11-17-10<br>
			-Version 60<br>
			-Added a Medal Earned Sound Effect<br>
			-Added WT Announcement about full WT Rulings<br>
			-Added 10% Ki Recovery when Hit by a Teleport Counter<br>
			-Added Characters:<br>
			* Uub (Joshua m)<br>
			* Nail (Da-4orce)<br>
			* Olibu (Mateus69)<br>
			* Lord Slug (Da-4orce)<br>
			* GT Krillin (Da-4orce)<br>
			* Omega Shenron (Sayainarsil)<br>
			* Alternate Majin Vegeta (Sayainarsil)<br>
			* Elder Kai Gohan (Corey2447/Timme557711)<br>
			* Nightmare Broly (Oblivion The Light of Power)<br>
			-Changed the Loaction of the HUD Coloring Overlay<br>
			-Changed Throws to Cancel on Teleport Counter Targets<br>
			-Changed PL and Ki to Restore after Missions (KingNaman)<br>
			-Disabled No-Ki WT Power Up Modes<br>
			-Disabled Strong Attacks During Beam Battles (Fastflyer)<br>
			-Fixed Bug with Tournament Ring Density<br>
			-Fixed Bug with Party Tournament Logouts<br>
			-Fixed Bug with Anchors on the WT Window<br>
			-Fixed Bug with Ultimate Power (Eric961996)<br>
			-Fixed Bug with Countering Teleport Counters<br>
			-Fixed Bug with Entrant Count on WT Resigns (Fastflyer)<br>
			-Fixed Bug with DBs not Appearing on the MiniMap (Ocean King)<p>

			11-14-10<br>
			-Version 59<br>
			-Added Characters:<br>
			* SS Broly (Joshua m)<br>
			* SS3 Broly (Da-4orce)<br>
			* Teen Goten (Mateus69)<br>
			* GT Goten (Sayainarsil)<br>
			* Kid Goku (Sayainarsil)<br>
			* Elder Kai Gohan (Cc-p)<br>
			* GT Trunks (Timme557711)<br>
			* Form 3 Freiza (Joshua m)<br>
			* Baby Vegeta (Ssj1recount)<br>
			* Great Saiyagirl (Da-4orce)<br>
			* Pan (Megaman encyclopedia)<br>
			* Adult GT Goku (Timme557711)<br>
			* Prince Vegeta (Sayainarsil)<br>
			* SS Pan (Megaman encyclopedia)<br>
			* Saiyan Armor Bulma (Kakarots)<br>
			* Goku Jr (Timme557711/Mateus69)<br>
			* Great SaiyaGoku (MexicanSaiyan)<br>
			* Shirtless Goku False SS (Crazydude99)<br>
			* Frieza Henchman (Megaman encyclopedia)<br>
			-Changed Flight Shadow Layering<br>
			-Changed the Length of Counter Attacks<br>
			-Changed the SS4 PL Requirement to 750,000<br>
			-Changed Throws to Cancel on Teleport Counter (20xkame)<br>
			-Disabled Guarding while Strong Attacking (Muhuhahahaha)<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Bug with Missing Diagonal Flight Aura Icons<br>
			-Fixed Bug with Royale WTs Getting Stuck (Fastflyer)<br>
			-Fixed Bug with Teleporting if Teleport Counter was Countered<p>

			11-13-10<br>
			-Version 58<br>
			-Added Custom Aura Systems<br>
			-Added a HardCoded Delay on KO Recovery<br>
			-Added 3 Minute Delay between Hosting WTs<br>
			-Added Medals:<br>
			* I Stand Alone<br>
			* Royale Royalty<br>
			-Added Characters<br>
			* GT Goku (Mateus69)<br>
			* Janemba (Sayainarsil)<br>
			* SS1 GT Goku (Mateus69)<br>
			* SS3 GT Goku (Mateus69)<br>
			* Chiaotzu (Sayainarsil)<br>
			* SS4 Gohan (Sayainarsil)<br>
			* Super Goku (Keane00100)<br>
			* Kaioken Goku (Timme557711)<br>
			* Shirtless Goku (Sayainarsil)<br>
			* Alternate SS4 Goku (Zetaxxx)<br>
			-Added Tutorial Tips:<br>
			* Strong Attacks<br>
			* Transformations<br>
			* Instant Transmission<br>
			-Added Tracked Stats<br>
			* Button Combos Failed<br>
			* Button Combos Completed<br>
			-Changed the Team Flag Icons<br>
			-Changed how WT Winners are Determined<br>
			-Changed Strong Attacks to Require Charging<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Perks:<br>
			* Weakling<br>
			* Beam Fanatic<br>
			* KnockBack Resistance<br>
			-Tested Countless Things for CPU Fail<br>
			-Fixed Bug with World Tournament Systems<br>
			-Fixed Bug with Canceled Teleport Attacks<br>
			-Fixed Bug with Multiple Teleport Countering<br>
			-Fixed Bug with SPAM ITing into & out of the WT<p>

			10-25-10<br>
			-Version 57<br>
			-Added New Characters<br>
			* Buu Gohan (Timme557711)<br>
			* ChiChi (Mateus69/Zetaxxx)<br>
			* SS1 Bardock (Sayainarsil)<br>
			* Bojack Gohan (Timme557711)<br>
			* SS1 Bojack Gohan (Timme557711)<br>
			* Black Suit Roshi (Sayainarsil)<br>
			* Adult Piccolo Gohan (Mateus69)<br>
			* Broku (Sayainarsil/Sasukexnaruto)<br>
			* Cell 2nd Form (Mateus69/Sayainarsil)<br>
			-Added Royale WT Mode<br>
			-Added GM Player Limit Settings<br>
			-Extended the Tournament Area<br>
			-ReEnabled set instants=1<br>
			-Version 56<br>
			-Added Perks:<br>
			* Wide Awake<br>
			* Bottled Rage<br>
			* Quick Learner<br>
			* Draining Touch<br>
			* Adrenaline Rush II<br>
			-Added Medals:<br>
			* Sponsor<br>
			* Refunded<br>
			* Split Personality<br>
			* Eternal Dragon (Shadix)<br>
			-Added 1% Return on Ki on Damage<br>
			-Added Team Based World Tournaments<br>
			-Added Player Hosted World Tournaments<br>
			-Added Subscriber Bonus: +0.1 Damage Multiplier (KingNaman)<br>
			-Changed InTournament Checks<br>
			-Changed Fusion Races to Saiyan<br>
			-Changed Color of Equipped Perks<br>
			-Changed MiniMap Updating Systems<br>
			-Changed KO Logic Order in Damage<br>
			-Changed WT Round Time to 3 Minutes<br>
			-Changed WT Register Time to 3 Minutes<br>
			-Changed the Pixel Spread on DamageShow<br>
			-Changed the BG Color on Windows to Black<br>
			-Changed Power Up Mode 'None' to 'Nothing'<br>
			-Changed the Default Duel Type to Balanced<br>
			-Changed Sub Bonuses to Reset on Expiration<br>
			-Changed Taunt & Beam Reflex to Beam Fanatic<br>
			-Changed Player Deaths to Announce Duel Types<br>
			-Changed Party Invites to Limit by computer_id<br>
			-Changed Focus Training to Resume Between Relogs<br>
			-Changed the Damage Bonus for OverCharging Beams<br>
			-Changed AI to 50% Chance of Starting Beam Battles<br>
			-Changed Fully Charged Beams to Beam BreakThrough Effect<br>
			-Changed Beam Battles to UnBlockable/UnCounterable (KingNaman)<br>
			-Disabled all set instants=1 to Test CPU Usage<br>
			-Minor Tweaks to Various Systems<br>
			-Nerfed Energy Shield Perk<br>
			-Ran a Free Perk Respec<br>
			-ReEnabled All Stat Panels<br>
			-Removed Regeneration Perk<br>
			-Removed Beam BreakThrough Perk<br>
			-Removed Turf Animations (AntM)<br>
			-Removed DB Collect from Commands Tab<br>
			-Fixed RunTime Error with Teleport Delays<br>
			-Fixed Bug with Perk Respecs on Open Window<br>
			-Fixed Bug with Balanced Beam Battle Damage<br>
			-Fixed Bug with Damage Displays above 999,999<br>
			-Fixed Bug with AIs Damaging Eachother (20xkame)<br>
			-Fixed Bug with Beam Fanatic not Working (KingNaman)<br>
			-Fixed Bug with Delay in Teleport Countering (Fzero30)<br>
			-Fixed Bug with Stat Respecs Causing Perk Respecs (Cc-p)<br>
			-Fixed Bug with Halos Disappearing on Relogs (Sonicfan22)<br>
			-Fixed Bug with Spirit Crusher not Working Properly (KingNaman)<br>
			-Fixed Typo on Wish Window in Text about Recovering Stats (ZIDDY99)<p>

			10-18-10<br>
			-Version 55<br>
			-Added Perks:<br>
			* Taunt<br>
			* Boost<br>
			* Ki Stun<br>
			* Auto Exp<br>
			* Auto Aim<br>
			* Weakling<br>
			* Rush Combo<br>
			* After Image<br>
			* Regeneration<br>
			* Energy Absorb<br>
			* Training Focus<br>
			* Perpetual Energy<br>
			* Graceful Recovery<br>
			* Beam Reflex (Andyextreme42king)<br>
			* Spirit Crusher (Andyextreme42king)<br>
			-Added Wishing Systems<br>
			-Added Guard Break to Enemy AI<br>
			-Added Over Charged Beam Damage<br>
			-Added Auto Aim to Combo Starters<br>
			-Added Tracked Stats: Wishes Made<br>
			-Added Who List Active Player Count<br>
			-Added Level Points on HUD MouseOver<br>
			-Added Minimum 1 Second Beam Fire Time<br>
			-Added Message about Invalid Clan Names<br>
			-Added Counterable Teleport Counter Delay<br>
			-Added Test Verb to Delete Lost Ki Blasts<br>
			-Added Power Up Mode Options (Beastie123Boys)<br>
			-Changed Format of the Scoreboard Date<br>
			-Changed AI Teleport Counter Rate to 50%<br>
			-Changed Teleport Counters to Deal Damage<br>
			-Changed Subscribe to Show for Subscribers<br>
			-Changed the WT to only Host every 30 Minutes<br>
			-Changed the WT Registration time to 5 Minutes<br>
			-Changed the WT Entrant Info to Globally Update<br>
			-Changed the Fusion Damage Boost to Player Fusions<br>
			-Changed Future Trunks M.fly icon_state (Buzcut1910)<br>
			-Changed WT Entrants to Limit by computer_id (Shadix)<br>
			-Changed Form 4 Freiza's M.fly icon_state (Buzcut1910)<br>
			-Disabled Most Stat Panels<br>
			-Disabled Client Logging System<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Force Del from Ki Blasts<br>
			-Removed AtName Filter from non-mobs<br>
			-Removed the UnShakable Character Setting<br>
			-Removed Message about Finding Dragon Balls<br>
			-Removed Delay from Strong Attacks on Combos<br>
			-Fixed Bug with Hit Checks on Melee Attacks<br>
			-Fixed Bug with null Beam Fire Sound Effects<br>
			-Fixed Bug with Party Member Icons not Updating<br>
			-Fixed Bug with Attacking while Guarding (Fzero30)<br>
			-Fixed Bug with Leave Party Showing in the Commands Tab<br>
			-Fixed Bug with Training Master Medals not Giving Bonuses<br>
			-Fixed Bug with Beam Battle Status Effects (KingNaman/Timme557711)<br>
			-Fixed Bug with Custom Icons not Updating Faces (KingNaman/20xkame)<br>
			-Fixed Bug with Beam Battles in Various Situations (Goku1515/Chibi pq)<br>
			-Fixed Bug with Golden Chest only Appearing in Bottom Left Quadrant (KingNaman)<p>

			10-15-10<br>
			-Version 54<br>
			-Added Debugs for Null HUD Lists<br>
			-Changed Ki Blasts to Forcibly Delete<br>
			-ReEnabled the Main Stat Panel Display<p>

			10-11-10<br>
			-Version 53<br>
			-Changed AI Tele Counters to 20%<br>
			-Disabled Stat Panel to Test CPU Usage<br>
			-Fixed RunTime Error with Fusions Entering WT<br>
			-Fixed Bug with Mission Stat Display while Fused<br>
			-Fixed SS2 King Vegeta's M.fly icon_state (N27flame)<br>
			-Fixed Bug with the WT Announcing Previous WT's Rewards<br>
			-Fixed Bug with WT Ring not Clearing for Round 1 (N27flame)<p>

			10-10-10<br>
			-Version 52<br>
			-Added Characters:<br>
			* GT Vegeta (Sayainarsil)<br>
			* Gotenks SS1 (Sayainarsil)<br>
			* Gotenks SS3 (Timme557711)<br>
			-Added Specials:<br>
			* Goten: KameHameHa<br>
			* Broly: Blaster Shell<br>
			* Krillin: Destructo Disk<br>
			* Raditz: Watch the Birdie<br>
			-Added Tracked Stats:<br>
			* Days Played<br>
			* Days Subscribed<br>
			-Added List Mode to Stat Tracking<br>
			-Added Round# Info to the WT Window<br>
			-Added Daily Subscriber Level Reward<br>
			-Added Tournament Status to WT ToolTip<br>
			-Added Daily Level Reward (Timme557711)<br>
			-Added a +3 Damage Multiplier to Fusions<br>
			-Added Subscriber Display Name Color (Timme557711)<br>
			-Added Arg to Provide a Reason for Gaining Exp/Levels<br>
			-Changed WT Setup to Face-Off<br>
			-Changed Fusion Character Results<br>
			-Changed the Ki Blast's Error Icon<br>
			-Changed Female Keys to Start as Videl<br>
			-Changed Sense Stat Display Processing<br>
			-Changed Fusion Stat Bonus from 1.5 to 2<br>
			-Changed WT to Announce Winner's Rewards<br>
			-Changed WT Reward to 100 Levels per Round<br>
			-Changed Testing Methods for Stuck Ki Blasts<br>
			-Changed Sound Effects for Big Bang KameHameHa<br>
			-Changed Sound Effects on Adult Gohan KameHameHa<br>
			-Changed Logic Order for Accepting Duel Requests<br>
			-Changed all Sound Outputs to be Handled in one proc<br>
			-Changed Fighting Spirit to Disable Guarding (KingNaman)<br>
			-Minor Tweaks to Various Systems<br>
			-ReAdded FullNum() to Stat Panels<br>
			-Removed Default /mob Character Setting<br>
			-Removed Medal: Meet Your Maker (Kaioken)<br>
			-Fixed RunTime Error with WT Watching<br>
			-Fixed Bug with Overlapping Flight Auras<br>
			-Fixed Bug with the Savior Medal (KingNaman)<br>
			-Fixed Bug with Multi-Word Font Faces (Sonicfan22)<br>
			-Fixed Bug with Sound Effects not Playing while Fused<br>
			-Fixed Bug with Tournament Ring Clearing in Different Zones<br>
			-Fixed Bug with the WT only Restoring Stats after the Last Round<br>
			-Fixed Bug with Under Water Ki Blasts Getting Stuck (Timme557711)<br>
			-Fixed Bug with Melee Attacks not Hitting Fighting Spirits (KingNaman)<br>
			-Fixed Bug with Fusions not Clearing the Tournament Ring (Muhuhahahaha)<br>
			-Fixed Bug with Accepting Duels while in the World Tournament (KingNaman)<br>
			-Fixed Bug with Auras if Reverted while Focus Training (Megaman encyclopedia)<p>

			09-30-10<br>
			-Version 51<br>
			-Added a New WT Interface Window<br>
			-Changed Profile to Sense<br>
			-Changed WT ToolTip Description Info<br>
			-Changed WT Reward to at Least 100 Levels<br>
			-Changed HitStun Icon on Bojack Trunks and Yajirobe<br>
			-Changed Moving while Watchin the WT to Restore Focus<br>
			-Disabled Flying in World Tournaments<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Bug with WT Getting Stuck<br>
			-Fixed RunTime Error with Duel Request Logouts<p>

			09-27-10<br>
			-Version 50<br>
			-Added Tournament Watching<br>
			-Fixed Bug with Final WT Round Count<br>
			-Fixed Bug with WT Winner's Level Reward<br>
			-Fixed Bug with Exiting Instances into the WT Ring<br>
			-Version 49<br>
			-Added Medals:<br>
			* Title Defender<br>
			-Added Specials<br>
			* Final Shine<br>
			* Finish Buster<br>
			-Added Characters:<br>
			* Yajirobe (Mateus69)<br>
			* Bojack Trunks (Sayainarsil)<br>
			* Perfect Form Cell (Mateus69)<br>
			-Changed WT HUD ToolTip Description<br>
			-Changed WT HUD Icon to Always Visible<br>
			-Changed WT to Restore the Winner's Stats<br>
			-Changed WT Setup Time from 5 to 10 Seconds<br>
			-Changed WT to Give 25 Levels per Round Won<br>
			-Changed WT to Give 25*Total Rounds for Winning<br>
			-Removed the BulletProof Perk<br>
			-Fixed a RunTime Error where Fusion Parties=0?<p>

			09-24-10<br>
			-Version 48<br>
			* Back From Vacation<br>
			-Added Multiple PowerUp Modes<br>
			-Added a Count Down for WT Rounds<br>
			-Added Scrolling to Clan MotDs (Tmx85)<br>
			-Added Systems to Check for Stuck Ki Blasts<br>
			-Changed WT to Cancel Flying<br>
			-Changed WT to PowerUp Ki Only<br>
			-Changed WT to Cancel Duels (Cc-p)<br>
			-Changed Cancel to ForceCancelTraining<br>
			-Changed ScoreBoard Zenie to a Full Number<br>
			-Changed WT Register Time from 5 to 3 Minutes<br>
			-Changed WT Entrants to Clear when the WT Ends<br>
			-Changed WT Ring to Open until Registration Ends<br>
			-Changed how Players are Cleared from the WT Ring<br>
			-Changed WT to Recover Entrants from KO (KingNaman)<br>
			-Changed Location when Clearing the WT Ring to Random<br>
			-Disabled Accepting Duels while in the World Tournament<br>
			-Removed the Flash Finish Perk<br>
			-Removed FullNums from Stats to Test CPU<br>
			-Removed Dueling Restrictions on Instanced Maps<br>
			-Fixed Bug with Facing when Throws Ended<br>
			-Fixed Bug with Beam Hits not Setting Targets<br>
			-Fixed Bug with Fusion Checks Before Declining<br>
			-Fixed Bug with Sending Multiple Party Invites<br>
			-Fixed Bug with Grass Edges Appearing Under Cliffs<br>
			-Fixed Bug with Canceled Tournaments not Actually Ending<br>
			-Fixed Bug with Loading/Zoning into the WT Ring (Lionsbarragex33/Rooyall/Muhuhahahaha/Megaman encyclopedia)<p>

			08-30-10<br>
			-Version 47<br>
			-Added Zenie Tracking to the Hub ScoreBoard<br>
			-Added Systems to Prevent Multiple Fusion Invites<br>
			-Changed Tournament Round Time Limit to 5 Mins<br>
			-Changed when HUD Alerts will Switch to Fusion Mobs<br>
			-Changed Calls from CancelTraining to ForceCancelTraining<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed RunTime Error with null Beam Hits<br>
			-Fixed Bug with not Ignoring Fusion Invites<br>
			-Fixed Bug with Sending Multiple Duel Requests<br>
			-Fixed Bug with Sending Duel Requests while Fusing<p>

			08-28-10<br>
			-Version 46<br>
			-Added Tracked Stats:<br>
			* WT Rounds Won<br>
			* WT Rounds Lost<br>
			* World Tournaments Won<br>
			-Changed WT to Restore PL and Ki<br>
			-Changed WT Event Time to 10 Mins<br>
			-Changed WT Register Time to 5 Mins<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Bug with Mission Map Density<br>
			-Version 45<br>
			-Minor Tweaks to Various Systems<br>
			-Changed WT to Clear the Ring of Players<br>
			-Changed WT Registration Time to 3 Minutes<br>
			-Changed All HUD Alerts to Remove on Fusion<br>
			-Fixed Bug with HUD Alerts not Clearing<br>
			-Fixed Bug with WT Registration when Fused<br>
			-Fixed Bug with WT Displaying Setup not Round #<br>
			-Fixed Bug with WT Registering after Registration Ends<br>
			-Version 44<br>
			-Added World Tournament Systems<br>
			-Added an AddZenie(Amount) proc<br>
			-Added AddTitle to ResetOverlays<br>
			-Added density Setting to Map Edges<br>
			-Added Teleport Counter to Beam Attacks<br>
			-Added Medals:<br>
			* World Champion<br>
			-Added Character Specials<br>
			* Big Bang Attack (Timme557711)<br>
			* Gohan KameHameHa (Timme557711)<br>
			* Big Bang KameHameHa (Timme557711)<br>
			-Changed Fly State for GSM Trans 1<br>
			-Changed Gogeta and Vegito to use BBK<br>
			-Changed the Stat Points Tutorial Tip<br>
			-Changed SA SS/Vegeta to Big Bang Attack<br>
			-Changed the Location of the Level Arrow<br>
			-Changed how HBTC Verbs are Added (Quazz)<br>
			-Changed the Tick Count in Focus Training<br>
			-Changed Goten to Use Kid Gohan KameHameHa<br>
			-Changed Charge Icon State on USS SA Vegeta<br>
			-Changed All Adult Gohans to Gohan KameHameHa<br>
			-Changed Counter Attack & Combo Finisher Distance<br>
			-Changed Flight to Match when DeFusing (Darker Legends)<br>
			-Removed Forced Deletion from HUD Popups<br>
			-Removed Duel Requests when Fusing/DeFusing<br>
			-Fixed Bug with Ki Blasts Stuck in the HBTC<br>
			-Fixed RunTime Error with Fusions Ending Duels<br>
			-Fixed Bug with Stat Based Duel Flag Icon State Name<p>

			08-19-10<br>
			-Version 43<br>
			-Added CanBeHit to Damage()<br>
			-Added Datum Profiling Systems<br>
			-Added invisibility Check to CanBeHit<br>
			-Changed Duels to Cancel when DeFusing<br>
			-Changed how HBTC Training verbs are Added<br>
			-Fixed RunTime Errors with Fusions Dueling<br>
			-Fixed Bug with Training while DeFusing (Ocean King)<br>
			-Fixed Bug with Player Counts when Fusing in Instances<p>

			08-13-10<br>
			-Version 42<br>
			-Fixed Bug with Bursting while Fusing<br>
			-Fixed Bug with DeFusion Flying (Sayainarsil)<br>
			-Fixed Bug with Training and Fusing (Fzero30)<br>
			-Fixed Bug with Fusion Name Displays<br>
			-Fixed Bug with Fusing while Dueling (Quazz)<br>
			-Fixed Bug with Accepting Duels when Fused<br>
			-Fixed Bug with DeFusing in Instances/Missions<br>
			-Fixed Bug with CanBeHit Check Stopping Beam Damage<p>

			08-12-10<br>
			-Version 41<br>
			-Added an IsDead Variable<br>
			-Added CanHit Checks to PvpCheck<br>
			-Added Halos when Dead (Icecold8)<br>
			-Changed SnakeWays Mapping/Locations<br>
			-Changed Sprinting from a Movement State<br>
			-Disabled HitStun when Sprinting Into Walls<br>
			-Removed the Single Duel Request Limit (???)<br>
			-Fixed Bug with Fusions in Parties<br>
			-Fixed Bug with Fusing with Yourself<br>
			-Fixed Bug with Interactions while Fused<br>
			-Fixed Bug with Fusing while Already Fused<br>
			-Fixed Bug with AI Opening Chests (Multiple)<br>
			-Fixed Bug with Fusion Checks on Fussion Accept<br>
			-Fixed Bug with Fusions Entering/Exiting Instances<br>
			-Fixed Bug with Sub Overlays not Resetting (Timme557711)<p>

			08-11-10<br>
			-Version 40<br>
			-Added Fusion<br>
			-Added Balanced Duels<br>
			-Added New Stat Windows<br>
			-Added Training in the HBTC<br>
			-Added Hub Scoring at Login<br>
			-Added Sub Font Faces to OOC<br>
			-Added Date to the Hub ScoreBoard<br>
			-Added Efficiency Checks to AfkCheck<br>
			-Added Stat Distribution to the Perk Window<br>
			-Added a Command to Check Tabs being Viewed<br>
			-Added a Command to Check Character Icon States<br>
			-Added New Perks:<br>
			* Beam BreakThrough<br>
			* Heightened Senses<br>
			-Added New Characters:<br>
			* Dabura (Rooyall)<br>
			* General Tao (Mateus69)<br>
			* Yardrat Goku (Mateus69)<br>
			* Majin Buu (Sayainarsil)<br>
			* King Piccolo (Sayainarsil)<br>
			* Master Roshi (Sayainarsil)<br>
			* Saiyan Armor Goku (Crakenguy)<br>
			* SS Saiyan Armor Goku (Ismel01)<br>
			* SS4 Bardock (Juhhccee23 & Sayainarsil)<br>
			-Changed and Reset the Stat Points Tutorial Tip<br>
			-Changed CheckAFK to a Proc and Moved it to SecondLoop<br>
			-Changed AI to Aggressively KiBlast Fighting Spirits (KingNaman)<br>
			-Changed the LifeSpan on Loot from 10 to 15 Seconds<br>
			-ReAdded the Players Tab<br>
			-Removed TickLoop for Pointlessly Using CPU<br>
			-Fixed Spelling Error in KnockBack Resistance (Timme557711)<br>
			-Fixed RunTime Error from Sparring Partners Attacking P.Bags?<br>
			-Fixed Icon: Saibamen Missing Guard State<br>
			-Fixed Icon: SS SA Gohan Missing kiblast State<br>
			-Fixed Icon: Added Sprint and IT States to All Icons<br>
			-Fixed Icon: King Vegeta's KnockBack States were MisNamed<br>
			-Fixed Icon: Various Icons were Missing Trans/Revert States<br>
			-Fixed Icon: SS F.Trunks Charging was Backwards (Sayainarsil)<br>
			-Fixed Bug with New Mission Names not Showing<br>
			-Fixed Bug with Stacking P.Bag Training Sessions<br>
			-Fixed Bug with Enemy AIs Targetting Eachother (Multiple)<p>

			08-05-10<br>
			-Version 39<br>
			-Added Small Icons Interface Map Options<br>
			-Added Ignore Party Settings to Save Files<br>
			-Changed the PL Trans Requirement for SS4 Gogeta<br>
			-Disabled the Players Tab (Testing Bandwidth & CPU)<br>
			-Fix Attempted for Ki Blast Collision Ricochet<br>
			-Fixed RunTime Error with the Savior Medal<br>
			-Fixed Minor Bug with Exp Capping at the Level Cap<br>
			-Fixed Bug with Ultimate Power Using Old PL Stat Increase<br>
			-Fixed Bug with Toggle Parties Option not being Accessable<br>
			-Fixed Bug with SS F.Trunks Ki Blast Icons Being Backwards (Arham22)<p>

			08-02-10<br>
			-Version 38<br>
			-Added Toggle Parties Option<br>
			-Added Nappa to Vegeta Mission<br>
			-Added Fly States to SS4 Vegeta<br>
			-Added Tracked Stats:<br>
			* Throw Cancels<br>
			* Beam Battles Won<br>
			* Beam Battles Lost<br>
			-Added New Medals:<br>
			* eBrake<br>
			* Savior<br>
			* Stat Cap<br>
			* Ascended<br>
			* Level Cap<br>
			* Beam Battler<br>
			* Perfect Warrior<br>
			* Even Further Beyond<br>
			* Super Saiyan 4 (Earnable)<br>
			-Changed Stats Back to pre-v35<br>
			-Changed how Missions are Named<br>
			-Changed 'The 4' Medal to 'Super Saiyan 4'<br>
			-Changed TH to Announce when Already Spawned<br>
			-Ran a Global Respec<br>
			-Removed the Nappa Mission<br>
			-Removed the Medal Level Reward from Meet Your Maker<br>
			-Fixed Bug with Trans PL Requirement on USS SA Vegeta<br>
			-Fixed Bug with Newly Earned Medals not Categorizing (Ocean King)<p>

			08-02-10<br>
			-Version 37<br>
			-Added New Perk: Ultimate Power<br>
			-Added Party Invite Ignore Systems<br>
			-Added New Event Systems: Treasure Hunter<br>
			-Added Multi Party Invite Prevention Systems<br>
			-Added Systems to Play Music with Optional Volumes<br>
			-Added New Medals:<br>
			* Party Animal<br>
			* Meet Your Maker<br>
			* Treasure Hunter<br>
			* Proclaimer (Earnable)<br>
			-Changed Respec Message Fonts<br>
			-Changed Enemy AI Targetting Systems<br>
			-Changed Melee & Ki Damage Calculations<br>
			-Changed SortMobList to Handle All Datums<br>
			-Changed SortDatumList to Sort by List Length<br>
			-Changed the View Clans Page to Sort by Members<br>
			-Fixed RunTime Error with Dead Partys at Mission Completion<br>
			-Fixed Bug with Getting Hit while Firing Beams (Rooyall)<br>
			-Fixed Bug with Exiting Instances while Firing Beams (Muhuhahahaha)<br>
			-Fixed Exploit with Training while Doing Missions in Parties (Ocean King)<br>
			-Fixed Exploit with Goals not Resetting in Parties (Muhuhahahaha & QueHoraEs)<p>

			08-01-10<br>
			-Version 36<br>
			-Changed Stat Update Text<br>
			-Changed Trans Power Level Requirements<br>
			-Disabled Zoning to PvP Arenas from Missions<br>
			-Fixed RunTime Error with Logging Out in a Party<p>

			08-01-10<br>
			-Version 35<br>
			-Added Party Systems<br>
			-Added Mission Party Systems<br>
			-Added New Stat Tracking Methods<br>
			-Added Overlay & Underlay for Subs<br>
			-Added Fail Checks to Save File Loading<br>
			-Added Quick Stat Display of Mission Goals<br>
			-Added Tracked Stats:<br>
			* Fastest Spar Combo<br>
			* Party Mission Completion<br>
			-Added New Perks:<br>
			* BulletProof<br>
			* Flash Finish<br>
			* Energy Shield<br>
			-Added New Characters:<br>
			* Krillin (Timme557711)<br>
			* King Vegeta (Sayainarsil)<br>
			* King Vegeta SS (Zeinx999)<br>
			* King Vegeta SS2 (Zeinx999)<br>
			* Majin Vegeta (Timme557711)<br>
			* Kid Trunks SS (Timme557711)<br>
			* Future Trunks SS (Timme557711)<br>
			* Saiyan Armor Gohan (Sayainarsil)<br>
			* Saiyan Armor Gohan SS (Sayainarsil)<br>
			* Saiyan Armor Gohan SS2 (Sayainarsil)<br>
			* Saiyan Armor Vegeta SS (Timme557711)<br>
			-Changed how HUD Popups Work<br>
			-Changed the Medals Tab Display<br>
			-Changed the Order of Save Fixes<br>
			-Changed Various USS Vegeta States<br>
			-Changed SS2 Goku's Revert Animation<br>
			-Changed Damage Against NPCs to Double<br>
			-Changed USS Vegeta to a SA Vegeta Trans<br>
			-Changed Melee Boost on the Warrior Perk<br>
			-Changed Stats to Increase by 1 per Point<br>
			-Changed How Characters are Saved & Loaded<br>
			-Changed the Speed Macro Limit from 10 to 5<br>
			-Changed Ki Blasts to Not Damage the Blaster<br>
			-Changed Mission User Systems to Handle Parties<br>
			-Changed FullNum for Readability and Efficiency<br>
			-Changed PvP Instances to Handle Multiple Types<br>
			-Changed HUD Text Systems to Handle Slim Letters<br>
			-Changed Throw to spawn-1 to Prevent RunTime Errors<br>
			-Minor Tweaks to Various Systems<br>
			-Ran a Global Character Respec<br>
			-Removed the FaceHUD MouseOver Tip<br>
			-ReNamed Some Medals for Better Titles<br>
			-Removed Error Checks from ExitInstance<br>
			-ReNamed Namek Vegeta to Saiyan Armor Vegeta<br>
			-Fixed RunTime Error with Tutorial Removal<br>
			-Fixed Bug with Missing Gogeta States<br>
			-Fixed Bug with Suffixes in the Players Tab<br>
			-Fixed Bug with the Empty Perk Equip Locking<br>
			-Fixed Bug with Throw Stopping Causing Damage<br>
			-Fixed Bug with Perky Medal being Awarded Early<br>
			-Fixed Bug with Perk Points Refilling Every Level<br>
			-Fixed Bug with Last Gasp Perk Checking the Attacker<br>
			-Fixed Bug with KnockBack Resistance Perk (KingNaman)<br>
			-Fixed Bug with Fighting Spirit Half Working (KingNaman)<p>

			07-17-10<br>
			-Version 34<br>
			-Added Defensive AI<br>
			-Added New Missions<br>
			-Added Title Systems<br>
			-Added Effects for Perks<br>
			-Added Macros to all Windows<br>
			-Added Profile by Chat Icons<br>
			-Added Tracking: Clan Messages<br>
			-Added Max Training Combo Systems:<br>
			* +10 Max Exp Punching Bags with Medal: P.Bag Mastery<br>
			* +10 Max Exp Shadow Sparring with Medal: Shadow Spar Mastery<br>
			* +10 Max Exp Shadow Sparring and Punching Bags for Subscribers<br>
			-Added New Characters:<br>
			* Gogeta (Crakenguy)<br>
			* Cell (Timme557711)<br>
			* Jeice (Timme557711)<br>
			* Guldo (Timme557711)<br>
			* Broly (Sayainarsil)<br>
			* Bardock (Timme557711)<br>
			* Cell Jr (Timme557711)<br>
			* Goku SS4 (Sayainarsil)<br>
			* Vegeta SS3 (Keane00100)<br>
			* Android 19 (Timme557711)<br>
			* New SS2 Goku (Timme557711)<br>
			* Captain Ginyu (Sayainarsil)<br>
			* Videl (Timme557711/Mateus69)<br>
			* Teen Gohan SS (Sasukexnaruto)<br>
			* Frieza (Timme557711/Zeinx999)<br>
			* Recoome (Timme557711/Zeinx999)<br>
			* Future Gohan Aftermath (Sayainarsil)<br>
			-Changed world.status<br>
			-Changed the Say verb to Chat<br>
			-Changed Enemies in Freiza Mission<br>
			-Changed Trunks' Specials to Blasts<br>
			-Changed the Font on the Updates List<br>
			-Changed Stat Panel Systems (Soul Sign)<br>
			-Changed Trans Requirments back to 100,000<br>
			-Changed Perk Points from 1,000 to 10,000 Levels<br>
			-Changed the HUD Protection Overlay to Training Only<br>
			-Changed Training Mastery Medals to Require No-Gravity<br>
			-Changed Turning Graivty Off While Training to Cancel the Training<br>
			-Changed the Tutorial+ to Minimize with the Map (True PureBlood Saiyan)<br>
			-Disabled Flying while Training (Gohan Games)<br>
			-Ran a Perk Respec<br>
			-ReAdded the Players Tab<br>
			-Removed Missions Path Restrictions<br>
			-Removed Previously Earned Training Mastery Medals<br>
			-Removed HitStun from NonDamaging Attacks (OmniX3x)<br>
			-Minor Tweaks to Various Systems<br>
			-Major Changes to Beam Battle Systems<br>
			-Fix Attempted for Ki Blasts Getting Stuck<br>
			-Fixed Some Minor Icon Issues (Sayainarsil)<br>
			-Fixed Possible Exploit with Guard Spamming<br>
			-Fixed Bug with Lingering Trait Points Tutorial Tip<br>
			-Fixed Bug with Teleporting to White Space (Eickening)<br>
			-Fixed Bug with Training Text ReAppearing (Gohan Games)<br>
			-Fixed Bug with Aura Staying if Bursting and Landing (SanderRadionov)<br>
			-Timme557711 & Sayainarsil LifeTime Subs for Icon Contributions<p>

			07-08-10<br>
			-Version 33<br>
			-Added New Perks<br>
			-Added New Perk Systems<br>
			-Added Medals: Mass Murder<br>
			-Added a Revert Icon for GSM Trans 1<br>
			-Changed Traits to Stats<br>
			-Changed Slotted Traits to Perks<br>
			-Disabled Global Stat Tracking<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed RunTime with Burter in Frieza Missions<p>

			07-07-10<br>
			-Version 32<br>
			-Added Characters:<br>
			* Burter (Sayainarsil)<br>
			* Yamcha (Timme557711)<br>
			* Future Gohan SS (Sayainarsil)<br>
			-Added New Anti-Macro Systems<br>
			-Changed PL Requirement for SS to 10,000<p>

			07-06-10<br>
			-Version 31<br>
			-Added New Traits<br>
			-Added HUD Updates to TraitUps<br>
			-Changed Button Combo Text Arrows<br>
			-Changed Clan Display to 10+ Members<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Issue with Wrong Dates on Updates<br>
			-Fixed Exploit with Wall Walking for Distance Traveled<br>
			-Fixed Bug/Exploit with Adding Decimal Traits (The evilMonkey)<p>

			07-04-10<br>
			-Version 30<br>
			-Added Stat Tracking:<br>
			* PvP Kills<br>
			* Duels Won<br>
			* Duels Lost<br>
			* Duels Fled<br>
			* Deaths by PvP<br>
			* Deaths by NPC<br>
			* Messages Sent<br>
			* Duels Canceled<br>
			* PvP Arena Kills<br>
			* PvP Arena Deaths<br>
			* Deaths by Gravity<br>
			-Added New Specials:<br>
			* TriBeam<br>
			* Burning Attack<br>
			* Kid Gohan Masenko (Sayainarsil)<br>
			-Added New Traits<br>
			-Added New Missions<br>
			-Added New Tutorial Tips<br>
			-Added Nappa (Timme557711)<br>
			-Added Alt Keys to the Menus<br>
			-Added Mission Tutorials to General<br>
			-Added Forced KO Recovery upon Death<br>
			-Added Systems to Handle Instance Changes<br>
			-Changed Size on the Who Grid<br>
			-Changed SS Gogeta's M.Fly Icon State<br>
			-Changed the Border Around PvP Arenas<br>
			-Changed Offensive List to Sort by Length<br>
			-Changed Ki Blasts to Bounce Away on Collision<br>
			-Changed Ki Blasts and Beams to null loc Deletions<br>
			-Changed the HitStun Time on Counter Attacks from 2 to 10<br>
			-Minor Tweaks to Various Systems<br>
			-Fixed Bug with Music being Cut Off by Other Sounds<br>
			-Fixed Bug with PoweringUp not Canceling Correctly (Gohan Games)<br>
			-Fixed Bug with Beam Charges not Canceling Correctly (Undefeated Saiyans)<p>

			07-03-10<br>
			-Version 29<br>
			-Changes & Fixes for Global Stat Logging<p>

			07-02-10<br>
			-Version 28<br>
			-Added New Medals<br>
			-Added New Missions<br>
			-Added New Tutorial Tips<br>
			-Added Map Corner Details<br>
			-Added Mission Giver: Kami<br>
			-Added the Global ScoreBoard<br>
			-Added Cleared Mission Bonus<br>
			-Added Mission ChipSet Systems<br>
			-Added Animated SnakeWay Clouds<br>
			-Added the Hyperbolic Time Chamber<br>
			-Added PvP Player Display on MouseOver<br>
			-Added New Tracked Stats (Mission Related)<br>
			-Changed Hercule's Difficulty<br>
			-Changed the Offensive Filter<br>
			-Changed Object Phasing Systems<br>
			-Updated the Earth MiniMap<br>
			-Fixed Icon Issue with Kid Gohan's Sprint<br>
			-Fixed Exploit with Flying while PoweringUp<br>
			-Fixed Exploit with KO Status being Reset on Certain Actions<p>

			06-30-10<br>
			-Version 27<br>
			-Added Characters:<br>
			* Android 17 (Sayainarsil)<br>
			* Gogeta SS4 (Sayainarsil)<br>
			* Goten SS (Timme557711)<br>
			* Vegito SS (Timme557711)<br>
			* Gogeta SS (Timme557711)<br>
			* Kid Gohan (Timme557711)<br>
			* Future Trunks (Timme557711)<br>
			* Vegeta SS4 Trans (Timme557711)<br>
			* Piccolo Trained Gohan (Sayainarsil)<br>
			-Added New Missions:<br>
			* Defeat Vegeta<br>
			* Defeat Hercule<br>
			-Added Lag Options PopUp from Chat<br>
			-Added Mission Completion Victory Music<br>
			-Added Kid Gohan KameHameHa (Sayainarsil)<br>
			-Minor Tweaks to Various Icons<br>
			-Fixed Map Issue with the Door on Kame House being Dense<br>
			-Fixed Issue with SS Vegeta not Final Flashing (SanderRadionov)<p>

			06-26-10<br>
			-Version 26<br>
			-Added New Characters:<br>
			* Goten (Timme557711)<br>
			* Kid Trunks (Timme557711)<br>
			* Super Saiyan 2 Trunks Trans (Reko1)<br>
			-Added Scrolling ScoreBoard to the Interface<br>
			-Added Report Bug / Submit Suggestion Button<br>
			-Minor Tweaks to Various Icons<br>
			-Minor Tweaks to Various Systems<br>
			-ReNamed "On Your Way" Medal to "Ding"<br>
			-ReNamed "Well On Your Way" Medal to "Centennial"<br>
			-Fixed RunTime in the new Offensive Filter<br>
			-Fixed Bug with Sub Name Changes not Working<p>

			06-26-10<br>
			-Version 25<br>
			-Added New Characters<br>
			* Tien (AntM)<br>
			* Frieza (Sayainarsil)<br>
			* Hercule (Sayainarsil)<br>
			* Namek Vegeta (Sayainarsil)<br>
			* Mystic Gohan (Sasukexnaruto)<br>
			* Great Saiyaman (Sasukexnaruto)<br>
			* Great Saiyaman Transes (Keane00100)<br>
			-Added Sound Effects when Out of Ki<br>
			-Changed the Offensive Filter<br>
			-Minor Tweaks to Various Systems<br>
			-Fix for Bug/RunTime when Exiting Instances<br>
			-Fixed Exploit with PoweringUp during Activities<p>

			06-03-10<br>
			-Version 24<br>
			-Added a Chat Log System<br>
			-Added a Check in ExitInstance<br>
			-Changes to the Offensive Filters<br>
			-Minor Tweaks to Various Systems<p>

			06-03-10<br>
			-Version 23<br>
			-Added Custom Mouse Icon<br>
			-Added an AFK Icon Overlay<br>
			-Added Averages to the Who List<br>
			-Added a View Forums File Menu<br>
			-Added Clan Color in the Who List<br>
			-Added TrimSpaces to SpamGuard<br>
			-Added Damage Multiplier Stat Display<br>
			-Added a Training Area at Kame House<br>
			-Added a Check when Kicking Clan Members<br>
			-Added Characters:<br>
			* Vegito<br>
			* Adult Gohan (Timme557711)<br>
			* Gotenks, Namek Gohan, Saibaman (Sasukexnaruto)<br>
			-Changed Test Dummies to Saibamen<br>
			-Changed how Focus Training is Ended (Possible Exploit)<br>
			-Fixed Issue with Required Clan Stats Defaulting to null<br>
			-Fixed Bug with Clan Invites always Inviting Everyone (KingNaman)<p>

			05-19-10<br>
			-Version 22<br>
			-Added KO Recovery to General Tutorials<br>
			-Disabled Medal Leveling when Level 1<br>
			-Finished Custom Clan Rank Changes<p>

			05-19-10<br>
			-Version 21<br>
			-Added Clan Display in Who List<br>
			-Added Clan Color to Window BG<br>
			-Added Specific Medal Level Rewards<br>
			-Added Medals: One Month, Proclaimer<br>
			-Added Alpha Revival to General Tutorials<br>
			-Added Tutorial Tips: Start Sparring, Finishers<br>
			-Added Tracked Stats: Distance Traveleds, ITs<br>
			-Added Note in Lag Options about Multiple Seekers<br>
			-Changed Clan Invite Members Option<br>
			-Changed the Clan MotD Display Window<br>
			-Changed Mission Systems to Read Datums<br>
			-Changed Under Char Clan Text to be Outlined<br>
			-Changed Allow&Ignore Invites to Toggle Invites<br>
			-Corrected for Zenie Collected before Tracking<br>
			-Minor Changes to Various Systems<br>
			-ReAdded Water Animations<br>
			-Removed (0 Players) tag from Empty Instances<br>
			-Various Changes to GM Commands<br>
			-Attempted Fix for Getting Frozen During PvP (Multiple)<br>
			-Fixed Bug with Players not being Throwable<br>
			-Fixed Bug with Spaces not Working in Default Clan Ranks<p>

			05-11-10<br>
			-Version 20<br>
			-Added Profile Formatting<br>
			-Added Medal: Millionaire<br>
			-Added Spawn Point: Kame House<br>
			-Added Saving & Loading of $ Points<br>
			-Added Tracked Stat: Zenie Collected<br>
			-Added Raditz as a Playable Character<br>
			-Added Pikkon (Icon From: Sasukexnaruto)<br>
			-Beam Battle Mistakes now Reset your Combo<br>
			-Removed the Quit Button during Beam Battles<br>
			-Attempted Fix for the Resource File Overloading<br>
			-Attempted Fix for Mission Medals not being Awarded<p>

			05-02-10<br>
			-Version 19<br>
			-Added Chests<br>
			-Added Stat Tracking<br>
			-Added Zenie Systems<br>
			-Added Full Screen Mode<br>
			-Added Item Looting Systems<br>
			-Added a Generic Medal Icon<br>
			-Added a Delay before AI Ki Blasts<br>
			-Added Tutorial Tip: Opening Chests<br>
			-Added Display and Distrubution of $ Points<br>
			-Added New Medals:<br>
			* Lucky Looter<br>
			* Mission Perfect<br>
			* Time in a Bottle<br>
			-Enemies Killed now Drop Zenie<br>
			-Improved Functionality of Turning while Charging<br>
			-Lowered the Amount of Ki Recovered by Blocking<br>
			-Mapped: Kami's Lookout<br>
			-Moved Options to a File Menu<br>
			-Minor Tweaks to Various Icons<br>
			-Minor Tweaks to Various Systems<br>
			-Subscribers can now Download Icon Base<br>
			-Subscribers can now Upload Custom Icons<br>
			-Subscribers now get Double Focus Training Exp<br>
			-Attempted Fix for Screen Read Macros<br>
			-Fixed Bug with AI not Recovering from KO<br>
			-Fixed Bug with Mission Completion/Rewards<p>

			03-07-10<br>
			-Version 18<br>
			-Added a Quit Button when Training<br>
			-Added BYOND Client Version Verification<br>
			-Clan Color now Effects the Under Player Text<br>
			-Removed Formatting from Hub Scores<br>
			-Fixed Issue with Flight Aura Layering<p>

			02-27-10<br>
			-Version 18<br>
			-Added Hub Scoring<br>
			-Minor Tweaks to Various Systems<br>
			-AutoSet the Edge Turfs to SuperDense (Rooyall)<br>
			-Disabled Guarding during Beam Struggle (Gohan Games)<br>
			-Fixed Exploit with Changing Clan Rank to Leader (Rooyall)<br>
			-Fixed Bug with Attacks Ignoring Defense (Rooyall)<br>
			-Fixed Bug with Sparring Partners Outside the Capsule (Rooyall)<p>

			02-25-10<br>
			-Version 17<br>
			-Added some New Tutorial Tips<br>
			-Added the Clan Management Page<br>
			-Added Option to Ignore All Clan Invites<br>
			-Added an Out of Date BYOND Version Alert<br>
			-Beams can now be OverCharged for up to 2 Seconds<br>
			* OverCharging can use up to 1 Bar of Ki<br>
			* As of now OverCharging doesn't Increase Damage<br>
			-Changed Play Time to Record by Seconds<br>
			-Changed Clan Member Management to a Grid<br>
			-Disabled Water Animations<br>
			-Disabled Guarding while Firing a Beam<br>
			-Disabled Guarding while Training (Muhuhahahaha)<br>
			-Firing a Normal Beam can now Trigger a Beam Struggle<br>
			-Minor Tweaks to Various Systems<br>
			-Modified various Movement Systems<br>
			-Moved General Stat Traits to the Top<br>
			-PVP Damage is now Stat Based by Default<br>
			-Removed Rank Change from Clan Managers<br>
			-Set Movement and Combat Verbs to Instant<br>
			-Sub Name Changes now go through the NameGuard<br>
			-Fixed Issue with Completing the KO Recovery Tutorial Tip<br>
			-Fixed Exploit with Guarding while Charging a Beam (The evilMonkey)<p>

			02-13-10<br>
			-Version 16<br>
			-Added Offensive Filter Logging<br>
			-Added Play Time to the ScoreBoard<br>
			-Added Esc Macro to Cancel Targetting<br>
			-Added HTML Formatting to the ScoreBoard<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Computer Lock Systems<br>
			-Subs will now Apply without Reloging<p>

			12-27-09<br>
			-Version 15<br>
			-Added Reward for Completing Missions<br>
			-Added GM Commands: Delete, Watch Player<br>
			-Changed the way Multiple Levels are Gained<br>
			-Replaced all the Missing Trees on the Map<br>
			-Reduced the Ki Based Damage Variant by /10<br>
			-Fixed Bug with Sparring Partners not getting Deleted<p>

			12-23-09<br>
			-Version 14<br>
			-Added FullNum<br>
			-Added GM Command: Edit<br>
			-Added % AFK Players to the Who List<br>
			-Added new Medal: Hope of the Universe<br>
			-Added Auto Guard on Sparring Partners<br>
			-Beams should now collide with anything the player would<br>
			-Changed Damage Calculations<br>
			-Changed Exp Rewards for Killing NPCs<br>
			-Changed M to now Toggle the MiniMap On/Off<br>
			-Changed the 'Its Over 9,000!!!' Medal to Power Level<br>
			-Changed Teleport Dodge back to G (Shift+G for Block Only)<br>
			-Expanded Transformation Systems<br>
			-Iconned Raditz<br>
			-Restircted Beam Battles to PVP/PVE Only<br>
			-Sparring Partners are now Forcibly Deleted at Target Loss<br>
			-Updated Spam and Offensive Filters<br>
			-Fixed Bug with Replying to Duel Requests in Instances<br>
			-Fixed Multiple Exploits for Escaping from Beam Struggles<p>

			11-27-09<br>
			-Version 13<br>
			-Added Beam Systems<br>
			-Added Counter Attacking<br>
			-Added Beam Battle Systems<br>
			-Added Global Mute Systems<br>
			-Capped All Stats at 999,999<br>
			-Changed Respawn on PVP Deaths<br>
			-Changed the Way Medals are Fixed<br>
			-Changed Teleport Dodge to Shift+G<br>
			-Changed the Who List to the Inteface<br>
			-Changed PVP Deaths to Display the Arena<br>
			-Disabled Instancing when Busy<br>
			-Disabled Enemy AI During Hit Stun<br>
			-Moved a few things to mob/Del<br>
			-Minor Changes to Various Systems<br>
			-Prevented Spar Partner Interference<br>
			-Removed the Stuck Command<br>
			-Removed the Bonafide Leader Medal<br>
			-Various Changes to Enemy AI<br>
			-Various Changes to Who Layout<p>

			11-18-09<br>
			-Version 12<br>
			-Added a Stuck Command<br>
			-Modified the Who Display<br>
			-Slowed Enemy AI Reaction Time<br>
			-Fixed some Instance Locating Bugs<p>

			11-16-09<br>
			-Version 11<br>
			-Added Sprinting<br>
			-Added Enemy AI<br>
			-Added Perk Points<br>
			-Added New Medals<br>
			-Added ScreenShake()<br>
			-Added Focus Training<br>
			-Added Gravity Training<br>
			-Added Sparring Partners<br>
			-Added Training Text BGs<br>
			-Added NPC Name Display<br>
			-Added Super Saiyan 3 for Goku<br>
			-Added some Graphics from Boronks23<br>
			-Added Concept Piece Instance Systems<br>
			-Added Instant Transmission via the MiniMap<br>
			-Disabled Computer Lock Systems<br>
			-Lag Options Window now Updates when Opened<br>
			-Minor Changes to Various Systems<br>
			-Ran a Global Character Respec<br>
			-Removed some Medals<br>
			-Updated the Trunks Icons<br>
			-Updated Piccolo Form 3 Icon (Boronks23)<p>

			10-03-09<br>
			-Version 10<br>
			-Added 'Play Music' GM Command<br>
			-Added Object Links to the Medals Tab<p>

			10-01-09<br>
			-Version 9.1<br>
			-Added Message for Killing in PVP Arenas<br>
			-Version 9<br>
			-Added names on Duel Flags<br>
			-Added HUD Notification Systems<br>
			-Modifications to Clan Invite Verbs<p>

			09-30-09<br>
			-Version 8<br>
			-Added new Traits<br>
			-Added Duel Ranges<br>
			-Added Playable Characters<br>
			-Added Auras when Powering Up<br>
			-Added SaveClans() to world/Del()<br>
			-Added 'Set Minimum Stats' for Clan Leaders<br>
			-Changed Ki per TP from +2 to +20<br>
			-Changed Base MaxKi from 500 to 1,000<br>
			-Changed Power Level per TP from +5 to +10<br>
			-Damage now varies by your Ki % vs your Opponents<p>

			09-29-09<br>
			-Version 7.2<br>
			-Added a Respec System<br>
			-Added Updates Display on New Versions<br>
			-Changed PowerUp Macro to Repeat<br>
			-Ran a Global Character Respec<br>
			-ReEnabled control_freak<br>
			-Training can now be Accessed from Any Part of the Machine<br>
			-Fixed Bug with Negative Trait Points<br>
			-Fixed Bug with Flight Shadows Disappearing<br>
			-Version 7.1<br>
			-Added Balanced PVP Arena<br>
			-Added Shadows to Flying Ki Blasts<br>
			-Added Hit Detection to Flying Ki Blasts<br>
			-Changed Ki per TP from +5 to +2<br>
			-Changed Strength per TP from +1 to +2<br>
			-Changed Defense per TP from +0.5 to +1<br>
			-Changed Power Level per TP from +10 to +5<br>
			-Changed Defense to affect Ki Attacks<br>
			-Modifications to make Movement Changes Smoother<br>
			-Fixed Bug with Tutorials<br>
			-Fixed Bug with MiniMap not Displaying<br>
			-Version 7<br>
			-Added PVP & Clan PVP Arenas<br>
			-Added Multi Trait Point Distribution<br>
			-Modified the Trait Window<br>
			-Modified the Instance Systems<br>
			-Modified Tool Tip Window Position Calculations<br>
			-Tutorial Window can now be Minimized<br>
			-Fixed Bug with the Medal "It's Over 9,000!"<br>
			-Fixed Bug with UnResponsive East/West while Moving<p>

			09-28-09<br>
			-Version 6<br>
			-Added a New Medal<br>
			-Added Shadow Sparring<br>
			-Added New Tutorial Tips<br>
			-Modified P. Bag Timing<br>
			-Reduced ScoreBoard from 25 to 10<p>

			09-28-09<br>
			-Version 5<br>
			-Added a ScoreBoard<br>
			-Added Tutorial Options<br>
			-Added new Tutorial Tips<br>
			-Disabled Dueling on Instance Maps<p>

			09-27-09<br>
			-Version 4<br>
			-Added new Tutorial Tips<br>
			-Added Play Time Tracking<br>
			-Added Official PVP Dueling<br>
			-Added a Close Button on Tutorial Tips<br>
			-Damage is now Rounded<br>
			-Minor Tweaks to Various Systems<br>
			-Removed Tutorial Related Medals<p>

			09-27-09<br>
			-Version 3<br>
			-Added New Medals<br>
			-Added Tutorial Systems<br>
			-Added Multiple Revival Locations<br>
			-Medals Now Give 100% Exp (After Level 1)<br>
			-Modified Movement Systems to Process Diagonals<p>

			09-26-09<br>
			-Version 2<br>
			-Added New Medals<br>
			-Added 4x Map Space<br>
			-Added Leveling Systems<br>
			-Added Instance Systems<br>
			-Added Trait Leveling Systems<br>
			-Added P.Bag Training System<br>
			-Added Offensive Language Filter<br>
			-Added Training Capsule Instances<br>
			-Added 'Invite Everyone' Clan Command<br>
			-Added 'Change Name' Subscriber Command<br>
			-Minor Tweaks to Various Systems<br>
			-Modified LowCpuHUD to Include LowLetters()<br>
			-Modified LowCpuHUD to Dynamically Create Lists<p>

			08-16-09<br>
			-Version 1<br>
			-Alpha Testing Begun<p>

			"},"window=News;size=600x600")
/*var/patchnotes = {"
<html xmlns="http://www.w3.org/1999/xhtml">
        <head>
                <title>Updates</title>
                <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
                <style type="text/css">
                .header {width: 500px; text-align: center; margin: 0px auto; font-size: 22pt; font-family: "segoe script";}
                .table {width: 600px; margin: 0px auto;}
                .table th {border: 2px groove #000; background: #DDD; font-size: 14pt;}
                .table td {border: 2px groove #000; vertical-align: top; padding-left: 10px;}
                .next {background: #C20815 !important;}
                .message {width: 500px; margin: 0px auto; text-align: center;}
                </style>
        </head>
        <body>
                <div class="header">Patch Notes</div>
                <div class="message">The first version in red is the next version to be released. The one below the top red one, is the current version.<br />some additions and changes may be seen in the previous version.</div>
                <br />
                <table class="table">
                 <tr><th class="next">Version 85</th></tr>
                <tr>
                        <td>
                                Additions
                                <ul>
                                        <li>None yet.</li>
                                </ul>
                                Changes
                                <ul>
                                        <li>Transform system.</li>
                                </ul>
                                Fixes
                                <ul>
                                        <li>None yet.</li>

                                </ul>
                        </td>
                </tr>
                <tr><th class="next">Version 84</th></tr>
                 			 	Additions
                                <ul>
                                        <li>DB On map</li>
                                </ul>
                                Changes
                                <ul>
                                        <li>Skin</li>
                                        <li>Spelling on defense</li>
                                        <li>Remove Duels until further notice.</li>
                                        <li>Removed some medals.</li>
                                </ul>
                                Fixes
                                <ul>
                                        <li>Fixed serious cpu and lag issues</li>
                                        <li>Fixed Tourneyment bug!</li>

                                </ul>
                        </td>
                </tr>
                <tr><th class="next">Version 83</th></tr>
                <tr>
                        <td>
                                Additions
                                <ul>
                                        <li>Added new City ( Aliahmed & ZIDDY99  also in Production ).</li>
                                </ul>
                                Changes
                                <ul>
                                       <li>Changed Update Log ( Darker Legends )</li>
                                       <li>Moved City to the Devilish type of Map area ( Doesnt show when pressed M, but you can still IT there )</li>
                                </ul>
                        </td>
                </tr>
                </table>

        </body>

</html>
"}*/