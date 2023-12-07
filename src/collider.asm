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
    nextTileAbsPos dw 0

section .text
    isCollided:
        call getCorner
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
        jne .skip

        .collision:
        call stopPackMan
        .skip:
    
        ret

    

    getCorner:
        mov bx, [strcPacMan + posX]
        add bx, 5
        mov [corner0X], bx
        mov ax, [strcPacMan + posY]
        add ax, 5
        mov [corner0Y], ax

        mov bx, [strcPacMan + posX]
        add bx, 5
        mov [corner1X], bx
        mov ax, [strcPacMan + posY]
        add ax, 12
        mov [corner1Y], ax

        mov bx, [strcPacMan + posX]
        add bx, 12
        mov [corner2X], bx
        mov ax, [strcPacMan + posY]
        add ax, 5
        mov [corner2Y], ax

        mov bx, [strcPacMan + posX]
        add bx, 12
        mov [corner3X], bx
        mov ax, [strcPacMan + posY]
        add ax, 12
        mov [corner3Y], ax

        ret


    ; Get absolute position of tile
    ; Param: checkedCornerX, checkedCornerY
    ; Return: tileAbsPos
    getTileAbsPos:
        mov ax, [checkedCornerX]
        mov cx, 8
        div cx   
        mov bx, ax
        mov ax, [checkedCornerY]
        div cx
        mov cx, SCREEN_WIDTH/8
        mul cx
        mov [tileAbsPos], ax
        ret
        
    isWall:
        ;Take the next tile's Absolute Position in ax
        mov ax, [tileAbsPos]

        ;Read the chosen tile in the maze table
        mov si, MazeModel5BE
        add si, [tileAbsPos]

        ;compare all the differents wall's sprites and return is collided if the compare is equal
        cmp si, 1
        jne .not1
        mov byte[isCollid], 1
        ret
        .not1:

        cmp si, 2
        jne .not2
        mov byte[isCollid], 1
        ret
        .not2:

        cmp si, 3
        jne .not3
        mov byte[isCollid], 1
        ret
        .not3:

        cmp si, 4
        jne .not4
        mov byte[isCollid], 1
        ret
        .not4:

        cmp si, 5
        jne .not5
        mov byte[isCollid], 1
        ret
        .not5:

        cmp si, 6
        jne .not6
        mov byte[isCollid], 1
        ret
        .not6:

        cmp si, 7
        jne .not7
        mov byte[isCollid], 1
        ret
        .not7:

        cmp si, 8
        jne .not8
        mov byte[isCollid], 1
        ret
        .not8:

        cmp si, 9
        jne .not9
        mov byte[isCollid], 1
        ret
        .not9:

        cmp si, 0xA
        jne .notA
        mov byte[isCollid], 1
        ret
        .notA:

        cmp si, 0xB
        jne .notB
        mov byte[isCollid], 1
        ret
        .notB:

        cmp si, 0xC
        jne .notC
        mov byte[isCollid], 1
        ret
        .notC:
        
        ret
