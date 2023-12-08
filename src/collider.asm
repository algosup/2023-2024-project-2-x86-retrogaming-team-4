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

section .text
    
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
        call stopPackMan
    
        ret

    
    ; Get the corner of the PacMan tile
    getCorners:
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


    ; Get absolute position of tile
    ; Param: checkedCornerX, checkedCornerY
    ; Return: tileAbsPos
    getTileAbsPos:
        mov ax, [checkedCornerY]
        shr ax, 3
        mov bx, SCREEN_WIDTH/8
        mul bx
        mov [tileAbsPos], ax

        mov ax, [checkedCornerX]
        shr ax, 3
        add [tileAbsPos], ax
        ret

    ; Check if the tile is a wall
    isWall:
        ;Get the tile's absolute position
        call getTileAbsPos

        ;Read the chosen tile in the maze table
        mov si, MazeModel
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
