section .data

    blinkyNextPosX dw 0
    blinkyNextPosY dw 0

    isCollidBlinky db 0
section .text

    blinkyAi:
    
        call getBlinkyNextPos
        call isCollidingBlinky
        cmp byte[isCollidBlinky], 1
        je .collision

        call moveBlinky
        ret

        .collision:
        call stopBlinky
        ret



    getBlinkyNextPos:
        mov ax, [strcBlinky + posX]
        mov bx, [strcBlinky + posY]
        add ax, [strcBlinky + velocityX]
        add bx, [strcBlinky + velocityY]
        mov [blinkyNextPosX], ax
        mov [blinkyNextPosY], bx
        ret

    moveBlinky:
        mov ax, [strcBlinky + posX]
        mov bx, [strcBlinky + posY]
        add ax, [strcBlinky + velocityX]
        add bx, [strcBlinky + velocityY]
        mov [strcBlinky + posX], ax
        mov [strcBlinky + posY], bx
        ret

    
    isCollidingBlinky: 
        call getCornersBlinky
        ; Set corner to check
        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollidBlinky], 1
        je .collision

        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollidBlinky], 1
        je .collision

        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall
        cmp byte[isCollidBlinky], 1
        je .collision

        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call isWall

        cmp byte[isCollidBlinky], 1
        je .collision
        ret

        .collision:
        call stopBlinky
    
        ret
    
    getCornersBlinky:
    ; Get the corner of the blinky tile

        mov bx, [blinkyNextPosX]
        add bx, 4
        mov [corner0X], bx
        mov ax, [blinkyNextPosY]
        add ax, 4
        mov [corner0Y], ax

        mov bx, [blinkyNextPosX]
        add bx, 4
        mov [corner1X], bx
        mov ax, [blinkyNextPosY]
        add ax, 11
        mov [corner1Y], ax

        mov bx, [blinkyNextPosX]
        add bx, 11
        mov [corner2X], bx
        mov ax, [blinkyNextPosY]
        add ax, 4
        mov [corner2Y], ax

        mov bx, [blinkyNextPosX]
        add bx, 11
        mov [corner3X], bx
        mov ax, [blinkyNextPosY]
        add ax, 11
        mov [corner3Y], ax

        ret
    





        
