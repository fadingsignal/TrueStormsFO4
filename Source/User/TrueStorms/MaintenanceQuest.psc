Scriptname TrueStorms:MaintenanceQuest extends Quest

TrueStorms:TrueStorms_ConfigQuest Property ConfigQuest Auto Const

;The target here is for saves that are already running, but it will run on game start as well

;Do once to fix issues with 2.0.2
Event OnQuestInit()
	RegisterForRemoteEvent(Game.GetPlayer(), "OnPlayerLoadGame")
	ConfigQuest.SyncPlayerEffectsWithGlobals()
EndEvent

Event Actor.OnPlayerLoadGame(Actor akSender)
	RunMaintenanceTasks()
EndEvent

Function RunMaintenanceTasks()
	;reserved
EndFunction