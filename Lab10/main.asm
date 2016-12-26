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

  ; User defined:
Data        EQU  $5000
StoredData  EQU  $5001
Count       EQU  $5002
BitTest:    EQU  $80
      

; variable/data section
  
            ORG RAMStart
 ; Insert here your data definition.
; no

; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS   #RAMEnd+1       ; initialize the stack pointer

            CLI                   ; enable interrupts
            
            
            
mainLoop:                              
            CLR   StoredData      ; Make sure 5001, 5002 are 00
            CLR   Count           
            
            LDAA  Data            ; Load whatever is in 5000
            BEQ   Done            ; Finish if 5000 = 00
            
Loop:       BITA  #BitTest        ; Tests if MSB = 1
            BNE   Store           ; Finish if true
            
            ASLA                  ; Do shift, then counter++
            INC   Count           ; Always loop because condition will eventually be met
            BRA   Loop
            
Store:      STAA  StoredData      ; Store value in 5001
Done:       RTS                   




;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
