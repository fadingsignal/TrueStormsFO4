;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname TrueStorms:Fragments:Terminals:TERM_TS_WeatherCtrl_TS_01045F40 Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TrueStormsFoggyLight)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TrueStormsMistyRainyLight)
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
TSChangeWeather(TrueStormsRadStormRainHeavy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TrueStormsRadStormRainLight)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TrueStormsRainLight)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_07
Function Fragment_Terminal_07(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(DLC03_RainWeather)
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

;BEGIN FRAGMENT Fragment_Terminal_09
Function Fragment_Terminal_09(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RadFogWeatherHeavy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_10
Function Fragment_Terminal_10(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RadFogWeatherHeavy_Rads)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_11
Function Fragment_Terminal_11(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RadMistWeatherHeavy)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_12
Function Fragment_Terminal_12(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RadStormRainHeavy)
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
TSChangeWeather(TS_DLC03_RadStormRainLight)
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

;BEGIN FRAGMENT Fragment_Terminal_16
Function Fragment_Terminal_16(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RainWeatherLight)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_17
Function Fragment_Terminal_17(ObjectReference akTerminalRef)
;BEGIN CODE
TSChangeWeather(TS_DLC03_RainWeatherMisty)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment


Weather Property CommonwealthDusty Auto Const
Weather Property CommonwealthFoggy Auto Const
Weather Property CommonwealthMistyRainy Auto Const
Weather Property CommonwealthRain Auto Const

Weather Property TrueStormsFoggyLight Auto Const
Weather Property TrueStormsMistyRainyLight Auto Const
Weather Property TrueStormsRadStormRainHeavy Auto Const
Weather Property TrueStormsRadStormRainLight Auto Const
Weather Property TrueStormsRainLight Auto Const

Weather Property DLC03_RainWeather Auto Const
Weather Property TS_DLC03_RadFogWeatherHeavy Auto Const
Weather Property TS_DLC03_RadFogWeatherHeavy_Rads Auto Const
Weather Property TS_DLC03_RadMistWeatherHeavy Auto Const
Weather Property TS_DLC03_RadStormRainHeavy Auto Const
Weather Property TS_DLC03_RadStormRainLight Auto Const
Weather Property TS_DLC03_RainWeatherLight Auto Const
Weather Property TS_DLC03_RainWeatherMisty Auto Const

GlobalVariable Property TrueStorms_WeatherControlUseForce Auto Const

Function TSChangeWeather(Weather weatherID)
	If(TrueStorms_WeatherControlUseForce.GetValue() > 0)
		weatherID.ForceActive()
	Else
		weatherID.SetActive(false, true)
	EndIf
EndFunction
