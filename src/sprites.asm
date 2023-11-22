
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
        mov bx, [x_PacManPosition]
        mov ax, [y_PacManPosition]
        call calculate_screen_position

        mov ax, [frameOf_PacMan]
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
        ; Number of pixels draw -1 , but just to have a cx = 0000 after the first increment of the loop
        mov cx, 0x00ff ; TODO: DSP

        .draw_loop:
            inc dx ; position in the video memory
            inc cl ; TODO: DSP ; the first execution makes cx = 0000. cl = 00, it will increment until FF

            ; Read the color index
            push cx ; cx contains, in cl the pixels counter from 0 to FF
            shr cx, 1 ; Because there are two pixels in a byte, cx now contains the index of the byte corresponding to this pixel in the sprite
            mov di, spritesheet ; di contains the offset of the spritesheet
            add di, bx ; di contains the offset of the sprite
            add di, cx ; di contains the offset of the byte (from which we want to print the pixel)
            int3 ; ################################ DEBUG ################################
            mov al, [ds:di] ; al contains the value of this byte (see above)

            ; Check if the color is in the high or low nibble
            pop cx ; cl contains the index of the pixel in the sprite (from 00 to FF, for 256 pixels)
            
            test cl, 1 ; TODO: DSP ; if cl is evenor odd, we will read the high or the low nibbble
            jnz .low_byte
            shr ax, 4 ; we move the first nible in the second one
        .low_byte:
            and ax, 0xf ; TODO: DSP ; we want to keep only the second nibble (either the first or the second pixel of the byte if we shifted before or not)
                                    ; and it also allows to set the flag, to know if the actual nibble is 0xF, so a transpaent pixel
            je .transparent_skip

            ; Get color from palette
            mov di, palette ; di contains the offset of the list of colors , the palette
            add di, ax ; we move the offset to the Xeme color

            push 0x489D
            pop ds
            mov al, [ds:di] ;and store the code of this color in al

            ; Set the pixel
            mov di, dx ; di contains the offset corresponding to the position in video memory of the pixel we want to write
            
            push 0xA000
            pop ds
            mov [es:di], al ; writing in video memory

            ; If we need to go to the next line
        .transparent_skip:
            ;it first test if the last nibble of cl is equal to 0xF (if it is equal, ZF = 0)
            not cl
            test cl, 0xf ; TODO: DSP 
            not cl
            jne .draw_loop
            ; if we reached the end of the 16 bits (the last nibble is equal to 0b1111), we move the video memory writing position to the next line by adding the width of the screen
            add dx, SCREEN_WIDTH - SPRITE_SIZE
            ; now we check if we have finished
            cmp cl, 0xff
            jne .draw_loop
    ret