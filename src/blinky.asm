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

    afterMoveTileX db 0
    afterMoveTileY db 0

    checkTileX db 0
    checkTileY db 0
    checkVelocityX db 0
    checkVelocityY db 0

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
        mov di, strcBlinkyBehaviour
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
        mov [bestDistance], 0xffff
        mov [bestVelocityX], 0
        mov [bestVelocityY], 0

        ; Check in all directions for the best tile
        ; TODO: Check for overflows (if check tile is outside the maze)
        ; TODO: Skip tile if the tile is in our back
        ; Check up
        mov ax, [afterMoveTileX]
        mov [checkTileX], ax
        mov ax, [afterMoveTileY]
        dec ax
        mov [checkTileY], ax
        call checkTile
        ; Check left
        mov ax, [afterMoveTileX]
        dec ax
        mov [checkTileX], ax
        mov ax, [afterMoveTileY]
        mov [checkTileY], ax
        call checkTile
        ; Check down
        mov ax, [afterMoveTileX]
        mov [checkTileX], ax
        mov ax, [afterMoveTileY]
        inc ax
        mov [checkTileY], ax
        call checkTile
        ; Check right
        mov ax, [afterMoveTileX]
        inc ax
        mov [checkTileX], ax
        mov ax, [afterMoveTileY]
        mov [checkTileY], ax
        call checkTile

        ; Set next velocities
        mov ax, [bestVelocityX]
        mov [strcBlinky + nextVelocityX], ax
        mov ax, [bestVelocityY]
        mov [strcBlinky + nextVelocityY], ax

        ret

    moveGhost:
        ; Move
        add [di + posX], [di + velocityX]
        add [di + posY], [di + velocityY]
    
        ; Calculate new tile position
        mov bx, TILE_SIZE
        mov ax, [di + posX]
        xor dx, dx
        div bx
        mov [afterMoveTileX], ax
        mov ax, [di + posY]
        xor dx, dx
        div bx
        mov [afterMoveTileY], ax

        ; TODO: Check collision

        ret
    
    checkTile:
        ; Check if there is a wall
        xor dx, dx
        mov ax, [checkTileY]
        mov bx, SCREEN_TILE_WIDTH
        mul bx
        add ax, [checkTileX]
        mov [tileAbsPos], ax
        call isWall
        cmp [isCollid], 1
        je .exit

        ; TODO: Return if tile is in our back

        call calcDistance
        cmp ax, [bestDistance]
        jae .exit ; The priorities have been defined above in case of equality
        mov [bestDistance], ax
        mov [bestDistance], ax
        .exit

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

    