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

            ;ORG RAMStart
 ; Insert here your data definition.
Counter     DS.W 1
FiboRes     DS.W 1


; code section
        LDAA  $2000            ; Arbitrary value
        LDAB  #$05             ; Functions as counter
        
Loop:   ADDA  #$07
        DECB
        BNE   Loop             ; Repeats 5 times (from Acc B)
        
        CMPA  #$28
        BEQ   Equal            ; Tests value is equal to 0x28
        
        LDAA  #$09             ; Else -> Store in $5001 
        STAA  $5001
        RTS

Equal:  LDAA  #$08             ; If -> Store in $5000
        STAA  $5000
        RTS         

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
