section .bss
    buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen

section .data
    xPos dw 0 
    xVelocity dw 1
    base: equ 0xf9fe
    old_time: equ base+0x06

section .text
start:
    
    call SetVideoMode
    call SetScreen
    
    mov si, [xPos] ; give the position to begin to save the screen
    call saveScreen ; store the state of the screen before display the ghost
; display the selected ghost
    lea si, BLINKY_1 ; selecting the sprite
    call displayGhost
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

;restore the backuped screen above the ghost
    call clearGhost
;move the ghost
    call changePos

; backup the screen before display ghost
    mov si, [xPos] ; give the position to begin to save the screen
    call saveScreen ; store the state of the screen before display the ghost
; display the selected ghost
    lea si, BLINKY_1 ; selecting the sprite
    call displayGhost
    pusha
;return to the beggining of the gameloop
    jmp gameloop

    ; Exit
    jmp exit



