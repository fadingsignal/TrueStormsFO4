ScriptName TrueStorms:TrueStorms_WeatherEffectsViewInt extends ActiveMagicEffect

GlobalVariable Property TrueStorms_Config_UseVisualEffectController Auto

;Disable ambient particles while in interiors so we can turn on RAIN
Event OnEffectStart(Actor akTarget, Actor akCaster)
	debug.Notification("INTERIOR Disabling weather particles")
	Weather.EnableAmbientParticles(False)
EndEvent

;Re-enable ambient particles when we're no longer indoors
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	debug.Notification("INTERIOR Enabling weather particles")
	Weather.EnableAmbientParticles(True)
EndEvent

