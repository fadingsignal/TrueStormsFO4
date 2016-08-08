;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname TrueStorms:Fragments:Terminals:TERM_TS_WeatherControl_01045F3F Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthClear)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthClearestSkies)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthFoggy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthOvercast)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthGSRadstorm)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthGSFoggy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthGSOvercast)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthDusty)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_13
Function Fragment_Terminal_13(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthRain)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_14
Function Fragment_Terminal_14(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthMisty)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_15
Function Fragment_Terminal_15(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(CommonwealthMistyRainy)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Weather Property CommonwealthClear Auto Const
Weather Property CommonwealthClearestSkies Auto Const
Weather Property CommonwealthDusty Auto Const
Weather Property CommonwealthFoggy Auto Const
Weather Property CommonwealthGSFoggy Auto Const
Weather Property CommonwealthGSOvercast Auto Const
Weather Property CommonwealthGSRadstorm Auto Const
Weather Property CommonwealthMisty Auto Const
Weather Property CommonwealthMistyRainy Auto Const
Weather Property CommonwealthOvercast Auto Const
Weather Property CommonwealthRain Auto Const
GlobalVariable Property TrueStorms_WeatherControlUseForce Auto Const

Function TSChangeWeather(Weather weatherID)
	If(TrueStorms_WeatherControlUseForce.GetValue() > 0)
		weatherID.ForceActive()
	Else
		weatherID.SetActive(false, true)
	EndIf
EndFunction
