section .data

    frameOf_PacMan dw PACMAN_RIGHT_2

    afraid db 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

    frameOf_Blinky dw BLINKY_1
    frameOf_Blinky_eyes dw EYES_RIGHT

    frameOf_Pinky dw PINKY_1
    frameOf_Pinky_eyes dw EYES_RIGHT

    frameOf_Clyde dw CLYDE_1
    frameOf_Clyde_eyes dw EYES_RIGHT

    frameOf_Inky dw INKY_1
    frameOf_Inky_eyes dw EYES_RIGHT

section .text
    
    Display_PacMan:
    ; display PacMan according to current positions values

        mov bx, [strcPacMan + posX]
        mov ax, [strcPacMan + posY]
        call calculate_screen_position

        mov ax, [frameOf_PacMan]
        call calculate_spritesheet_position
        call draw_sprite

        ret

    Display_Blinky:
    ; display Blinky and its eyes, according to current positions values

        mov bx, [strcBlinky + posX]
        mov ax, [strcBlinky + posY]
        call calculate_screen_position
        push dx
        mov ax, [frameOf_Blinky]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        mov ax, [frameOf_Blinky_eyes]
        call calculate_spritesheet_position
        call draw_sprite

        ret
    
    Display_Inky:
    ; display Inky and its eyes, according to current positions values

        mov bx, [strcInky + posX]
        mov ax, [strcInky + posY]
        call calculate_screen_position
        push dx
        mov ax, [frameOf_Inky]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        mov ax, [frameOf_Inky_eyes]
        call calculate_spritesheet_position
        call draw_sprite

        ret

    Display_Pinky:
    ; display Pinky and its eyes, according to current positions values
        mov bx, [strcPinky + posX]
        mov ax, [strcPinky + posY]
        call calculate_screen_position
        push dx
        mov ax, [frameOf_Pinky]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        mov ax, [frameOf_Pinky_eyes]
        call calculate_spritesheet_position
        call draw_sprite

        ret
    
    Display_Clyde:
    ; display Clyde and its eyes, according to current positions values

        mov bx, [strcClyde + posX]
        mov ax, [strcClyde + posY]
        call calculate_screen_position
        push dx
        mov ax, [frameOf_Clyde]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        mov ax, [frameOf_Clyde_eyes]
        call calculate_spritesheet_position
        call draw_sprite

        ret


    
    ClearPacMan:
    ; replace the 16x16 bloc of pixels where is PacMan, by the content of the background buffer at the same location, according to its x y positions

        mov ax, [strcPacMan + posY]
        mov bx, [strcPacMan + posX]
        call ClearSprite

        ret

    ClearBlinky:
    ; replace the 16x16 bloc of pixels where is Blinky, by the content of the background buffer at the same location, according to its x y positions

        mov ax, [strcBlinky + posY]
        mov bx, [strcBlinky + posX]
        call ClearSprite

        ret

    ClearInky:
    ; replace the 16x16 bloc of pixels where is Inky, by the content of the background buffer at the same location, according to its x y positions

        mov ax, [strcInky + posY]
        mov bx, [strcInky + posX]
        call ClearSprite

        ret

    ClearPinky:
    ; replace the 16x16 bloc of pixels where is Plinky, by the content of the background buffer at the same location, according to its x y positions

        mov ax, [strcPinky + posY]
        mov bx, [strcPinky + posX]
        call ClearSprite

        ret
    
    ClearClyde:
    ; replace the 16x16 bloc of pixels where is Clyde, by the content of the background buffer at the same location, according to its x y positions

        mov ax, [strcClyde + posY]
        mov bx, [strcClyde + posX]
        call ClearSprite

        ret

    ClearSprite:
    ; replace the 16x16 bloc of pixels where is the sprite, by the content of the background buffer at the same location, according to its x y positions

        push es
        push ds
        mov cx, SCREEN_WIDTH
        mul cx
        add bx, ax
        ;set the destination 'es:di' of the movsb function
        push word [ScreenBufferSegment] 
        pop es ; define it as the adress of the destination segment
        mov di, bx ; define the offset destination as the same xPos, where was displayed the ghost
        ;set the source 'ds:si' as the backup of the background
        push word [BackgroundBufferSegment]; load the effective adress (L.E.A.) of the backup in the destination offset
        pop ds
        mov si, di        
        ;mov, byte per byte the content of the ghost in the video memory 
        mov dx, SPRITE_SIZE ; set the counter for 8 lines per sprite

        .eachLine:
            mov cx, SPRITE_SIZE ; set the counter for 8 pixel per line
            rep movsb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
            add di, SCREEN_WIDTH - SPRITE_SIZE
            add si, SCREEN_WIDTH - SPRITE_SIZE ; increment the position register to the next line 
            dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
            jnz .eachLine ; while the flag != 0, it continues

        pop ds     
        pop es

        ret


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
    ; this function needs : 
    ; bx: Base position on spritesheet
    ; dx: Linear position on screen to display

        push es ; pop at the end of the function

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
            
            push word [ScreenBufferSegment] 
            pop es
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

        pop es

        ret
