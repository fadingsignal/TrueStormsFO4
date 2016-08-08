ScriptName TrueStorms:TrueStorms_WeatherEffectsView extends ActiveMagicEffect

VisualEffect Property CameraAttachVisualEffect Auto Const
GlobalVariable Property TrueStorms_ShowWeatherEffects Auto
GlobalVariable Property TrueStorms_Config_DoParticleOcclusion Auto

Actor playerRef
Int VisualEffectDuration = 0 ;doesn't matter because cell transitions clip the effect anyway
Weather currentWeather

;Turning ON the visual effects (pretty smooth)
Event OnEffectStart(Actor akTarget, Actor akCaster)
	;debug.Notification("view effect starting")
	;CameraAttachVisualEffect.Play(Game.GetPlayer(), VisualEffectDuration)
	;Utility.Wait(3)
	Weather.EnableAmbientParticles(True)
	;CameraAttachVisualEffect.Stop(Game.GetPlayer())
EndEvent

;Turning OFF the visual effects (kinda clunky but can't do anything about it)
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	;debug.Notification("view effect ending")
	;CameraAttachVisualEffect.Play(Game.GetPlayer(), VisualEffectDuration)
	;Utility.Wait(2)
	
	If(TrueStorms_Config_DoParticleOcclusion.GetValue())
		Weather.EnableAmbientParticles(False)
	Else
		Weather.EnableAmbientParticles(True) ;this is so if we turn the config OFF, the particles don't stay turned off forever (oops!)
	EndIf
	
	;Utility.Wait(1)
	;CameraAttachVisualEffect.Stop(Game.GetPlayer())
EndEvent

