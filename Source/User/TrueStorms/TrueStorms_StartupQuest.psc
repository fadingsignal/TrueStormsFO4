Scriptname TrueStorms:TrueStorms_StartupQuest extends Quest

Quest Property MQ102 Auto Const
Spell Property TrueStormsStealthEffectsPlayer Auto Const
Holotape Property TrueStorms_Config_Holotape Auto Const
Holotape Property TrueStorms_WeatherControl_Holotape Auto Const

Event OnInit()

	Actor playerRef = Game.GetPlayer()

    ; Stage 6: Pip-Boy Boot Sequence so the player has it after getting the pip-boy
    If (MQ102.IsStageDone( 6 ))
        AddHolotapeToPlayerInventory()
    Else
        RegisterForRemoteEvent(MQ102, "OnStageSet")
    EndIf
	
	; Just add it plainly as well for when starting the game using COC where no quests trigger or using an existing save
	AddHolotapeToPlayerInventory()
	
	; Check if the player has the old true storms spell, and remove it
	
	If(playerRef.HasSpell(TrueStormsStealthEffectsPlayer))
		playerRef.RemoveSpell(TrueStormsStealthEffectsPlayer)
	EndIf
	
EndEvent

Event Quest.OnStageSet(Quest akSender, int auiStageID, int auiItemID)
    If (akSender == MQ102 && auiStageID == 6 )
        AddHolotapeToPlayerInventory()
        UnregisterForRemoteEvent(MQ102, "OnStageSet")
    EndIf
EndEvent

Function AddHolotapeToPlayerInventory()
	Actor playerRef = Game.GetPlayer()
	
	If(playerRef.GetItemCount(TrueStorms_Config_Holotape) == 0)
		playerRef.AddItem(TrueStorms_Config_Holotape, 1)
	EndIf
	
	If(playerRef.GetItemCount(TrueStorms_WeatherControl_Holotape) == 0)
		playerRef.AddItem(TrueStorms_WeatherControl_Holotape, 1)
	EndIf
EndFunction
