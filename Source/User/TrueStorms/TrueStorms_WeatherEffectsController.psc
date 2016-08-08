ScriptName TrueStorms:TrueStorms_WeatherEffectsController extends ActiveMagicEffect

Formlist Property TrueStorms_FList_RainSoundMarkers Auto Const
GlobalVariable Property TrueStorms_ShowWeatherEffects Auto
ObjectReference[] SoundMarkerArray
Actor playerRef

Int TimerCheckMarkersID = 1
Int TimerCheckMarkersDuration = 2
Int ScanDistance = 512

Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.Notification("weather effect controller starting")
	playerRef = Game.GetPlayer()

	StartTimer(TimerCheckMarkersDuration, TimerCheckMarkersID)
	
	;start timer
EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;debug.Notification("controller effect finished, resetting values")
	
	TrueStorms_ShowWeatherEffects.SetValue(1)
	
	;reset everything in case we're in the ambient particle state being OFF 
	Weather.EnableAmbientParticles(True)
	CancelTimer(TimerCheckMarkersID)
EndEvent

Event OnTimer(int aiTimerID)
	If(aiTimerID == TimerCheckMarkersID)
		
		If(IsPlayerNearSoundMarker())
			;debug.notification("we are near a sound marker")
			TrueStorms_ShowWeatherEffects.SetValue(0)
		Else
			;debug.notification("we are not near a sound marker")
			TrueStorms_ShowWeatherEffects.SetValue(1)
		EndIf
		
		StartTimer(TimerCheckMarkersDuration, TimerCheckMarkersID) ;kick the timer off again
	EndIf
EndEvent

Bool Function IsPlayerNearSoundMarker()
	SoundMarkerArray = playerRef.FindAllReferencesOfType(TrueStorms_FList_RainSoundMarkers, ScanDistance)
	 
	If(SoundMarkerArray.Length)
		Return True
	Else
		Return False
	EndIf
EndFunction