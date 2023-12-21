section .data
    isCollid db 0

    cornerOffsetX dW 0
    cornerOffsetY dW 0

    checkedCornerX dw 0
    checkedCornerY dw 0

    tileAbsPos dw 0

    ghostCollision db 0

    isGameOver db 0

section .text

    readContact:
    ; check if pacman hit a ghost
            call BlinkyContact
            call InkyContact
            call PinkyContact
            call ClydeContact
            ret

    PinkyContact:
        mov bx, [strcPinky  + posX]
        mov ax, [strcPinky  + posY]
        mov dx, [strcPinky + isChased]
        mov [afraid], dx
        call isThereContact
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearPinky
            mov word [strcPinky  + posX], 156
            mov word [strcPinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcPinky + frame], PINKY_1
            mov byte [strcPinky + isChased], 0
            mov word [strcPinky + velocityX], 0
            mov word [strcPinky + velocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcPinky + nextVelocityX], 0
            mov word [strcPinky + nextVelocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcPinky + eyes], EYES_UP
            call Display_Pinky
        .noGhostCollision:
        ret
        
    BlinkyContact:
        mov bx, [strcBlinky  + posX]
        mov ax, [strcBlinky  + posY]
        mov dx, [strcBlinky + isChased]
        mov [afraid], dx
        call isThereContact
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearBlinky
            mov word [strcBlinky  + posX], 156
            mov word [strcBlinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcBlinky + frame], BLINKY_1
            mov byte [strcBlinky + isChased], 0
            mov word [strcBlinky + velocityX], 0
            mov word [strcBlinky + velocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcBlinky + nextVelocityX], 0
            mov word [strcBlinky + nextVelocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcBlinky + eyes], EYES_UP
            call Display_Blinky
        .noGhostCollision:
        ret

    InkyContact:
        mov bx, [strcInky  + posX]
        mov ax, [strcInky  + posY]
        mov dx, [strcInky + isChased]
        mov [afraid], dx
        call isThereContact
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearInky
            mov word [strcInky  + posX], 156
            mov word [strcInky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcInky + frame], INKY_1
            mov byte [strcInky + isChased], 0
            mov word [strcBlinky + velocityX], 0
            mov word [strcInky + velocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcInky + nextVelocityX], 0
            mov word [strcInky + nextVelocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcInky + eyes], EYES_UP
            call Display_Inky
        .noGhostCollision:
        ret
    
    ClydeContact:
        mov bx, [strcClyde  + posX]
        mov ax, [strcClyde  + posY]
        mov dx, [strcClyde + isChased]
        mov [afraid], dx
        call isThereContact
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearClyde
            mov word [strcClyde  + posX], 156
            mov word [strcClyde  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcClyde + frame], CLYDE_1
            mov byte [strcClyde + isChased], 0
            mov word [strcClyde + velocityX], 0
            mov word [strcClyde + velocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcClyde + nextVelocityX], 0
            mov word [strcClyde + nextVelocityY], -1*SPRITE_SPEED_PIXELS
            mov word [strcClyde + eyes], EYES_UP
            call Display_Clyde
        .noGhostCollision:
        ret


    isThereContact:
    ; read if a ghost touched pacman (or the reverse)

        push ds ; pop at the end

        ;calculates the linear position of the ghost (result in ax)
        mov cx, SCREEN_WIDTH
        mul cx
        add ax, bx 

        ;stores the color of pacman into 'ah'
        mov di, palette
        inc di, ;(add 1 to di) cause '1' is the color of pacman according to the palette of colors for the spritesheet
        xor bx, bx
        mov bl, [ds:di]

        ;the destination is 'al'
        
        ;set the source 'ds:si'
        push word [ScreenBufferSegment]
        pop ds
        mov si, ax  
        
        mov dx, SPRITE_SIZE
        .eachLine:
            mov cx, SPRITE_SIZE
            .eachPixel:
                lodsb
                cmp al, bl
                je .touched
                dec cx
                jnz .eachPixel
            add si, SCREEN_WIDTH - SPRITE_SIZE
            dec dx
            jnz .eachLine
        pop ds
        jmp .notTouched

        .touched:
            pop ds
            cmp byte [afraid], 0
            je .normalContact
            
        .afraidContact:
            mov byte [ghostCollision], 1
            inc byte [killStreak]
            cmp byte [killStreak], 1
            jne .notOne
                add long [score], 20
                add word[scoreForLife], 20
            .notOne:

            cmp byte [killStreak], 2
            jne .notTwo
                add long [score], 40
                add word[scoreForLife], 40
            .notTwo:

            cmp byte [killStreak], 3
            jne .notThree
                add long [score], 80
                add word[scoreForLife], 80
            .notThree:

            cmp byte [killStreak], 4
            jne .notFour
                add long [score], 160
                add word[scoreForLife], 160
            .notFour:

            jmp .notTouched

        .normalContact:

            mov word [frameOf_Lives], BLACK
            call whereToDisplayLife
            call displayLives
            dec byte [lifeCounter]
            cmp byte [lifeCounter], 0
            jne .notGameOver
                mov byte [isGameOver], 1
            .notGameOver:
            
            mov word [strcBlinky + isChased], 0
            mov word [strcPinky + isChased], 0
            mov word [strcInky + isChased], 0
            mov word [strcClyde + isChased], 0
            mov word [strcPacMan + isDead], 1

        .notTouched:
        
        ret
    
    isColliding:

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
        call getTileAbsPos
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
        call getTileAbsPos
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
        call getTileAbsPos
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
        call getTileAbsPos
        call isWall
        cmp byte[isCollid], 1
        je .collision
        ret

        .collision:
        call stopPacMan
    
        ret

    ; Set offset for the corner to check
    ; Param: cornerOffsetX, cornerOffsetX
    ; Return: checkedCornerX, checkedCornerY
    getCorners:
    ; Get the corner of the PacMan tile
        mov bx, [pacManNextPosX]
        add bx, [cornerOffsetX]
        mov [checkedCornerX], bx
        mov ax, [pacManNextPosY]
        add ax, [cornerOffsetX]
        mov [checkedCornerY], ax

        ret
   
    getTileAbsPos:
    ; Get absolute position of tile
    ; Param: checkedCornerX, checkedCornerY
    ; Return: tileAbsPos

        mov ax, [checkedCornerY]
        shr ax, 3
        mov bx, SCREEN_WIDTH/8
        mul bx
        mov [tileAbsPos], ax

        mov ax, [checkedCornerX]
        shr ax, 3
        add [tileAbsPos], ax

        ret

    isWall:
    ; Check if the tile is a wall
        mov byte [isCollid], 0

        ;Read the chosen tile in the maze table
        mov si, MazeModelBuffer
        add si, [tileAbsPos]
        
        ;compare all the differents wall's sprites and return is collided if the compare is equal
        cmp byte[si], 0x01
        jne .not1
        mov byte[isCollid], 1
        ret
        .not1:

        cmp byte[si], 0x02
        jne .not2
        mov byte[isCollid], 1
        ret
        .not2:

        cmp byte[si], 0x03
        jne .not3
        mov byte[isCollid], 1
        ret
        .not3:

        cmp byte[si], 0x04
        jne .not4
        mov byte[isCollid], 1
        ret
        .not4:

        cmp byte[si], 0x05
        jne .not5
        mov byte[isCollid], 1
        ret
        .not5:

        cmp byte[si], 0x06
        jne .not6
        mov byte[isCollid], 1
        ret
        .not6:

        cmp byte[si], 0x07
        jne .not7
        mov byte[isCollid], 1
        ret
        .not7:

        cmp byte[si], 0x08
        jne .not8
        mov byte[isCollid], 1
        ret
        .not8:

        cmp byte[si], 0x09
        jne .not9
        mov byte[isCollid], 1
        ret
        .not9:

        cmp byte[si], 0x0A
        jne .notA
        mov byte[isCollid], 1
        ret
        .notA:

        cmp byte[si], 0x0B
        jne .notB
        mov byte[isCollid], 1
        ret
        .notB:

        cmp byte[si], 0x0C
        jne .notC
        mov byte[isCollid], 1
        ret
        .notC:

        cmp byte[si], 0x55
        jne .notDoorUp
        mov byte[isCollid], 1
        ret
        .notDoorUp:

        cmp byte[si], 0x56
        jne .notDoorDown
        mov byte[isCollid], 1
        ret
        .notDoorDown:
        
        ret