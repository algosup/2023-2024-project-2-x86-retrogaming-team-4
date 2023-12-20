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

        mov ax, [strcPinky + isChased]
        mov [afraid], ax

        mov cx, [strcPinky  + posX]
        mov dx, [strcPinky  + posY]
        call isThereContact
        
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearPinky
            mov word [strcPinky  + posX], 160
            mov word [strcPinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcPinky + frame], PINKY_1
            mov byte [strcPinky + isChased], 0
            call Display_Pinky
        .noGhostCollision:
        ret
        
    BlinkyContact:
        mov ax, [strcBlinky + isChased]
        mov [afraid], ax

        mov cx, [strcBlinky  + posX]
        mov dx, [strcBlinky  + posY]
        call isThereContact

        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearBlinky
            mov word [strcBlinky  + posX], 160
            mov word [strcBlinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcBlinky + frame], BLINKY_1
            mov byte [strcBlinky + isChased], 0
            call Display_Blinky
        .noGhostCollision:
        ret

    InkyContact:
        mov ax, [strcInky + isChased]
        mov [afraid], ax

        mov cx, [strcInky  + posX]
        mov dx, [strcInky  + posY]
        call isThereContact
        
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearInky
            mov word [strcInky  + posX], 160
            mov word [strcInky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcInky + frame], INKY_1
            mov byte [strcInky + isChased], 0
            call Display_Inky
        .noGhostCollision:
        ret
    
    ClydeContact:
        mov ax, [strcClyde + isChased]
        mov [afraid], ax

        mov cx, [strcClyde  + posX]
        mov dx, [strcClyde  + posY]
        call isThereContact
        
        cmp byte [ghostCollision], 1
        jne .noGhostCollision
            call ClearClyde
            mov word [strcClyde  + posX], 160
            mov word [strcClyde  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcClyde + frame], CLYDE_1
            mov byte [strcClyde + isChased], 0
            call Display_Clyde
        .noGhostCollision:
        ret

    isThereContact:
    ; read if a ghost touched pacman (or the reverse)

        mov ax, [strcPacMan + posX]
        mov bx, [strcPacMan + posY]


        call AbsoluteDifference
        cmp ax, TILE_SIZE-3
        jg .notTouched
        
        mov ax, bx
        mov cx, dx
        call AbsoluteDifference
        cmp ax, TILE_SIZE-3
        jg .notTouched
        

        .touched:
            cmp byte [afraid], 0
            je .normalContact
            
        .afraidContact:
            mov byte [ghostCollision], 1
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

    AbsoluteDifference:
    ; get the absolute difference between 2 numbers
    ; parameters :
    ; ax : number 1
    ; cx : number 2
    ; return : ax = absolute difference

        sub ax, cx
        ; get the absolute value of this difference
        mov cx, ax
        sar cx, 15
        xor ax, cx
        shr cx, 15
        add ax, cx

        ret
    


    isColliding:

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
        call isWall
        cmp byte[isCollid], 1
        je .collision

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
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
    
        ;Get the tile's absolute position
        call getTileAbsPos

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
        
        ret