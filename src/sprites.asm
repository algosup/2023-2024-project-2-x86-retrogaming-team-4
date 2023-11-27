
section .data

x_PacManPosition dw 10 ; x position of pacman at the beginning (it will be changed each time it will move)
y_PacManPosition dw 10 ; y position of pacman at the beginning (it will be changed each time it will move)
frameOf_PacMan dw PACMAN_FULL

afraid db 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

x_BlinkyPosition dw 30 ; x position of Blinky at the beginning (it will be changed each time it will move)
y_BlinkyPosition dw 100 ; y position of Blinky at the beginning (it will be changed each time it will move)
frameOf_Blinky dw BLINKY_1

x_PinkyPosition dw 50 ; x position of Pinky at the beginning (it will be changed each time it will move)
y_PinkyPosition dw 100 ; y position of Pinky at the beginning (it will be changed each time it will move)
frameOf_Pinky dw PINKY_1

x_ClydePosition dw 70 ; x position of Clyde at the beginning (it will be changed each time it will move)
y_ClydePosition dw 100 ; y position of Clyde at the beginning (it will be changed each time it will move)
frameOf_Clyde dw CLYDE_1

x_InkyPosition dw 90 ; x position of Inky at the beginning (it will be changed each time it will move)
y_InkyPosition dw 100 ; y position of Inky at the beginning (it will be changed each time it will move)
frameOf_Inky dw INKY_1

section .text


    Display_PacMan:
        mov bx, 0;[x_PacManPosition]
        mov ax, 0;[y_PacManPosition]
        call calculate_screen_position

        mov ax, PACMAN_RIGHT_2;[frameOf_PacMan]
        call calculate_spritesheet_position
        call draw_sprite
    ret
    
    ClearPacMan:
        ;movsb mov byte per byte the content of ds:si to es:di, increasing both si and di each time
    ;so we set the adress of the segments and the offsets

    ;set the source 'ds:si' as the backup of the screen
    ;ds is already set as 0x489D where is the backup at [buffScreen]
    lea si, [background_buffer]; load the effective adress (L.E.A.) of the backup in the destination offset

    ;set the source 'ds:si' of the movsb function
    push 0xA000 ; video memory adress = 0xA000
    pop es ; define it as the adress of the destination segment
    mov di, [x_PacManPosition] ; define the offset destination as the same xPos, where was displayed the ghost

    
    ;mov, byte per byte the content of the ghost in the video memory 
    mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite

    .eachLine:
    mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
    rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
    add di, SCREEN_WIDTH - SPRITE_SIZE ; increment the position register to the next line 
    dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
    jnz .eachLine ; while the flag != 0, it continues

ret ; go back in the game loop


    calculate_screen_position:
    ; Set first position on screen
    ; Parameters: y coord in ax, x coord in bx
    ; Result in dx
    ; Override: ax, bx, dx
    push bx
    mov bx, SCREEN_WIDTH
    mul bx
    pop bx
    add ax, bx
    mov dx, ax
    ret

calculate_spritesheet_position:
    ; Set first position on spritesheet
    ; Parameter: sprite ID in ax
    ; Result in bx
    ; Override: ax, bx
    push dx
    mov dx, SPRITE_SIZE * SPRITE_SIZE
    mul dx
    shr ax, 1 ; Because there are two pixels in a byte
    mov bx, ax
    pop dx
    ret

draw_sprite:
    ; TODO: Dynamic sprite size (DSP)
    ; bx: Base position on spritesheet
    ; cx: Index on sprite
    ; dx: Pos on screen

    ; Decrement as increment is at the beginning of the loop
    dec dx
    ; Number of pixels draw
    mov cx, 0x00ff ; TODO: DSP

.draw_loop:
    inc dx
    inc cl ; TODO: DSP

    ; Read the color index
    push cx
    shr cx, 1 ; Because there are two pixels in a byte
    mov di, spritesheet
    add di, bx
    add di, cx
    ;int3 ; ################################ DEBUG ################################
    mov al, [ds:di]

    ; Check if the color is in the high or low nibble
    pop cx
    test cl, 1 ; TODO: DSP
    jnz .low_byte
    shr ax, 4
.low_byte:
    and ax, 0xf ; TODO: DSP
    je .transparent_skip

    ; Get color from palette
    mov di, palette
    add di, ax
    mov al, [ds:di]

    ; Set the pixel
    mov di, dx
    mov [es:di], al

    ; If we need to go to the next line
.transparent_skip:
    not cl
    test cl, 0xf ; TODO: DSP
    not cl
    jne .draw_loop
    add dx, SCREEN_WIDTH - SPRITE_SIZE
    cmp cl, 0xff
    jne .draw_loop
    ret