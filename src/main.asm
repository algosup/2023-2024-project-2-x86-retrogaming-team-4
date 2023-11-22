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
