;#####################
;# XO GAME BY ANDRII #
;#####################
DATA SEGMENT
    PROMPT DB 'MAKE YOUR MOVE:','$'
    WINC DB 13,10,'COMPUTER WIN',13,10,'$'
    NOWIN DB 13,10,'NOONE WIN',13,10,'$'
    IMGMAP DB '123',13,10,'456',13,10,'789',13,10,'$'
    ;MOVE0
    IMG0 DB '...',13,10,'.X.',13,10,'...',13,10,'$'
    ;MOVE1
    IMG1 DB 'O.X',13,10,'.X.',13,10,'...',13,10,'$'
    IMG3 DB 'X.O',13,10,'.X.',13,10,'...',13,10,'$'
    IMG7 DB '...',13,10,'.X.',13,10,'O.X',13,10,'$'
    IMG9 DB '...',13,10,'.X.',13,10,'X.O',13,10,'$'
    ;MOVE2
    IMG17 DB 'O.X',13,10,'XX.',13,10,'O..',13,10,'$'
    IMG39 DB 'X.O',13,10,'.XX',13,10,'..O',13,10,'$'
    IMG71 DB 'O..',13,10,'XX.',13,10,'O.X',13,10,'$'
    IMG93 DB '..O',13,10,'.XX',13,10,'X.O',13,10,'$'
    ;MOVE3
    IMG176 DB 'O.X',13,10,'XXO',13,10,'O.X',13,10,'$'
    IMG394 DB 'X.O',13,10,'OXX',13,10,'X.O',13,10,'$'
    IMG716 DB 'O.X',13,10,'XXO',13,10,'O.X',13,10,'$'
    IMG934 DB 'X.O',13,10,'OXX',13,10,'X.O',13,10,'$'
    
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA

INPUT:
    MOV AH,1
    INT 21H    
    RET

    
PRINT:
    MOV AX,DATA
    MOV DS,AX
    MOV AH,9
    INT 21H
    RET

    
CLS:
    MOV AH,02H
    MOV DH,0
    MOV DL,0
    INT 10H
    RET

    
EXIT:
    MOV AH,4CH
    INT 21H
    RET

    
FWINC:
    MOV DX,OFFSET WINC
    CALL PRINT
    CALL EXIT
    RET

    
FNOWIN:
    MOV DX,OFFSET NOWIN
    CALL PRINT
    CALL EXIT
    RET

    
SWIMG:
    CALL CLS
    MOV DX,BX
    CALL PRINT
    MOV DX,OFFSET PROMPT
    CALL PRINT
    CALL INPUT ; RETURN USER INPUT IN AL
    RET

    
MOVE:
       
    CMP AL,'1'
    JE JM1
     
    CMP AL,'3'
    JE JM3
    
    CMP AL,'7'
    JE JM7
    
    CMP AL,'9'
    JE JM9
    
    JM1: JMP M1
    JM3: JMP M3
    JM7: JMP M7
    JM9: JMP M9
    
    ;IF NOT 1 OR 3 OR 7 OR 9 FWINC
    JMP FWINC
    RET
    

;=== START M1 ===
M1:
    MOV BX,OFFSET IMG1
    CALL SWIMG
    CMP AL,'7'
    JE M17
    JMP FWINC
    
M17:
    MOV BX,OFFSET IMG17
    CALL SWIMG
    CMP AL,'6'
    JE M176
    JMP FWINC

M176:
    MOV BX,OFFSET IMG176
    CALL SWIMG
    JMP FNOWIN

;=== END M1 ===


;=== START M3 ===
M3:
    MOV BX,OFFSET IMG3
    CALL SWIMG
    CMP AL,'9'
    JE M39
    JMP FWINC
    
M39:
    MOV BX,OFFSET IMG39
    CALL SWIMG
    CMP AL,'4'
    JE M394
    JMP FWINC

M394:
    MOV BX,OFFSET IMG394
    CALL SWIMG
    JMP FNOWIN

;=== END M3 ===


;=== START M7 ===
M7:
    MOV BX,OFFSET IMG7
    CALL SWIMG
    CMP AL,'1'
    JE M71
    JMP FWINC
    
M71:
    MOV BX,OFFSET IMG71
    CALL SWIMG
    CMP AL,'6'
    JE M716
    JMP FWINC

M716:
    MOV BX,OFFSET IMG716
    CALL SWIMG
    JMP FNOWIN

;=== END M7 ===


;=== START M9 ===
M9:
    MOV BX,OFFSET IMG9
    CALL SWIMG
    CMP AL,'3'
    JE M93
    JMP FWINC
    
M93:
    MOV BX,OFFSET IMG93
    CALL SWIMG
    CMP AL,'4'
    JE M934
    JMP FWINC

M934:
    MOV BX,OFFSET IMG934
    CALL SWIMG
    JMP FNOWIN

;=== END M9 ===

 
START:
    ;BX AS BUFFER FOR DX
    MOV BX,OFFSET IMG0
    CALL SWIMG
    CALL MOVE
      
    JMP EXIT
    
CODE ENDS
    END START