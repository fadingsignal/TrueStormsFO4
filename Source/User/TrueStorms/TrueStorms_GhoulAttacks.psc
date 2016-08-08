ScriptName TrueStorms:TrueStorms_GhoulAttacks extends activemagiceffect

Bool Property IsYouStupit = True Auto Const

Bool DoGhoulAttacks = True ;Magic effect conditions are met (not in interior, not in dialogue, etc.) but we need slightly more intricate conditions for being in settlements, etc.

Group GlobalConfigValues
	GlobalVariable Property TrueStorms_Config_GhoulHoardChance Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardsInSettlements Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardFrequency Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardMax Auto
	GlobalVariable Property TrueStorms_GhoulHordeInProgress Auto
EndGroup

Group Keywords
	Keyword Property LocTypeSettlement Auto Const
	Keyword Property LocTypeWorkshop Auto Const
	Keyword Property LocTypeWorkshopSettlement Auto Const
EndGroup

Group SpawnedActors
	ActorBase Property TrueStorms_LvlFeralGhoul_AnyLevel Auto Const
	ActorBase Property LvlFeralGhoulGlowingOne Auto Const
EndGroup

Group Misc
	Formlist Property TrueStorms_FList_LocationsNoGhouls Auto
	Static Property XMarkerBase Auto
	Keyword Property TrueStorms_Ghoul Auto Const
	Sound Property TrueStorms_AMBExtDistantGhouls Auto
	;Spell Property TrueStorms_SpawnCleanup Auto Const
EndGroup

Int GhoulSpawnTimerDurationMin ;in real world seconds
Int GhoulSpawnTimerDurationMax ;in real world seconds

Int GhoulSpawnCurrentTotal ;the current counter we'll use to increment / decrement
Int GhoulSpawnMaxTotal ;OVERRIDDEN BY GLOBAL this is the max number of spawns for a total hoard at a given time, the player will have to kill a few for more to spawn TODO: Add this to config possibly?
Int GhoulSpawnMin = 1 ;Minimum number of ghouls to spawn at the interval
Int GhoulSpawnMax = 5 ;Maximum number of ghouls to spawn at the interval
Int GhoulSpawnTimerID = 666

Int DistanceFromPlayerMin = 2048	;now forward values (in front of player)
Int DistanceFromPlayerMax = 3072 ;now forward values (in front of player)

Int DistanceFromPlayerBehindMin = 512
Int DistanceFromPlayerBehindMax = 1024
Int ChanceToSpawnBehindPlayer = 20

;When the player is in a settlement, user larger radius so ghouls don't appear inside fences (not going to be perfect but still)
Int DistanceFromPlayerMinSettlement = 3072
Int DistanceFromPlayerMaxSettlement = 5120

Int MinimumDistancePlayerLOS = 2048 ;UNUSED I now tightly control spawning in front of and behind the player 
Int AmbushChance = 50 ;UNUSED, they all rush the player now
Int GlowingOneChance = 8 ;percent chance to spawn a leveled glowing one on top of the mini hoard spawn

Int MultiSpawnDispersalMin = 256
Int MultiSpawnDispersalMax = 1024

Int GhoulSpawnGrandTotal ;count that keeps going up during the entire duration of the hoard mode
Int GhoulSpawnKilledTotal ;count that keeps going during the entire duration of the hoard mode

Actor PlayerRef
Location currentLocation

Event OnInit()
	PlayerRef = Game.GetPlayer()
EndEvent


Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.Notification("ghoul attack effect started")
	;a rad storm has started
	;roll chance
	
	RefreshGlobalSettings() ;this loads up the variables needed for the counters
	
	If(Utility.RandomInt(0,100) <= TrueStorms_Config_GhoulHoardChance.GetValueInt())
		
		;Play an initial sound that signifies a ghoul attack
		TrueStorms_AMBExtDistantGhouls.Play(PlayerRef)
		
		ReStartGhoulSpawnTimer()
	EndIf
	
	;StartTimer(60, 999) ;just for testing only
	
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	;debug.Notification("Ghoul attack effect finished. Ghouls killed: " + GhoulSpawnKilledTotal)
	;debug.MessageBox("Ghoul attack effect finished. Ghouls killed: " + GhoulSpawnKilledTotal)
	CancelTimer(GhoulSpawnTimerID)
	TrueStorms_GhoulHordeInProgress.SetValue(0)

