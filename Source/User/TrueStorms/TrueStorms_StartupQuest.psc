Scriptname TrueStorms:TrueStorms_StartupQuest extends Quest

Quest Property MQ102 Auto Const
TrueStorms:TrueStorms_ConfigQuest Property ConfigQuest Auto Const
Int Property CharGenStageToWatch = 10 Auto Const
Holotape Property TrueStorms_Config_Holotape Auto Const
Holotape Property TrueStorms_WeatherControl_Holotape Auto Const

Event OnInit()
	CheckStageToSet()
EndEvent

Event Quest.OnStageSet(quest akSendingQuest, int CharGenStage, int StageItem)
	CheckStageToSet()
EndEvent

Function CheckStageToSet()
	if MQ102.GetStageDone(ChargenStageToWatch) == true
		AddHolotapeToPlayerInventory()
		UnregisterForRemoteEvent(MQ102, "OnStageSet")
		ConfigQuest.SyncPlayerEffectsWithGlobals() ;Ensure player effects are set properly on game to match what's in the plugin
		Stop()
	else
		RegisterForRemoteEvent(MQ102, "OnStageSet")
	endif
EndFunction

Function AddHolotapeToPlayerInventory()
	Actor playerRef = Game.GetPlayer()
	
	If(!playerRef.GetItemCount(TrueStorms_Config_Holotape))
		playerRef.AddItem(TrueStorms_Config_Holotape, 1)
	EndIf
	
	If(!playerRef.GetItemCount(TrueStorms_WeatherControl_Holotape))
		playerRef.AddItem(TrueStorms_WeatherControl_Holotape, 1)
	EndIf
EndFunction
