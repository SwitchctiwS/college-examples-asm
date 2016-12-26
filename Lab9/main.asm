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


  ; Main Program
            LDX   #$2000           ; Starting values for Value loop
            CLRA
            
Values:     STAA  $00,X            ; Stores $00 to $10 
            INX                    ; in $2000 to $2010
            INCA
            CPX   #$2010
            BNE   Values
                        
            LDX   #$2000           ; Starting values for Move loop
            CLRA
            
Move:       LDAA  $00,X            ; Adds #$5, stores $2000 to $200A
            ADDA  #$05             ; in $2030 to $203A
            STAA  $30,X
            INX
            CPX   #$200A
            BNE   Move
     
            RTS
            
                 
            

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