EndEvent

Function ReStartGhoulSpawnTimer()

	StartTimer(utility.RandomFloat(GhoulSpawnTimerDurationMin, GhoulSpawnTimerDurationMax), GhoulSpawnTimerID)

EndFunction

Event OnTimer(int timerID)

	If(timerID == GhoulSpawnTimerID)
	
		;If the player is in a settlement, and attacks in settlements are disabled in config
		;I put this inside the script because I couldn't figure out how to do it with conditions, too complicated since the other ones are all singular bool true/false that stack
		If(IsPlayerInSettlement()  && !TrueStorms_Config_GhoulHoardsInSettlements.GetValueInt())
			;debug.messagebox("We're in a settlement, and settings disallow ghoul hoards")
			DoGhoulAttacks = False
			TrueStorms_GhoulHordeInProgress.SetValue(0)
		Else
			DoGhoulAttacks = True
			TrueStorms_GhoulHordeInProgress.SetValue(1)
		EndIf
		
		If(DoGhoulAttacks)
			DoGhoulSpawn()
		EndIf
		
		ReStartGhoulSpawnTimer()	
	EndIf
	
	;If(timerID == 999)
		;ShowTotalCounts()
		;CancelTimer(GhoulSpawnTimerID) ;for testing only
	;EndIf
	
EndEvent


; Hook into the ghoul's death event to decrement the total counter 
Event Actor.OnDeath( Actor akSender, Actor akKiller )
	If(akSender.HasKeyword(TrueStorms_Ghoul))
		GhoulSpawnCurrentTotal -= 1 ;deduct one from the total living ghoul count
		GhoulSpawnKilledTotal += 1
		;debug.messagebox("Hoard ghoul has been killed.  Current count is: " + GhoulSpawnCurrentTotal)
		UnregisterForRemoteEvent(akSender, "OnDeath") ; will this unregister for only THIS one?  Let's see, hard to tell.
	EndIf
EndEvent

;================================================================
; INTERNAL FUNCTIONS
;================================================================

Bool Function IsPlayerInSettlement()

	Bool playerInSettlement = False
	currentLocation = PlayerRef.GetCurrentLocation()

	If(currentLocation.HasKeyword(LocTypeSettlement) || currentLocation.HasKeyword(LocTypeWorkshop) || currentLocation.HasKeyword(LocTypeWorkshopSettlement))
		playerInSettlement = True
	ElseIf(TrueStorms_FList_LocationsNoGhouls.HasForm(currentLocation))
		playerInSettlement = True
	Else
		playerInSettlement = False
	EndIf

	;debug.MessageBox("player is in settlement: " + playerInSettlement)

	
	Return playerInSettlement

EndFunction

Function RefreshGlobalSettings()
	GhoulSpawnMaxTotal = TrueStorms_Config_GhoulHoardMax.GetValueInt()

	;FREQUENCY 'ENUM'
	;=============
	;0 = Low: 30 seconds to 5 minutes
	;1 = Medium: 15 seconds to 2 minutes <- default
	;2 = Heavy; 10 seconds to 40 seconds
	;3 = Insane; 5 seconds to 15 seconds	
	
	Int ghoulHoardFreq = TrueStorms_Config_GhoulHoardFrequency.GetValueInt()
	
	If(ghoulHoardFreq == 0) ;Low
		GhoulSpawnTimerDurationMin = 30 ;30sec
		GhoulSpawnTimerDurationMax = 240 ;4min
	ElseIf(ghoulHoardFreq == 1) ;Medium (default)
		GhoulSpawnTimerDurationMin = 15 ;15sec
		GhoulSpawnTimerDurationMax = 90 ; 1.5min
	ElseIf(ghoulHoardFreq == 2) ;High
		GhoulSpawnTimerDurationMin = 10
		GhoulSpawnTimerDurationMax = 40
	ElseIf(ghoulHoardFreq == 3) ;Insane
		GhoulSpawnTimerDurationMin = 5
		GhoulSpawnTimerDurationMax = 15	
	EndIf
	
