<<<<<<< Updated upstream
;!!!PARAMETERS!!!;
;input the position of the ghost which will be displayed, into 'si'
saveScreen:
    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets
=======
section .bss

background_buffer resb SCREEN_WIDTH*_HEIGHT ; where is stored the dynamic background (pellet or not) to restore it behind the ghosts

section .data

    xPos dw 0 
    xVelocity dw 1



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

>>>>>>> Stashed changes
    ;set the destinatin 'es:di'. Here , the begginning of the screen backup in [bufferScreen]
    push ds ; ds is the data segment where is [bufferScreen]
    pop es ; put it as the destination segment of movsb
    lea di, [buffScreen] ; load the effective adress (L.E.A.) of the backup in the destination offset
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
    ;set the source 'ds:si' to A000:xpos  (it's needed to have si defined before the call)
    push 0xA000 ; video memory adress = 0xA000
    pop ds ; define it as the adress of the source segment
    ;'si' had been set up before
    
    ;mov, byte per byte the content into buffscreen
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues
    
    ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning
    push es 
    pop ds
<<<<<<< Updated upstream
    
ret ; go back in the game loop
displayGhost:
    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets
    ;set the destinatin 'es:di'. Here , the screen at the xPos position
    mov di, [xPos] ; the offset destination is xPos
    ;the destination 'es' is already at its right value : the data segment 0x489D
=======
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

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
ret ; go back in the game loop
=======

ret ; go back in the game loop


>>>>>>> Stashed changes
clearGhost:
    
    ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
    ;set the source 'ds:si' of the movsb function
    push 0xA000 ; video memory adress = 0xA000
    pop es ; define it as the adress of the destination segment
    mov di, [xPos] ; define the offset destination as the same xPos, where was displayed the ghost
<<<<<<< Updated upstream
    ;set the source 'ds:si' as the backup of the screen
    ;ds is already set as 0x489D where is the backup at [buffScreen]
    lea si, [buffScreen]; load the effective adress (L.E.A.) of the backup in the destination offset
    ;mov, byte per byte the content of the ghost in the video memory 
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite
=======

    ;set the source 'ds:si' as the backup of the screen
    ;ds is already set as 0x489D where is the backup at [buffScreen]
    lea si, [buffScreen]; load the effective adress (L.E.A.) of the backup in the destination offset

    ;mov, byte per byte the content of the ghost in the video memory 
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite

>>>>>>> Stashed changes
    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITE_SIZE ; increment the position register to the next line 
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues
<<<<<<< Updated upstream
ret ; go back in the game loop
changePos:
=======

ret ; go back in the game loop


waiting:
    push cx
    mov cx, 0x0FFF ; how many times we repeat the loop
    waitloop:
    loop waitloop ; we jump FFFF times, so , many times, to make a delay in the program
    pop cx

ret ; go back in the game loop


changePos:

>>>>>>> Stashed changes
;switch the direction if the ghost reached a side of the screen
    cmp word [xPos], SCREEN_WIDTH - SPRITE_SIZE 
    jb .noflip
    neg word [xVelocity]
    .noflip:
<<<<<<< Updated upstream
=======

>>>>>>> Stashed changes
;inc/decremente the position
    mov bx, [xPos]
    add bx, [xVelocity]
    mov [xPos], bx
ret