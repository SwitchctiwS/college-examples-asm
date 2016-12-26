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
N           EQU     $14        ; Symbol N is $14

            ORG     $5000      ; Array starting at $5000 of length $14
            DC.B    $1, $3, $5, $6, $19, $41, $53, $28, $13, $42, $76, $14, $20, $54, $64, $74, $29, $33, $41, $45
            

            ORG RAMStart


; code section
            ORG   ROMStart


Entry:
_Startup:
            LDS   #RAMEnd+1       ; initialize the stack pointer

            CLI                     ; enable interrupts

mainLoop:
            LDAB    #N              ; Load Acc B with value of N ($14)
            LDX     #$5000          ; Load X with address where array will be read
            LDY     #$5100          ; Load Y with address where odd nums will be stored
            
Loop:       LDAA    1,X+
            BITA    #$01            ; If LSB = 1, number is odd
            BEQ     Count           ; If odd, store in Y address
            
            STAA    1,Y+            
            
Count:      DECB                    ; Loop N times, finish when done
            BNE     Loop                          
            
            RTS            

;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   $FFFE
            DC.W  Entry           ; Reset Vector
