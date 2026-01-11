Scriptname TrueStorms:TrueStorms_ConfigQuest extends Quest

Actor Property PlayerRef Auto Const

Group Spells
	SPELL Property TrueStorms_WeatherEffects_Main_V1_4 Auto Const
	SPELL Property TrueStorms_WeatherEffects_Negative_v1_4 Auto Const
	SPELL Property TrueStorms_WeatherEffects_Companion_v1_4 Auto Const
	SPELL Property TrueStorms_WeatherEffects_GhoulAttacks_v1_4 Auto Const
EndGroup

Group Globals
	GlobalVariable Property TrueStorms_Config_PlayerEffectsEnabled Auto
	GlobalVariable Property TrueStorms_Config_DoConstantRads Auto
	GlobalVariable Property TrueStorms_Config_DoSneakBuffs Auto
	GlobalVariable Property TrueStorms_Config_DoSneakBuffsCompanion Auto
	GlobalVariable Property TrueStorms_Config_DoParticleOcclusion Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardChance Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardsInSettlements Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardFrequency Auto
	GlobalVariable Property TrueStorms_Config_GhoulHoardMax Auto	
EndGroup

Group Companions
	Actor Property CaitRef const auto
	Actor Property CurieRef const auto
	Actor Property CodsworthRef const auto
	Actor Property BoSPaladinDanseRef const auto
	Actor Property DeaconRef const auto
	Actor Property HancockRef const auto
	Actor Property CompMacCreadyRef const auto
	Actor Property PiperRef const auto
	Actor Property PrestonRef const auto
	Actor Property StrongRef const auto
	Actor Property ValentineRef const auto
	Actor Property X688Ref const auto
	Actor Property DogmeatRef Auto Const ;Dogmeat
	Actor Property DLC03_CompanionOldLongfellowRef Auto Const ;Far Harbor
EndGroup

;No longer used
Function ChangeTrueStormsGlobalSetting(GlobalVariable globalToChange, Int valueToUpdate)
	globalToChange.SetValue(valueToUpdate)
EndFunction

;Synchronize GlobalVariable with spells in the event that GlobalVariable is changed in the plugin
;Called from external scripts later because this quest is set to "Start Game Enabled"
Bool Function SyncPlayerEffectsWithGlobals()

	;If this was set prior, we'll need to restore it once we sync things up since it gets reset
	Int iGhoulHoardChance = TrueStorms_Config_GhoulHoardChance.GetValueInt()

	If(TrueStorms_Config_PlayerEffectsEnabled.GetValueInt() == 1)
		TurnOnPlayerEffects()
		If(iGhoulHoardChance > 0)
			SetGhoulHoardChance(iGhoulHoardChance)
		EndIf
	Else
		TurnOffPlayerEffects()
	EndIf
	return true ;this always returns true because we just need to check if it even ran
EndFunction

;Have simple methods to call from fragments just to keep it very very clear 

; ===================================================================
; "Public" switch functions called from UI / Holotape
; ===================================================================

;These on/off functions turn off the ENTIRETY of True Storms' effects
Function TurnOnPlayerEffects()

	;Main Effects
	If(!PlayerRef.HasSpell(TrueStorms_WeatherEffects_Main_V1_4))
		PlayerRef.AddSpell(TrueStorms_WeatherEffects_Main_V1_4, False)
	EndIf

	;Hazard Effects
	If(!PlayerRef.HasSpell(TrueStorms_WeatherEffects_Negative_v1_4))
		PlayerRef.AddSpell(TrueStorms_WeatherEffects_Negative_v1_4, False)
	EndIf
	
	;Ghoul Hoards
	If(!PlayerRef.HasSpell(TrueStorms_WeatherEffects_GhoulAttacks_v1_4))
		PlayerRef.AddSpell(TrueStorms_WeatherEffects_GhoulAttacks_v1_4, False)
	EndIf

	TrueStorms_Config_PlayerEffectsEnabled.SetValue(1)
	
	;Reset everything to default ===============
	; DEFAULTS
	; ==================================
	
	TurnOnConstantRads()
	TurnOnSneakBuffs()
	TurnOnSneakBuffsCompanions()
	TurnOnParticleOcclusion()
	SetGhoulHoardChance(0)

	debug.notification("True Storms effects are now ON.")
	
EndFunction

