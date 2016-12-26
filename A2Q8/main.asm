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

ROMStart    EQU  $4000  ; absolute address to place my code/constant data

; variable/data section

            ORG RAMStart
 ; Insert here your data definition.
Counter     DS.W 1
FiboRes     DS.W 1


; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS   #RAMEnd+1       ; initialize the stack pointer

            CLI                     ; enable interrupts
mainLoop:
            LDX     #$1000
            LDAA    #01
            
Loop1:      STAA    00,X
            INCA
            INX
            
            CPX     #$100B
            BNE     Loop1
            
            JSR     Separ
            SWI
            
Separ:      LDX     #$1000
            LDY     #$1030
            
Loop2:      LDAA    00,X
            INX
            CMPA    #$04
            BLT     Loop2
            
            ASLA
            ASLA
            STAA    $00,Y
            INY
            
            CPX     #$100B
            BNE     Loop2
            RTS
                           
                           
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
