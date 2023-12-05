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
    isCollided:
        call getCorner
        call getTileAbsPos
        call checkNextTileAbsPos
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
        