Function TurnOffPlayerEffects()

	;Main Spell
	If(PlayerRef.HasSpell(TrueStorms_WeatherEffects_Main_V1_4))
		PlayerRef.RemoveSpell(TrueStorms_WeatherEffects_Main_V1_4)
	EndIf

	;Hazard Spell
	If(PlayerRef.HasSpell(TrueStorms_WeatherEffects_Negative_v1_4))
		PlayerRef.RemoveSpell(TrueStorms_WeatherEffects_Negative_v1_4)
	EndIf
	
	;Ghoul Hoard Spell

	If(PlayerRef.HasSpell(TrueStorms_WeatherEffects_GhoulAttacks_v1_4))
		PlayerRef.RemoveSpell(TrueStorms_WeatherEffects_GhoulAttacks_v1_4)
	EndIf
	
	TrueStorms_Config_PlayerEffectsEnabled.SetValue(0)

	;Turn off suboptions (just to be clean)
	
	TurnOffConstantRads()
	TurnOffSneakBuffs()
	TurnOffSneakBuffsCompanions()
	TurnOffParticleOcclusion()
	SetGhoulHoardChance(0)
	
	Utility.Wait(1.0)
	
	Weather.EnableAmbientParticles(True) ;combinations of magic effects can cause this to turn off
	
	debug.notification("True Storms effects are now OFF.")
EndFunction

Function TurnOnConstantRads()
	TrueStorms_Config_DoConstantRads.SetValue(1)
EndFunction

Function TurnOffConstantRads()
	TrueStorms_Config_DoConstantRads.SetValue(0)
EndFunction

Function TurnOnSneakBuffs()
	TrueStorms_Config_DoSneakBuffs.SetValue(1)
EndFunction

Function TurnOffSneakBuffs()
	TrueStorms_Config_DoSneakBuffs.SetValue(0)
EndFunction

Function TurnOnSneakBuffsCompanions()
	TrueStorms_Config_DoSneakBuffsCompanion.SetValue(1)
	
	ApplySpellToActor(CaitRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(CurieRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(CodsworthRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(BoSPaladinDanseRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(DeaconRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(HancockRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(CompMacCreadyRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(PiperRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(PrestonRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(StrongRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(ValentineRef, TrueStorms_WeatherEffects_Companion_v1_4)
	ApplySpellToActor(X688Ref, TrueStorms_WeatherEffects_Companion_v1_4)
	
	ApplySpellToActor(DogmeatRef, TrueStorms_WeatherEffects_Companion_v1_4) ;dogmeat
	
	If(DLC03_CompanionOldLongfellowRef != None)
		ApplySpellToActor(DLC03_CompanionOldLongfellowRef, TrueStorms_WeatherEffects_Companion_v1_4) ;Far Harbor (Longfellow)
	EndIf
	
EndFunction

Function TurnOffSneakBuffsCompanions()
	TrueStorms_Config_DoSneakBuffsCompanion.SetValue(0)
	
	RemoveSpellFromActor(CaitRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(CurieRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(CodsworthRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(BoSPaladinDanseRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(DeaconRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(HancockRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(CompMacCreadyRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(PiperRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(PrestonRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(StrongRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(ValentineRef, TrueStorms_WeatherEffects_Companion_v1_4)
	RemoveSpellFromActor(X688Ref, TrueStorms_WeatherEffects_Companion_v1_4)
	
	RemoveSpellFromActor(DogmeatRef, TrueStorms_WeatherEffects_Companion_v1_4) ;dogmeat
	
	If(DLC03_CompanionOldLongfellowRef != None)
		RemoveSpellFromActor(DLC03_CompanionOldLongfellowRef, TrueStorms_WeatherEffects_Companion_v1_4) ;Far Harbor (Longfellow)
	EndIf
	
EndFunction

Function TurnOnParticleOcclusion()
	TrueStorms_Config_DoParticleOcclusion.SetValue(1)
EndFunction

Function TurnOffParticleOcclusion()
	TrueStorms_Config_DoParticleOcclusion.SetValue(0)
EndFunction

Function SetGhoulHoardChance(Int ghoulHoardChance)
	TrueStorms_Config_GhoulHoardChance.SetValue(ghoulHoardChance)
EndFunction 

Function SetGhoulHoardFrequency(Int ghoulHoardFrequency)
	TrueStorms_Config_GhoulHoardFrequency.SetValue(ghoulHoardFrequency)
EndFunction

Function SetGhoulHoardMax(Int ghoulHoardMax)
	TrueStorms_Config_GhoulHoardMax.SetValue(ghoulHoardMax)
EndFunction

Function TurnOnGhoulHoardsInSettlements()
	TrueStorms_Config_GhoulHoardsInSettlements.SetValue(1)
EndFunction

Function TurnOffGhoulHoardsInSettlements()
	TrueStorms_Config_GhoulHoardsInSettlements.SetValue(0)
EndFunction

;============================================================
; Internal Functions
;============================================================

Function ApplySpellToActor(Actor actorToApply, Spell spellToApply)
	If(!actorToApply.HasSpell(spellToApply))
		actorToApply.AddSpell(spellToApply, false)
	EndIf
EndFunction

Function RemoveSpellFromActor(Actor actorToRemove, Spell spellToRemove)
	If(actorToRemove.HasSpell(spellToRemove))
		actorToRemove.RemoveSpell(spellToRemove)
	EndIf
EndFunction