EndFunction

Function DoGhoulSpawn()
	
	 RefreshGlobalSettings() ;Grab them from the global vars again so user can update in real-time during combat (why not? I just hope this doesn't make things slower.)
	
	If(GhoulSpawnCurrentTotal < GhoulSpawnMaxTotal)

		;debug.Notification("Spawning ghouls")
		
		ObjectReference spawnMarker = GenerateSpawnMarker(DistanceFromPlayerMin, DistanceFromPlayerMax, PlayerRef)
		Int rollSpawnCount = Utility.RandomInt(GhoulSpawnMin, GhoulSpawnMax)
		
		;Make sure that this new amount we're adding doesn't go OVER the max total, and shave it down to hit the max perfectly
		Int newTotalCalculated = GhoulSpawnCurrentTotal + rollSpawnCount
		
		If(newTotalCalculated > GhoulSpawnMaxTotal)
			Int tempRecalc = (newTotalCalculated - GhoulSpawnMaxTotal) ;get the remainder over 20
			rollSpawnCount = (rollSpawnCount - tempRecalc) ;deduct that from the spawn count
		EndIf
		
		
		PlaceActorsAtSpawnMarker(TrueStorms_LvlFeralGhoul_AnyLevel, spawnMarker, rollSpawnCount, False)
		
		;Roll to spawn "bonus" Glowing One :)
		If(Utility.RandomInt(0,100) <= GlowingOneChance)
			;debug.Notification("Spawning Glowing One")
			PlaceActorsAtSpawnMarker(LvlFeralGhoulGlowingOne, spawnMarker, 1, True)
		EndIf

		;clean up the spawn marker
		spawnMarker.Delete()
		
	Else
		
		;debug.Notification("Reached ghoul max, waiting for some to die...")
		
		;Do nothing, wait a little bit to see if player kills off some of the max ghouls
	
	EndIf
		
EndFunction


Function ShowTotalCounts()
	debug.MessageBox("Total Spawned: " + GhoulSpawnGrandTotal + " Total Killed: " + GhoulSpawnKilledTotal)
EndFunction

Function PlaceActorsAtSpawnMarker(ActorBase actorToSpawn, ObjectReference spawnMarker, Int spawnCount, Bool groupSpawnsTogether = True)

	Int multiSpawnOffsetDistance = 0
	Float multiSpawnOffsetX = 0
	Float multiSpawnOffsetY = 0
	Int multiSpawnAngle = 0

	Int i = 0
	While(i < spawnCount)

		ObjectReference placedActor = spawnMarker.PlaceAtMe(actorToSpawn, 1, false, false, true)
		
		;Add self-expiration spell to spawned ghoul; they will expire after 3 hours whether dead or alive to keep active refs down
		;EDIT: This is not needed, the game cleans up these refs nicely when the cell is unloaded, even living creatures 
		;(placedActor As Actor).AddSpell(TrueStorms_SpawnCleanup)

		;This is the keyword we will be using to track the death counter
		(placedActor As Actor).AddKeyword(TrueStorms_Ghoul)
		RegisterForRemoteEvent((placedActor As Actor), "OnDeath")
		
		;moveto on actor at spawn marker with offset which is 0 at first and subsequent looks
		
		placedActor.MoveTo(spawnMarker, multiSpawnOffsetX, multiSpawnOffsetY, spawnMarker.GetPositionZ(), False)
		placedActor.MoveToNearestNavmeshLocation() ;after jumbling their position from the marker, which we know is placed at a navmesh location, we need to re-snap in case they are moved to mid-air or something NOTE: Still have mid-air sometimes
		
		;Removing this for now, testing travel package, they will attack anyway
		;(placedActor As Actor).StartCombat(PlayerRef)
		
		;Now we jumble up the position for the next loop to scatter the placement
		;if GroupSpawns is false then we randomize the location  so next loop around they'll be scattered -- note: this works pretty well
		If(groupSpawnsTogether == False)

			;this is to control the angle to be only frontward / 'away', so that when a far away multi-spawn is scattered, it doesn't scatter back toward the player making the appearance pop-in visible (u smaht)
			If(Utility.RandomInt(0,1) == 0)
				multiSpawnAngle = Utility.RandomInt(0, 90) ;right block of LOS vision
			Else
				multiSpawnAngle = Utility.RandomInt(270, 360) ;left block of LOS vision
			EndIf
			
			multiSpawnOffsetDistance = Utility.RandomInt(MultiSpawnDispersalMin, MultiSpawnDispersalMax)
			multiSpawnOffsetX = multiSpawnOffsetDistance * Math.Sin(spawnMarker.GetAngleZ()+multiSpawnAngle)
			multiSpawnOffsety = multiSpawnOffsetDistance * Math.Cos(spawnMarker.GetAngleZ()+multiSpawnAngle)
		EndIf
		
		i +=1
		
		GhoulSpawnCurrentTotal +=1
		GhoulSpawnGrandTotal += 1
		
	EndWhile

