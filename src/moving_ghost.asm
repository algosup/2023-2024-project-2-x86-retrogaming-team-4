org 100h
 
%define SPRITEW 16
%define SCREEN_WIDTH 320
section .bss
buffScreen resb SPRITEW*SPRITEW ; where is stored the backuped screen
section .data
xPos dw 0 
xVelocity dw 1
base: equ 0xf9fe
old_time: equ base+0x06
; draw the radioactive ghost
blinky  db 0xFF, 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF, 0xFF
        db 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF
        db 0x0A, 0x0A, 0x0f, 0x00, 0x0A, 0x0f, 0x00, 0x0A
        db 0x0A, 0x0A, 0x0f, 0x0f, 0x0A, 0x0f, 0x0f, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0xFF, 0x0A, 0x0A, 0xFF, 0x0A, 0x0A, 0x0A
        
        db 0xFF, 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF, 0xFF
        db 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF
        db 0x0A, 0x0A, 0x0f, 0x00, 0x0A, 0x0f, 0x00, 0x0A
        db 0x0A, 0x0A, 0x0f, 0x0f, 0x0A, 0x0f, 0x0f, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0xFF, 0x0A, 0x0A, 0xFF, 0x0A, 0x0A, 0x0A
        
        db 0xFF, 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF, 0xFF
        db 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF
        db 0x0A, 0x0A, 0x0f, 0x00, 0x0A, 0x0f, 0x00, 0x0A
        db 0x0A, 0x0A, 0x0f, 0x0f, 0x0A, 0x0f, 0x0f, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0xFF, 0x0A, 0x0A, 0xFF, 0x0A, 0x0A, 0x0A
        db 0xFF, 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF, 0xFF
        db 0xFF, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0xFF
        db 0x0A, 0x0A, 0x0f, 0x00, 0x0A, 0x0f, 0x00, 0x0A
        db 0x0A, 0x0A, 0x0f, 0x0f, 0x0A, 0x0f, 0x0f, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A
        db 0x0A, 0xFF, 0x0A, 0x0A, 0xFF, 0x0A, 0x0A, 0x0A
 
section .text
;set the video mode
   mov ah, 00h ; set video mode requirement
   mov al, 13h ; set video mode option to 320 x 200 256 colors
   int 10h ; call the dos interupt regarding to ax
;clear the screen
    mov al, 0x18 ; color to fill the screen (white = 0x0F, black = 0x00)
    call clearScreen
;------------------------------------------------------------------
;THE GAME LOOP
;-------------

; backup the screen before display ghost
    mov si, [xPos] ; give the position to begin to save the screen
    call saveScreen ; store the state of the screen before display the ghost
; display the selected ghost
    lea si, blinky ; selecting the sprite
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
    lea si, blinky ; selecting the sprite
    call displayGhost
    pusha
;return to the beggining of the gameloop
    jmp gameloop
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
    mov dx, SPRITEW ; set the counter for 8 lines per sprite
    .eachLine:
    mov cx, SPRITEW ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues
    
    ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning
    push es 
    pop ds
    
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
    mov dx, SPRITEW ; set the counter for 8 lines per sprite
    
    .eachLine:
    mov cx, SPRITEW ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITEW ; increment the position register to the next line 
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
    mov dx, SPRITEW ; set the counter for 8 lines per sprite
    .eachLine:
    mov cx, SPRITEW ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITEW ; increment the position register to the next line 
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues
ret ; go back in the game loop
waiting:
    mov cx, 0xFFFF ; how many times we repeat the loop
    waitloop:
    loop waitloop ; we jump FFFF times, so , many times, to make a delay in the program
ret ; go back in the game loop
changePos:
;switch the direction if the ghost reached a side of the screen
    cmp word [xPos], SCREEN_WIDTH - SPRITEW 
    jb .noflip
    neg word [xVelocity]
    .noflip:
;inc/decremente the position
    mov bx, [xPos]
    add bx, [xVelocity]
    mov [xPos], bx
ret