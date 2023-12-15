section .data
    
    strcBlinkyBehaviour:
        istruc Ghost
            at canRight, db 0
            at canLeft, db 0
            at canUp, db 0
            at canDown, db 0
            at targetX, db 0
            at targetY, db 0
        iend

    strcInkyBehaviour:
        istruc Ghost
            at canRight, db 0
            at canLeft, db 0
            at canUp, db 0
            at canDown, db 0
            at targetX, db 0
            at targetY, db 0
        iend

    strcPinkyBehaviour:
        istruc Ghost
            at canRight, db 0
            at canLeft, db 0
            at canUp, db 0
            at canDown, db 0
            at targetX, db 0
            at targetY, db 0
        iend

    strcClydeBehaviour:
        istruc Ghost
            at canRight, db 0
            at canLeft, db 0
            at canUp, db 0
            at canDown, db 0
            at targetX, db 0
            at targetY, db 0
        iend

    afterMoveTileX dw 0
    afterMoveTileY dw 0
    checkTileX dw 0
    checkTileY dw 0
    checkVelocityX dw 0
    checkVelocityY dw 0

    bestDistance dw 0
    bestVelocityX dw 0
    bestVelocityY dw 0

section .text

    moveGhosts:
        call moveBlinky
        ; call movePinky
        ; call moveInky
        ; call moveClyde
        ret
    
    moveBlinky:
        mov di, strcBlinky
        call moveGhost

        ; TODO
        ; Check if we changed tile
        ; if not changed tile
        ;     ret
        ; if colliding:
        ;     recenter on tile

        ; Change velocity
        mov ax, [strcBlinky + nextVelocityX]
        mov [strcBlinky + velocityX], ax
        mov ax, [strcBlinky + nextVelocityY]
        mov [strcBlinky + velocityY], ax

        ; Initialize best distance, dx and dy
        mov word [bestDistance], 0xffff
        mov word [bestVelocityX], 0
        mov word [bestVelocityY], 0

        ; Check in all directions for the best tile
        ; TODO: Check for overflows (if check tile is outside the maze)
        ; TODO: Skip tile if the tile is in our back
        ; Check up
        mov word [checkVelocityX], 0
        mov word [checkVelocityY], -1
        call checkTile
        ; Check left
        mov word [checkVelocityX], -1
        mov word [checkVelocityY], 0
        call checkTile
        ; Check down
        mov word [checkVelocityX], 0
        mov word [checkVelocityY], 1
        call checkTile
        ; Check right
        mov word [checkVelocityX], 1
        mov word [checkVelocityY], 0
        call checkTile

        ; Set next velocities
        mov ax, [bestVelocityX]
        mov [strcBlinky + nextVelocityX], ax
        mov ax, [bestVelocityY]
        mov [strcBlinky + nextVelocityY], ax

        ret

    moveGhost:
        ; Move
        mov ax, [di + posY]
        add ax, [di + velocityY]
        mov [di + posY], ax
        mov ax, [di + posX]
        add ax, [di + velocityX]
        mov [di + posX], ax
    
        ; Calculate new tile position
        mov bx, TILE_SIZE
        add ax, SPRITE_SIZE / 2
        xor dx, dx
        div bx
        mov [afterMoveTileX], ax
        mov ax, [di + posY]
        add ax, SPRITE_SIZE / 2
        xor dx, dx
        div bx
        mov [afterMoveTileY], ax

        ; TODO: Check collision

        ret
    
    checkTile:
        mov ax, [afterMoveTileX]
        add ax, [checkVelocityX]
        mov [checkTileX], ax
        mov ax, [afterMoveTileY]
        add ax, [checkVelocityY]
        mov [checkTileY], ax

        ; Check if there is a wall
        xor dx, dx
        mov bx, SCREEN_WIDTH / TILE_SIZE
        mul bx
        add ax, [checkTileX]
        mov [tileAbsPos], ax
        call isWall
        cmp byte [isCollid], 1
        je .exit

        ; TODO: Return if tile is in our back

        call calcDistance
        cmp ax, [bestDistance]
        jae .exit ; The priorities have been defined above in case of equality
        mov [bestDistance], ax
        mov ax, [checkVelocityX]
        mov [bestVelocityX], ax
        mov ax, [checkVelocityY]
        mov [bestVelocityY], ax

        .exit:
        ret
    
    calcDistance:
        ;  Calculate the difference in x and y coordinate
        mov ax, [strcPacMan + posX]
        shr ax, 3 
        sub ax, [checkTileX]
        mov bx, [strcPacMan + posY] 
        shr bx, 3
        sub bx, [checkTileY]
    
        ; Calculate the squared values of the differences
        imul ax, ax
        imul bx, bx

        ; add squared in ax
        add ax, bx 
       
        ret

    