section .bss
    buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen

section .data
    base: equ 0xf9fe
    old_time: equ base+0x06

section .text
start:
    
    call SetVideoMode
    ;call SetScreen
    call DrawSprite

    ; mov si, OTL
    ; mov di, 0
    ; call DrawMaze

    ; mov si, OTR
    ; mov di, 8
    ; call DrawMaze

    ; mov si, OBL
    ; mov di, 320*8
    ; call DrawMaze

    ; mov si, OBR
    ; mov di, 320*8+8
    ; call DrawMaze

    ; mov si, ITL
    ; mov di, 16
    ; call DrawMaze

    ; mov si, ITR
    ; mov di, 24
    ; call DrawMaze

    ; mov si, IBL
    ; mov di, 320*8+16
    ; call DrawMaze

    ; mov si, IBR
    ; mov di, 320*8+24
    ; call DrawMaze

    ; mov si, LG
    ; mov di, 320*16
    ; call DrawMaze

    ; mov si, LD
    ; mov di, 320*16+8
    ; call DrawMaze

    ; mov si, LU
    ; mov di, 320*24
    ; call DrawMaze

    ; mov si, LB
    ; mov di, 320*24+8
    ; call DrawMaze

    ; mov si, Dot
    ; mov di, 320*16+16
    ; call DrawMaze

    ; mov si, PD
    ; mov di, 320*16+24
    ; call DrawMaze

    ; mov si, E
    ; mov di, 320*24+16
    ; call DrawMaze

    ; mov si, Inter
    ; mov di, 320*24+24
    ; call DrawMaze    

    pusha

gameloop:
; ;waiting...
;     call waiting
    mov ax, 0000h
    int 1ah ; BIOS clock read
    cmp dx, [old_time] ; Wait for change
    je gameloop ; Loop
    mov [old_time], dx
    
    popa
    ;call DrawSprite
    call readKeyboard
;restore the backuped screen above the ghost
    call clearScreen
;move the ghost
    call changePos

; backup the screen before display ghost
    call DrawSprite
    pusha
;return to the beggining of the gameloop
    jmp gameloop

    ; Exit
    ;jmp exit



exit:
    ; Wait for key and terminate the program
    mov al,01h ; Clear buffer
    mov ah,0ch ; Read key
    int 21h ; Execute
    int 20h ; Exit
