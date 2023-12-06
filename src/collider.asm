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

    cornerNumber db 0

    checkedCornerX dw 0
    checkedCornerY dw 0

    tileAbsPos dw 0
    nextTileAbsPos dw 0

section .text
    isCollided:
        xor cx, cx
        call getCorner
        .cornerLoop:
            mov [cornerNumber], cx
            call chooseCorner
            call getTileAbsPos
            call checkNextTileAbsPos
            cmp byte[isCollid], 1
            jne .end
            cmp cx, 3
            je .end
            inc cx
            jmp .cornerLoop
        .end:
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

    chooseCorner:
        cmp byte[cornerNumber], 0
        jne .not0
        mov bx, [corner0X]
        mov ax, [corner0Y]
        mov [checkedCornerX], bx
        mov [checkedCornerY], ax
        ret
        .not0:

        cmp byte[cornerNumber], 1
        jne .not1
        mov bx, [corner1X]
        mov ax, [corner1Y]
        mov [checkedCornerX], bx
        mov [checkedCornerY], ax
        ret
        .not1:

        cmp byte[cornerNumber], 2
        jne .not2
        mov bx, [corner2X]
        mov ax, [corner2Y]
        mov [checkedCornerX], bx
        mov [checkedCornerY], ax
        ret
        .not2:

        cmp byte[cornerNumber], 3
        jne .not3
        mov bx, [corner3X]
        mov ax, [corner3Y]
        mov [checkedCornerX], bx
        mov [checkedCornerY], ax
        ret
        .not3:

        ret

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
        

    checkNextTileAbsPos:
        mov ax, [tileAbsPos]
        inc ax
        mov [nextTileAbsPos], ax

        mov si, MazeModel5BE 
        add si, [nextTileAbsPos]

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