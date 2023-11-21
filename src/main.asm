
<<<<<<< Updated upstream

<<<<<<< Updated upstream
;%ifndef "entry.asm"
;%endif "entry.asm"


section .bss

buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen
=======
>>>>>>> Stashed changes

section .data

xPos dw 0 
xVelocity dw 1


=======
>>>>>>> Stashed changes
section .text

start:
    ; Set video mode to 320x200 256 colors graphic mode
    call set_video
   

;------------------------------------------------------------------

;THE GAME LOOP

;-------------



    
    call fill_color_
    mov al, 0x18 ; color to fill the screen (white = 0x0F, black = 0x00)
    call clearScreen

    gameloop:
    push 0xA000
    pop es
; backup the screen before display ghost
    mov si, [xPos] ; give the position to begin to save the screen
    call saveScreen ; store the state of the screen before display the ghost

; display the selected ghost
    

;waiting...
    call waiting
    

;restore the backuped screen above the ghost
    call clearGhost

;move the ghost
    call changePos

;return to the beggining of the gameloop
    jmp gameloop



mov ax, 0C01h ; 
int 21h

;dos box default video mode
mov ax, 03h 
int 21h

int 20h ;quit




