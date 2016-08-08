;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname TrueStorms:Fragments:Terminals:TERM_TrueStorms_TerminalConf_0202682A Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.SetGhoulHoardFrequency(0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.SetGhoulHoardFrequency(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.SetGhoulHoardFrequency(2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
TrueStorms_ConfigQuest.SetGhoulHoardFrequency(3)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

TrueStorms:TrueStorms_ConfigQuest Property TrueStorms_ConfigQuest Auto Const