EndFunction


;Takes min and max distance and returns a marker in a random radius / distance from the player
ObjectReference Function GenerateSpawnMarker(Int minDistance, Int maxDistance, ObjectReference relativePositionObject)
	
	;New logic when outside of settlements: favor spawning in front of player at a distance, and have a lower chance to spawn close and behind.  I found spawns happened behind the player too often.
	
	Int randomAngle
	Int randomDistance
	
	;This function is only called if we are allowed to spawn ghouls, so no need to perform extra checks
	
	If(IsPlayerInSettlement())
	
		;debug.MessageBox("player is in settlement")
		randomDistance = Utility.RandomInt(DistanceFromPlayerMinSettlement, DistanceFromPlayerMaxSettlement) ;large distance
		randomAngle = Utility.RandomInt(0, 359) ;full 360 radius
		
	Else
	
		;Spawn behind player, and fairly close
		If(Utility.RandomInt(1,100) <= ChanceToSpawnBehindPlayer)
		
			randomDistance = Utility.RandomInt(DistanceFromPlayerBehindMin, DistanceFromPlayerBehindMax)
			randomAngle = Utility.RandomInt(90, 270) ; behind player's peripheral cone
			
		;Spawn in front of player, but further away
		Else
		
			randomDistance = Utility.RandomInt(minDistance, maxDistance)
			;Spawn in the player's frontward peripheral cone
			If(Utility.RandomInt(0,1) == 1) ;angle can't be negative value so need to split 'left' and 'right' of the peripheral circle
				randomAngle = Utility.RandomInt(0, 45)
			Else
				randomAngle = Utility.RandomInt(314, 359)
			EndIf	
		EndIf
	
	EndIf
	
	Float spawnMarkerOffsetX = randomDistance * Math.Sin(relativePositionObject.GetAngleZ()+randomAngle)
	Float spawnMarkerOffsetY = randomDistance * Math.Cos(relativePositionObject.GetAngleZ()+randomAngle)
	
	ObjectReference tempSpawnMarker = relativePositionObject.PlaceAtMe(XMarkerBase, 1, false, false, true)

	tempSpawnMarker.MoveTo(relativePositionObject, spawnMarkerOffsetX, spawnMarkerOffsetY, relativePositionObject.GetPositionZ(), False)
	tempSpawnMarker.SetAngle(0,0,Utility.RandomInt(0,360)) ;to fix characters spawning at weird angles and getting stuck in the ground
	tempSpawnMarker.MoveToNearestNavmeshLocation()
	
	Return tempSpawnMarker
	
EndFunction
