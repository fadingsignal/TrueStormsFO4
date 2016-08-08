Scriptname TrueStorms:TrueStorms_SpawnCleanup extends activemagiceffect

;It turns out this isn't even necessary.  Refs that are placed using the DeleteWhenAble = true ACTUALLY DELETE when you leave the cell.  Refs to ghouls are GONE.

Int expirationTimerID = 996
Float expirationDuration = 1.0 ;in-game hours, 4 is default
Int minimumCleanupDistance = 0 ;4096 default
Actor playerREF
ObjectReference thisActor

Event OnEffectStart(Actor akTarget, Actor akCaster)
	thisActor = akTarget As ObjectReference
	playerREF = Game.GetPlayer()
	StartTimerGameTime(expirationDuration, expirationTimerID)
	Debug.MessageBox("spawn cleanup effect start")
EndEvent

;NOTE: Magic Effects are removed from actors when they're killed, so I cannot put timers on dead things unfortunately.  I wonder if I can re-cast a spell on a dead body?

Event OnTimerGameTime(int iTimer)
	Debug.MessageBox("reached expiration")
	If(iTimer == expirationTimerID)
	
		Debug.MessageBox("reached timer")
	
		;If(playerREF.GetDistance(thisActor) > minimumCleanupDistance)
		;	Debug.MessageBox("far enough from the player, reference deleting...")
		;	thisActor.Disable()
		;	thisActor.Delete()
		;Else
		;	Debug.MessageBox("too close to the player, timer restarting...")
		;	StartTimerGameTime(expirationDuration, expirationTimerID)
		;EndIf
	EndIf
EndEvent
