EESchema Schematic File Version 2  date Mon 08 Apr 2013 08:47:42 PM BRT
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:heatbed-cache
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Heat Bed for Metamáquina 2"
Date "6 mar 2013"
Rev "0.9"
Comp "Gustavo Barbosa Monteiro Bruno for Metamáquina"
Comment1 "Licensed under GNU GPLv3 (or later)"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LED D1
U 1 1 512592B6
P 3850 5000
F 0 "D1" H 3850 5100 50  0000 C CNN
F 1 "GREEN_LED" H 3850 4900 50  0000 C CNN
F 2 "LED-0805" H 3850 5000 60  0000 C CNN
F 3 "" H 3850 5000 60  0000 C CNN
	1    3850 5000
	0    -1   -1   0   
$EndComp
$Comp
L THERMISTOR TH1
U 1 1 512596CC
P 3250 5150
F 0 "TH1" V 3350 5200 50  0000 C CNN
F 1 "100k" V 3150 5150 50  0000 C CNN
F 2 "SM0805" H 3250 5150 60  0000 C CNN
F 3 "" H 3250 5150 60  0000 C CNN
	1    3250 5150
	0    -1   -1   0   
$EndComp
$Comp
L MOUNTING_HOLE MH1
U 1 1 5133CB70
P 5750 4550
F 0 "MH1" H 5750 4250 60  0000 C CNN
F 1 "MOUNTING_HOLE" H 5750 4350 60  0000 C CNN
F 2 "MountingHole_3mm_RevA_Date21Jun2010" H 5750 3800 60  0000 C CNN
F 3 "~" H 5750 3800 60  0000 C CNN
	1    5750 4550
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING_HOLE MH2
U 1 1 5133CB7D
P 6550 4550
F 0 "MH2" H 6550 4250 60  0000 C CNN
F 1 "MOUNTING_HOLE" H 6550 4350 60  0000 C CNN
F 2 "MountingHole_3mm_RevA_Date21Jun2010" H 6550 3800 60  0000 C CNN
F 3 "~" H 6550 3800 60  0000 C CNN
	1    6550 4550
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING_HOLE MH4
U 1 1 5133CB83
P 6550 5050
F 0 "MH4" H 6550 4750 60  0000 C CNN
F 1 "MOUNTING_HOLE" H 6550 4850 60  0000 C CNN
F 2 "MountingHole_3mm_RevA_Date21Jun2010" H 6550 4300 60  0000 C CNN
F 3 "~" H 6550 4300 60  0000 C CNN
	1    6550 5050
	1    0    0    -1  
$EndComp
$Comp
L MOUNTING_HOLE MH3
U 1 1 5133CB89
P 5750 5050
F 0 "MH3" H 5750 4750 60  0000 C CNN
F 1 "MOUNTING_HOLE" H 5750 4850 60  0000 C CNN
F 2 "MountingHole_3mm_RevA_Date21Jun2010" H 5750 4300 60  0000 C CNN
F 3 "~" H 5750 4300 60  0000 C CNN
	1    5750 5050
	1    0    0    -1  
$EndComp
$Comp
L CONN_4 P1
U 1 1 5133D6B0
P 2450 5200
F 0 "P1" V 2400 5200 50  0000 C CNN
F 1 "CONN_4" V 2500 5200 50  0000 C CNN
F 2 "bornier4" H 2450 5200 60  0000 C CNN
F 3 "" H 2450 5200 60  0000 C CNN
	1    2450 5200
	-1   0    0    1   
$EndComp
Text Label 4200 5650 1    60   ~ 12
Heater 1
$Comp
L THERMISTOR TH2
U 1 1 51340120
P 3250 4900
F 0 "TH2" V 3350 4950 50  0000 C CNN
F 1 "100k" V 3150 4900 50  0000 C CNN
F 2 "SM0603" H 3250 4900 60  0000 C CNN
F 3 "" H 3250 4900 60  0000 C CNN
	1    3250 4900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5150 6300 2800 6300
Wire Wire Line
	2800 4800 5150 4800
Connection ~ 3850 4800
Wire Wire Line
	5150 4800 5150 6300
Connection ~ 3850 6300
Connection ~ 4850 4800
Wire Wire Line
	4850 4800 4850 6300
Wire Wire Line
	4550 4800 4550 6300
Wire Wire Line
	4250 4800 4250 6300
Connection ~ 4250 4800
Connection ~ 4550 4800
Connection ~ 4250 5300
Connection ~ 4550 5300
Connection ~ 4850 5300
Connection ~ 5150 5300
Connection ~ 5150 4800
Wire Wire Line
	2800 4800 2800 5050
Wire Wire Line
	2800 6300 2800 5350
Wire Wire Line
	2800 5150 3000 5150
Wire Wire Line
	3500 5150 3600 5150
Wire Wire Line
	3600 5150 3600 5250
Wire Wire Line
	3600 5250 2800 5250
Connection ~ 2800 5050
Connection ~ 2800 5150
Connection ~ 2800 5250
Connection ~ 2800 5350
Wire Wire Line
	3850 5800 3850 5200
Connection ~ 4250 6300
Connection ~ 4550 6300
Connection ~ 4850 6300
Connection ~ 5150 6300
Connection ~ 4250 5800
Connection ~ 4550 5800
Connection ~ 4850 5800
Connection ~ 5150 5800
Wire Wire Line
	3000 5150 3000 4900
Wire Wire Line
	3500 4900 3500 5150
Connection ~ 3500 5150
Connection ~ 3500 4900
Connection ~ 3000 4900
Connection ~ 3000 5150
$Comp
L R R1
U 1 1 512592C5
P 3850 6050
F 0 "R1" V 3930 6050 50  0000 C CNN
F 1 "1k" V 3850 6050 50  0000 C CNN
F 2 "SM0805" H 3850 6050 60  0000 C CNN
F 3 "" H 3850 6050 60  0000 C CNN
	1    3850 6050
	1    0    0    1   
$EndComp
$Comp
L AYLONS N1
U 1 1 5136AF98
P 11000 7000
F 0 "N1" H 10700 7550 60  0000 C CNN
F 1 "AYLONS" H 10700 7400 60  0000 C CNN
F 2 "~" H 10900 7100 60  0000 C CNN
F 3 "~" H 10900 7100 60  0000 C CNN
	1    11000 7000
	1    0    0    -1  
$EndComp
$EndSCHEMATC
