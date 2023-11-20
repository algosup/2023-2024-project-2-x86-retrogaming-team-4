

;%ifndef "entry.asm"
;%endif "entry.asm"


section .bss

buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen

section .data

xPos dw 0 
xVelocity dw 1


section .text

start:
    ; Set video mode to 320x200 256 colors graphic mode
    mov ax, 0013h
    int 10h
    

    


    ;;;;;;;;;;;;;;;;;;;;;;
    ;;                  ;;
    ;;  MAIN CODE HERE  ;;
    ;;                  ;;
    ;;;;;;;;;;;;;;;;;;;;;;


    
;------------------------------------------------------------------

;THE GAME LOOP

;-------------



    
    mov al, 0x18 ; color to fill the screen (white = 0x0F, black = 0x00)
    call clearScreen

    gameloop:
    push 0xA000
    pop es
; backup the screen before display ghost
    mov si, [xPos] ; give the position to begin to save the screen
    call saveScreen ; store the state of the screen before display the ghost

; display the selected ghost
    
    mov ax, 80
    mov bx, [xPos]
    call calculate_screen_position
    push dx
    mov ax, PACMAN_FULL
    call calculate_spritesheet_position
    call draw_sprite
    pop dx
    

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




;------------------------------------------------------------------

;THE FUNCTIONS

;-------------


;!!!PARAMETERS!!!;
;to select the color to use to fill, you need this color into 'al'
clearScreen:
    
    ;stosb copy byte per byte the content of al to es:di, di increasing.
    ;so we set the adress of the segments and the offsets

    ;set the destination 'es:di' :

    push 0xA000 ; video memory adress = 0xA000
    pop es ; define it as the adress of the destination segment

    mov di, 0 ; begin the offset (pixel position) at 0

    mov cx, 200*320 ; how many times 'rep' action will be repeated
    rep stosb ; store (byte per byte) the content of al into es:di, es = 0xA000, di increasing from 0 to 200*320

ret ; go back in the game loop


;!!!PARAMETERS!!!;
;input the position of the ghost which will be displayed, into 'si'
saveScreen:

    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets

    ;set the destinatin 'es:di'. Here , the begginning of the screen backup in [bufferScreen]
    push ds ; ds is the data segment where is [bufferScreen]
    pop es ; put it as the destination segment of movsb
    lea di, [buffScreen] ; load the effective adress (L.E.A.) of the backup in the destination offset

    ;set the source 'ds:si' to A000:xpos  (it's needed to have si defined before the call)
    push 0xA000 ; video memory adress = 0xA000
    pop ds ; define it as the adress of the source segment
    ;'si' had been set up before
    
    ;mov, byte per byte the content into buffscreen
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite

    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues
    
    ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning
    push es 
    pop ds
    push 0xA000
    pop es
    
ret ; go back in the game loop


;!!!PARAMETERS!!!;
;to select the ghost to print, you need to put the sprite address in 'si' (using 'lea si, blinky')
displayGhost:

    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets

    ;set the destinatin 'es:di'. Here , the screen at the xPos position
    mov di, [xPos] ; the offset destination is xPos
    ;the destination 'es' is already at its right value : the data segment 0x489D

    ;select the source 'ds:si' of the movsb function
    push 0xA000 ; video memory adress = 0xA000
    pop es ; define it as the adress of the destination segment
    ;'si' had been set up before
    
    ;mov, byte per byte the content of the ghost in the video memory 
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite
    
    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITE_SIZE ; increment the position register to the next line 
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues

ret ; go back in the game loop


clearGhost:
    
    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets

    ;set the source 'ds:si' of the movsb function
    push 0xA000 ; video memory adress = 0xA000
    pop es ; define it as the adress of the destination segment
    mov di, [xPos] ; define the offset destination as the same xPos, where was displayed the ghost

    ;set the source 'ds:si' as the backup of the screen
    ;ds is already set as 0x489D where is the backup at [buffScreen]
    lea si, [buffScreen]; load the effective adress (L.E.A.) of the backup in the destination offset

    ;mov, byte per byte the content of the ghost in the video memory 
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite

    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITE_SIZE ; increment the position register to the next line 
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues

ret ; go back in the game loop


waiting:
    push cx
    mov cx, 0x0FFF ; how many times we repeat the loop
    waitloop:
    loop waitloop ; we jump FFFF times, so , many times, to make a delay in the program
    pop cx

ret ; go back in the game loop


changePos:

;switch the direction if the ghost reached a side of the screen
    cmp word [xPos], SCREEN_WIDTH - SPRITE_SIZE 
    jb .noflip
    neg word [xVelocity]
    .noflip:

;inc/decremente the position
    mov bx, [xPos]
    add bx, [xVelocity]
    mov [xPos], bx
ret