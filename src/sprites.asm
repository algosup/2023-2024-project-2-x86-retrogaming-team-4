section .data

    frameOf_Lives dw PACMAN_LEFT_2

    currentDisplayedScoreUnit: db 0
    numberPositionInSpritesheet: dw 0
    scoreBuffer: dd 0

section .text

    Display_PacMan:
    ; display PacMan according to current positions values
    
        mov bx, [strcPacMan + posX]
        mov ax, [strcPacMan + posY]
        call calculate_screen_position
        
        mov ax, [strcPacMan + frame]
        call calculate_spritesheet_position
        call draw_sprite

        ret

    Display_Blinky:
    ; display Blinky and its eyes, according to current positions values
       
        mov bx, [strcBlinky + posX]
        mov ax, [strcBlinky + posY]
        call calculate_screen_position
        push dx
        mov ax, [strcBlinky + frame]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        cmp word[strcBlinky + isChased], 1
        je .noEyes
        mov ax, [strcBlinky + eyes]
        call calculate_spritesheet_position
        call draw_sprite
        .noEyes:
        .noEyes:

        ret
    
    Display_Inky:
    ; display Inky and its eyes, according to current positions values

        mov bx, [strcInky + posX]
        mov ax, [strcInky + posY]
        call calculate_screen_position
        push dx
        mov ax, [strcInky + frame]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        cmp word[strcInky + isChased], 1
        je .noEyes
        mov ax, [strcInky + eyes]
        call calculate_spritesheet_position
        call draw_sprite
        .noEyes:
        .noEyes:

        ret

    Display_Pinky:
    ; display Pinky and its eyes, according to current positions values

        mov bx, [strcPinky + posX]
        mov ax, [strcPinky + posY]
        call calculate_screen_position
        push dx
        mov ax, [strcPinky + frame]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        cmp word[strcPinky + isChased], 1
        je .noEyes
        mov ax, [strcPinky + eyes]
        call calculate_spritesheet_position
        call draw_sprite
        .noEyes:
        .noEyes:

        ret
    
    Display_Clyde:
    ; display Clyde and its eyes, according to current positions values

        mov bx, [strcClyde + posX]
        mov ax, [strcClyde + posY]
        call calculate_screen_position
        push dx
        mov ax, [strcClyde + frame]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        cmp word[strcClyde + isChased], 1
        je .noEyes
        mov ax, [strcClyde + eyes]
        call calculate_spritesheet_position
        call draw_sprite
        .noEyes:
        .noEyes:

        ret
    
    displayFruit:
    ; display the fruit according to its current position values

        mov ax, [fruitSprite]
        call calculate_spritesheet_position
        mov dx, FRUIT_POS_X + FRUIT_POS_Y
        push dx
        call draw_sprite
        pop dx
        call draw_sprite_bg_buffer

        ret

    displayLives:
    ; display the lives according to the current position values
        mov bx, [livesPosX]
        mov ax, TILE_SIZE
        call calculate_screen_position
        push dx
        mov ax, [frameOf_Lives]
        call calculate_spritesheet_position
        call draw_sprite
        pop dx
        call draw_sprite_bg_buffer
        ret

    displayGameOver:
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 72*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*16
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 73*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*17
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 74*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*18
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 75*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*19
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 76*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*21
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 77*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*22
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 75*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*23
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 78*64
        mov di, 17*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*24
        call draw_tile
        ret

    displayNextLevel:
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 79*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*16
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 80*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*17
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 81*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*18
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 82*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*19
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 83*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*21
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 80*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*22
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 84*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*23
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 80*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*24
        call draw_tile
        mov si, MazeSpriteSheet ;Load the spritesheet
        add si, 83*64
        mov di, 0*TILE_SIZE*SCREEN_WIDTH+TILE_SIZE*25
        call draw_tile
        ret

    displayScore:
        mov eax, [score]

        cmp eax, 0 ; Compare if the score is equal to 0
        jne .notZeroDisplayScore
        ret

        .notZeroDisplayScore:
            xor edx, edx
            push eax          ; As eax contains the score, we need to preserve it
            ; tenth

            mov eax, [score]
            mov cx, 10
            div cx
            mov bx, 1
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits

            cmp long[scoreBuffer], 1
            jb .skip
            ; hundredth

            mov eax, [scoreBuffer]
            mov cx, 10
            div cx
            mov bx, 2
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits
            
            cmp long[scoreBuffer], 1
            jb .skip
            ; thousandth

            mov eax, [scoreBuffer]
            mov cx, 10
            div cx
            mov bx, 3
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits

            cmp long[scoreBuffer], 1
            jb .skip
            ; tenth of thousandth

            mov eax, [scoreBuffer]
            mov cx, 10
            div cx
            mov bx, 4
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits

            cmp long[scoreBuffer], 1
            jb .skip
            ; hundredth of thousandth
            
            mov eax, [scoreBuffer]
            mov cx, 10
            div cx
            mov bx, 5
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits

            cmp long[scoreBuffer], 1
            jb .skip
            ; Million
            
            mov eax, [scoreBuffer]
            mov cx, 10
            div cx
            mov bx, 6
            mov long[scoreBuffer], eax
            mov long[scoreUnit], edx
            call displayDigits

            .skip:
            pop eax
            ret


    displayDigits: ;ax usable to store data
        mov si, MazeSpriteSheet ;Load the spritesheet
        cmp long [scoreUnit], 0
        jne .notzero
        add si, 16*64 ;Position on spritesheet
        call .displayScoreOnScreen

        .notzero:
        cmp long [scoreUnit], 1
        jne .notone
        add si, 17*64 ;Position on spritesheet
        call .displayScoreOnScreen


        .notone:
        cmp long [scoreUnit], 2
        jne .nottwo
        add si, 18*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .nottwo:
        cmp long [scoreUnit], 3
        jne .notthree
        add si, 19*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .notthree:
        cmp long [scoreUnit], 4
        jne .notfour
        add si, 20*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .notfour:
        cmp long [scoreUnit], 5
        jne .notfive
        add si, 21*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .notfive:
        cmp long [scoreUnit], 6
        jne .notsix
        add si, 22*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .notsix:
        cmp long [scoreUnit], 7
        jne .notseven
        add si, 23*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .notseven:
        cmp long [scoreUnit], 8
        jne .noteight
        add si, 24*64 ;Position on spritesheet
        call .displayScoreOnScreen
        

        .noteight:
        cmp long [scoreUnit], 9
        jne .notnine
        add si, 25*64 ;Position on spritesheet
        call .displayScoreOnScreen

        .notnine:
        ret
    
        .displayScoreOnScreen:

            mov di, 16*SCREEN_WIDTH+ 22*8 ; Place to display
            cmp bx, 2
            jne .Hundred
            mov di, 16*SCREEN_WIDTH+ 21*8 ; Place to display
            .Hundred:
            cmp bx, 3
            jne .Thousand
            mov di, 16*SCREEN_WIDTH+ 20*8 ; Place to display
            .Thousand:
            cmp bx, 4
            jne .TenThousand
            mov di, 16*SCREEN_WIDTH+ 19*8 ; Place to display
            .TenThousand:
            cmp bx, 5
            jne .HundredThousand
            mov di, 16*SCREEN_WIDTH+ 18*8 ; Place to display
            .HundredThousand:
            cmp bx, 6
            jne .Million
            mov di, 16*SCREEN_WIDTH+ 17*8 ; Place to display
            .Million:

            call draw_tile ;Draw the score unit
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
    ; calculate the linear position of the tile

        .updateThePixeledBuffers:
        ; overwrite the pellet with background color into the screenbuffer and the backgroundbuffer

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

            .writeBgBuffer:
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
                je .writeBgBuffer

        ret
    
    replaceFruit:
        xor ax, ax
        xor bx, bx
        ; replace the 16x16 bloc of pixels where is tile, by the content of the background buffer at the same location, according to its x y positions
        ; calculate the linear position of the tile

        .updateThePixeledBuffers:
        ; overwrite the pellet with background color into the screenbuffer and the backgroundbuffer
            mov bx, FRUIT_POS_X + FRUIT_POS_Y

            ;set the destination 'es:di'
            push word [ScreenBufferSegment] 
            pop es 
            mov di, bx
            mov ah, 1

            ;set the source 'al' : the background color
            mov al, BACKGROUND_COLOR
            mov dx, SPRITE_SIZE

            jmp .writeTheTile

            .writeBgBuffer:
            ;set the destination 'es:di'
            push word [BackgroundBufferSegment] 
            pop es 
            mov di, bx
            mov ah, 0

            
            .writeTheTile:
                ;set the source 'al' : the background color
                mov al, BACKGROUND_COLOR
                
                mov dx, SPRITE_SIZE
                .eachLine:
                    mov cx, SPRITE_SIZE
                    rep stosb
                    add di, SCREEN_WIDTH - SPRITE_SIZE
                    dec dx
                    jnz .eachLine
                cmp ah, 1
                je .writeBgBuffer

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

    draw_tile:
        mov ax, [ScreenBufferSegment]
        mov es, ax
        mov dx, TILE_SIZE ;number of lines
        .eachLine:
            mov cx, TILE_SIZE
            rep movsb
            add di, SCREEN_WIDTH - TILE_SIZE
            dec dx
            cmp dx, 0
            jne .eachLine
        
        ret

    draw_sprite_bg_buffer:
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
            
            push word [BackgroundBufferSegment] 
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