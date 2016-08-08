;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname TrueStorms:Fragments:Terminals:TERM_TS_Weather_FarHarbor_01045F41 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03AtomM01_RadStorm)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_ClearWeather)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_RadFogWeather)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_RainWeather)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(dlc03_radmistweatherFast)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_08
Function Fragment_Terminal_08(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_ClearWeatherFast)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_14
Function Fragment_Terminal_14(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_RadMistWeather)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_15
Function Fragment_Terminal_15(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_RadStorm)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function TSChangeWeather(Weather weatherID)
	If(TrueStorms_WeatherControlUseForce.GetValue() > 0)
		weatherID.ForceActive()
	Else
		weatherID.SetActive(false, true)
	EndIf
EndFunction

Weather Property DLC03AtomM01_RadStorm Auto Const

Weather Property DLC03_ClearWeather Auto Const

Weather Property DLC03_ClearWeatherFast Auto Const

Weather Property DLC03_RadFogWeather Auto Const

Weather Property DLC03_RadMistWeather Auto Const

Weather Property dlc03_radmistweatherFast Auto Const

Weather Property DLC03_RadStorm Auto Const

Weather Property DLC03_RainWeather Auto Const

GlobalVariable Property TrueStorms_WeatherControlUseForce Auto Const
