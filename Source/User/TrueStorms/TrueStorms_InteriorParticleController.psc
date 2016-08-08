Scriptname TrueStorms:TrueStorms_InteriorParticleController extends activemagiceffect
GlobalVariable Property TrueStorms_Config_DoParticleOcclusion Auto
GlobalVariable Property TrueStorms_ShowWeatherEffects Auto

;Disable ambient particles while in interiors so we can turn on RAIN
Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.Notification("INTERIOR Disabling weather particles")
	Weather.EnableAmbientParticles(False)
EndEvent

;Re-enable ambient particles when we're no longer indoors
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;debug.Notification("INTERIOR Enabling weather particles")
	
	; check this value to make sure we are not messing with the exterior particle occluder, which switches this same value and could collide
	
	If(TrueStorms_ShowWeatherEffects.GetValue())
		Weather.EnableAmbientParticles(True)
	Else
		Weather.EnableAmbientParticles(False)
	EndIf
EndEvent
