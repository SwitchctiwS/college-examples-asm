;*****************************************************************
;* This stationery serves as the framework for a                 *
;* user application (single file, absolute assembly application) *
;* For a more comprehensive program that                         *
;* demonstrates the more advanced functionality of this          *
;* processor, please see the demonstration applications          *
;* located in the examples subdirectory of the                   *
;* Freescale CodeWarrior for the HC12 Program directory          *
;*****************************************************************

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 

ROMStart    EQU     $4000  ; absolute address to place my code/constant data
Switches    EQU     $8000
Leds        EQU     $9000
AllOn       EQU     $FF
AllOff      EQU     $00      

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.
Counter     DS.W 1
FiboRes     DS.W 1


; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS     #RAMEnd+1       ; initialize the stack pointer

            CLI                     ; enable interrupts
mainLoop:
Loop:       
            LDAA    Switches
            CMPA    #$56
            BLT     Led_On
            
            LDAB    #AllOff
            STAB    Leds
            BRA     Done
            
Led_On:
            LDAB    #AllOn
            STAB    Leds
            BRA     Done
            
Done:       SWI

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
