;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname TrueStorms:Fragments:Terminals:TERM_TrueStorms_TerminalConf_03004BE8 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffSneakBuffs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffConstantRads()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffParticleOcclusion()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffPlayerEffects()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffSneakBuffsCompanions()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnPlayerEffects()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnConstantRads()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnSneakBuffs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnSneakBuffsCompanions()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_11
Function Fragment_Terminal_11(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnParticleOcclusion()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_33
Function Fragment_Terminal_33(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOffGhoulHoardsInSettlements()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_34
Function Fragment_Terminal_34(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.TurnOnGhoulHoardsInSettlements()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;The quest that is actually capable of updating global vars -____-
;workshopparentscript Property WorkshopParent Auto mandatory
TrueStorms:TrueStorms_ConfigQuest Property TrueStorms_ConfigQuest Auto Const
