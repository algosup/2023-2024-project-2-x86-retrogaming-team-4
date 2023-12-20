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

    beforeMoveX dw 0
    beforeMoveY dw 0
    nextMoveTileX dw 0
    nextMoveTileY dw 0
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

        ; Check if we are centered on a tile
        mov ax, [di + posX]
        sub ax, TILE_SIZE / 2
        and ax, TILE_SIZE - 1
        cmp ax, 0
        jnz .exit
        mov ax, [di + posY]
        sub ax, TILE_SIZE / 2
        and ax, TILE_SIZE - 1
        cmp ax, 0
        jnz .exit

        ; Apply any possible rotation that might have occured
        mov ax, [di + posX]
        add ax, TILE_SIZE / 2 - 1
        and ax, 0xf8 ; Round down to the tile coords
        add ax, TILE_SIZE / 2
        mov cx, ax
        sub ax, [di + posX]
        jns .dxPositive
        neg ax
        .dxPositive:
        mov bx, [di + posY]
        add bx, TILE_SIZE / 2 - 1
        and bx, 0xf8
        add bx, TILE_SIZE / 2
        mov dx, bx
        sub bx, [di + posY]
        jns .dyPositive
        neg bx
        .dyPositive:
        add ax, bx
        ; Re-add the offset
        ; TODO: Refacto this, it hurts my eyes
        mov [di + posX], cx
        mov [di + posY], dx
        cmp word [di + nextVelocityX], 0
        je .doneOffsetX
        jl .negativeOffsetX
        add [di + posX], ax
        inc word [nextMoveTileX]
        jmp .doneOffsetX
        .negativeOffsetX:
        sub [di + posX], ax
        dec word [nextMoveTileX]
        .doneOffsetX:
        cmp word [di + nextVelocityY], 0
        je .doneOffsetY
        jl .negativeOffsetY
        add [di + posY], ax
        inc word [nextMoveTileY]
        jmp .doneOffsetY
        .negativeOffsetY:
        sub [di + posY], ax
        dec word [nextMoveTileY]
        .doneOffsetY:

        ; Change velocity
        mov ax, [di + nextVelocityX]
        mov [di + velocityX], ax
        mov ax, [di + nextVelocityY]
        mov [di + velocityY], ax

        ; Initialize best distance, dx and dy
        mov word [bestDistance], 0xffff
        mov word [bestVelocityX], 0
        mov word [bestVelocityY], 0

        ; Check in all directions for the best tile, skip tile if the tile is in our back
        ; TODO: Check for overflows (if check tile is outside the maze)
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
        mov [di + nextVelocityX], ax
        mov ax, [bestVelocityY]
        mov [di + nextVelocityY], ax

        .exit:
        ret

    moveGhost:
        ; Memorize old position
        mov ax, [di + posX]
        mov [beforeMoveX], ax
        mov bx, [di + posY]
        mov [beforeMoveY], bx

        ; Move
        add ax, [di + velocityX]
        mov [di + posX], ax
        add bx, [di + velocityY]
        mov [di + posY], bx
    
        ; Calculate new tile position
        mov bx, TILE_SIZE
        add ax, SPRITE_SIZE / 2
        xor dx, dx
        div bx
        mov [nextMoveTileX], ax
        mov ax, [di + posY]
        add ax, SPRITE_SIZE / 2
        xor dx, dx
        div bx
        mov [nextMoveTileY], ax

        ; TODO: Check collision

        ret
    
    checkTile:
        ; Calculate the position of the tile to be checked
        mov ax, [nextMoveTileX]
        add ax, [checkVelocityX]
        mov [checkTileX], ax
        mov ax, [nextMoveTileY]
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

    