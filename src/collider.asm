section .data

    corner0X dw 0
    corner0Y dw 0
    corner1X dw 0
    corner1Y dw 0
    corner2X dw 0
    corner2Y dw 0
    corner3X dw 0
    corner3Y dw 0

    isCollid db 0

    checkedCornerX dw 0
    checkedCornerY dw 0

    tileAbsPos dw 0

    ghostCollision db 0

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
            mov word [strcPinky  + posX], 160
            mov word [strcPinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcPinky + frame], PINKY_1
            mov byte [strcPinky + isChased], 0
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
            mov word [strcBlinky  + posX], 160
            mov word [strcBlinky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcBlinky + frame], BLINKY_1
            mov byte [strcBlinky + isChased], 0
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
            mov word [strcInky  + posX], 160
            mov word [strcInky  + posY], 108
            mov byte [ghostCollision], 0
            mov word [strcInky + frame], INKY_1
            mov byte [strcInky + isChased], 0
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
            jmp .notTouched

        .normalContact:
            mov word [strcBlinky + isChased], 0
            mov word [strcPinky + isChased], 0
            mov word [strcInky + isChased], 0
            mov word [strcClyde + isChased], 0
            mov word [strcPacMan + isDead], 1

        .notTouched:
        
        ret

    isColliding:

        call getCorners
        ; Set corner to check
        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollid], 1
        je .collision

        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollid], 1
        je .collision

        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollid], 1
        je .collision

        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall

        cmp byte[isCollid], 1
        je .collision
        ret

        .collision:
        call stopPacMan
    
        ret
    
    getCorners:
    ; Get the corner of the PacMan tile

        mov bx, [pacManNextPosX]
        add bx, 4
        mov [corner0X], bx
        mov ax, [pacManNextPosY]
        add ax, 4
        mov [corner0Y], ax

        mov bx, [pacManNextPosX]
        add bx, 4
        mov [corner1X], bx
        mov ax, [pacManNextPosY]
        add ax, 11
        mov [corner1Y], ax

        mov bx, [pacManNextPosX]
        add bx, 11
        mov [corner2X], bx
        mov ax, [pacManNextPosY]
        add ax, 4
        mov [corner2Y], ax

        mov bx, [pacManNextPosX]
        add bx, 11
        mov [corner3X], bx
        mov ax, [pacManNextPosY]
        add ax, 11
        mov [corner3Y], ax

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
