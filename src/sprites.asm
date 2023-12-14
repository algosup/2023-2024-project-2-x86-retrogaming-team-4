section .data

    frameOf_PacMan dw PACMAN_RIGHT_2

    frameOf_Blinky dw BLINKY_1
    frameOf_Blinky_eyes dw EYES_RIGHT

    frameOf_Pinky dw PINKY_1
    frameOf_Pinky_eyes dw EYES_RIGHT

    frameOf_Clyde dw CLYDE_1
    frameOf_Clyde_eyes dw EYES_RIGHT

    frameOf_Inky dw INKY_1
    frameOf_Inky_eyes dw EYES_RIGHT

    afraid dw 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

    animationCounter dw 0
    directionBuffer dw 2

section .text

    AnimatePacMan:
    ; changes at least the orientation of the frame, and, if the timer is reached, it switchs to the second frame of the actual orientation.
        
        inc word [animationCounter] ; counter is from 0 to 6 (6 frames = 0.25 seconds)

        mov bx, word[frameOf_PacMan] ; ax contain the id of the actual frame
        mov cl, 2
        mov ax, [strcPacMan + direction]
        mov dx, ax
        mul cl
        add ax, 16 ; ax contains the id of the frame "..._1" (the first) of the direction of pacman

        cmp  word [animationCounter], 0x6 ; check the timer
        jne .noAnimation
        
        mov word [animationCounter],0 ; reset the counter/timer
        call SwitchMouthOpening ; toogle the frame

        ret

        .noAnimation:
            call UpdateFrameOfPacman 
            ret
        

    UpdateFrameOfPacman:
    ; just to change the direction if necessary, to have a reactive changing of orientation when a key is pressed

        cmp dx, word [directionBuffer] ; checks if the direction had changed from the last time
        jne .changeDirection

        ret

        .changeDirection:
            mov word[frameOf_PacMan],  ax
            mov word [directionBuffer], dx

            ret

    SwitchMouthOpening:
    ; just toogle the frame of pacman if opened -> closed, and the reverse

        cmp ax, bx ; checks if the actual frame is the '_1'
        je .toSecondFrame

        mov word[frameOf_PacMan],  ax ; as the frame loaded in ax was the first one

        ret

        .toSecondFrame:
            inc ax ; as the frame loaded in ax was the first one
            mov word[frameOf_PacMan],  ax
            
            ret


    Display_PacMan:
    ; display PacMan according to current positions values
        call AnimateSprites ; to update the frame for animation
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

        ;poped at the end
        push es
        push ds

        ;calculate the linear position of the sprite
        mov cx, SCREEN_WIDTH
        mul cx
        add bx, ax

        ;set the destination 'es:di'
        push word [ScreenBufferSegment] 
        pop es 
        mov di, bx

        ;set the source 'ds:si'
        push word [BackgroundBufferSegment]
        pop ds
        mov si, di      
         
        mov dx, SPRITE_SIZE

        .eachLine:
            mov cx, SPRITE_SIZE
            rep movsb
            add di, SCREEN_WIDTH - SPRITE_SIZE
            add si, SCREEN_WIDTH - SPRITE_SIZE
            dec dx
            jnz .eachLine

        pop ds     
        pop es

        ret

    replaceTile:
        ; replace the 8x8 bloc of pixels where is tile, by the content of the background buffer at the same location, according to its x y positions
        ;calculate the linear position of the tile
        mov cx, SCREEN_WIDTH
        mul cx
        add bx, ax

        ;set the destination 'es:di'
        push word [ScreenBufferSegment] 
        pop es 
        mov di, bx
        mov ah, 1

        ;set the source 'al' : the background color
        mov al, BACKGROUND_COLOR
        mov dx, TILE_SIZE

        jmp .writeTheTile

        .nowTheBackgroundBuffer:
        ;set the destination 'es:di'
        push word [BackgroundBufferSegment] 
        pop es 
        mov di, bx
        mov ah, 0

        
        .writeTheTile:
            ;set the source 'al' : the background color
            mov al, BACKGROUND_COLOR
            
            mov dx, TILE_SIZE
            .eachLine:
                mov cx, TILE_SIZE
                rep stosb
                add di, SCREEN_WIDTH - TILE_SIZE
                dec dx
                jnz .eachLine
            cmp ah, 1
            je .nowTheBackgroundBuffer  

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
