section .data
    strcPacMan:
        istruc Sprite
            at posX, dw 10
            at posY, dw 10
            at frame, dw PACMAN_FULL
            at absPos, dw 10*10
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 1
            at isDead, db 0
        iend
    
    strcBlinky:
        istruc Sprite
            at posX, dw 274
            at posY, dw 30
            at frame, dw BLINKY_1
            at absPos, dw 274*30
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcInky:
        istruc Sprite
            at posX, dw 90
            at posY, dw 100
            at frame, dw INKY_1
            at absPos, dw 90*100
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcPinky:
        istruc Sprite
            at posX, dw 30
            at posY, dw 30
            at frame, dw PINKY_1
            at absPos, dw 30*30
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcClyde:
        istruc Sprite
            at posX, dw 70
            at posY, dw 100
            at frame, dw CLYDE_1
            at absPos, dw 70*100
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    pacManNextPosX dw 0
    pacManNextPosY dw 0

    Speed_Pixels dw 1

    targetGhost db 0
    ; 0 = blinky
    ; 1 = inky
    ; 2 = pinky
    ; 3 = clyde
    isGhostCollid db 0

    ghostNextPosX dw 0
    ghostNextPosY dw 0

section .text
    setGhostMovLeft:
        cmp byte[targetGhost], 0
        je .setBlinkyNewVel

        cmp byte[targetGhost], 1
        je .setInkyNewVel

        cmp byte[targetGhost], 2
        je .setPinkyNewVel

        cmp byte[targetGhost], 3
        je .setClydeNewVel

        .setBlinkyNewVel:
            mov word [strcBlinky + velocityY], 0
            mov word [strcBlinky + velocityX], -1
            jmp .skip

        .setInkyNewVel:
            mov word [strcInky + velocityY], 0
            mov word [strcInky + velocityX], -1
            jmp .skip

        .setPinkyNewVel:
            mov word [strcPinky + velocityY], 0
            mov word [strcPinky + velocityX], -1
            jmp .skip

        .setClydeNewVel:
            mov word [strcClyde + velocityY], 0
            mov word [strcClyde + velocityX], -1

        .skip:
            ret

    setGhostMovRight:
        cmp byte[targetGhost], 0
        je .setBlinkyNewVel

        cmp byte[targetGhost], 1
        je .setInkyNewVel

        cmp byte[targetGhost], 2
        je .setPinkyNewVel

        cmp byte[targetGhost], 3
        je .setClydeNewVel

        .setBlinkyNewVel:
            mov word [strcBlinky + velocityY], 0
            mov word [strcBlinky + velocityX], 1
            jmp .skip

        .setInkyNewVel:
            mov word [strcInky + velocityY], 0
            mov word [strcInky + velocityX], 1
            jmp .skip

        .setPinkyNewVel:
            mov word [strcPinky + velocityY], 0
            mov word [strcPinky + velocityX], 1
            jmp .skip

        .setClydeNewVel:
            mov word [strcClyde + velocityY], 0
            mov word [strcClyde + velocityX], 1

        .skip:
            ret

    setGhostMovUp:
        cmp byte[targetGhost], 0
        je .setBlinkyNewVel

        cmp byte[targetGhost], 1
        je .setInkyNewVel

        cmp byte[targetGhost], 2
        je .setPinkyNewVel

        cmp byte[targetGhost], 3
        je .setClydeNewVel

        .setBlinkyNewVel:
            mov word [strcBlinky + velocityY], -1
            mov word [strcBlinky + velocityX], 0
            jmp .skip

        .setInkyNewVel:
            mov word [strcInky + velocityY], -1
            mov word [strcInky + velocityX], 0
            jmp .skip

        .setPinkyNewVel:
            mov word [strcPinky + velocityY], -1
            mov word [strcPinky + velocityX], 0
            jmp .skip

        .setClydeNewVel:
            mov word [strcClyde + velocityY], -1
            mov word [strcClyde + velocityX], 0

        .skip:
            ret

    setGhostMovDown:
        cmp byte[targetGhost], 0
        je .setBlinkyNewVel

        cmp byte[targetGhost], 1
        je .setInkyNewVel

        cmp byte[targetGhost], 2
        je .setPinkyNewVel

        cmp byte[targetGhost], 3
        je .setClydeNewVel

        .setBlinkyNewVel:
            mov word [strcBlinky + velocityY], 1
            mov word [strcBlinky + velocityX], 0
            jmp .skip

        .setInkyNewVel:
            mov word [strcInky + velocityY], 1
            mov word [strcInky + velocityX], 0
            jmp .skip

        .setPinkyNewVel:
            mov word [strcPinky + velocityY], 1
            mov word [strcPinky + velocityX], 0
            jmp .skip

        .setClydeNewVel:
            mov word [strcClyde + velocityY], 1
            mov word [strcClyde + velocityX], 0

        .skip:
            ret


    getNewDirection:
        ; Read the current time
        rdtsc
        mov cx, 4
        div cx

        ; Set the new velocity
        cmp dx, 0
        je .setGhostMovLeft

        cmp dx, 1
        je .setGhostMovRight

        cmp dx, 2
        je .setGhostMovUp

        cmp dx, 3
        je .setGhostMovDown

        .setGhostMovLeft:
            call setGhostMovLeft
            ret

        .setGhostMovRight:
            call setGhostMovRight
            ret

        .setGhostMovUp:
            call setGhostMovUp
            ret

        .setGhostMovDown:
            call setGhostMovDown
            ret



    getGhostNextPosition:
        ; changes the ghosts' positions values according to the current velocity an targetted ghost
        cmp byte[targetGhost], 0
        je .getBlinkyNextPosition

        cmp byte[targetGhost], 1
        je .getInkyNextPosition

        cmp byte[targetGhost], 2
        je .getPinkyNextPosition

        cmp byte[targetGhost], 3
        je .getClydeNextPosition

        .getBlinkyNextPosition:
            mov ax, [strcBlinky + posY]
            mov bx, [strcBlinky + posX]
            add ax, [strcBlinky + velocityY]
            add bx, [strcBlinky + velocityX]
            jmp .skip

        .getInkyNextPosition:
            mov ax, [strcInky + posY]
            mov bx, [strcInky + posX]
            add ax, [strcInky + velocityY]
            add bx, [strcInky + velocityX]
            jmp .skip


        .getPinkyNextPosition:
            mov ax, [strcPinky + posY]
            mov bx, [strcPinky + posX]
            add ax, [strcPinky + velocityY]
            add bx, [strcPinky + velocityX]
            jmp .skip

        .getClydeNextPosition:
            mov ax, [strcClyde + posY]
            mov bx, [strcClyde + posX]
            add ax, [strcClyde + velocityY]
            add bx, [strcClyde + velocityX]
            jmp .skip

        .skip:
            mov [ghostNextPosY], ax
            mov [ghostNextPosX], bx
            ret

    stopGhost:
        ; Stop the targeted ghost
        cmp byte[targetGhost], 0
        je .stopBlinky

        cmp byte[targetGhost], 1
        je .stopInky

        cmp byte[targetGhost], 2
        je .stopPinky

        cmp byte[targetGhost], 3
        je .stopClyde

        .stopBlinky:
            mov word [strcBlinky + velocityX], 0
            mov word [strcBlinky + velocityY], 0
            ret

        .stopInky:
            mov word [strcInky + velocityX], 0
            mov word [strcInky + velocityY], 0
            ret

        .stopPinky:
            mov word [strcPinky + velocityX], 0
            mov word [strcPinky + velocityY], 0
            ret

        .stopClyde:
            mov word [strcClyde + velocityX], 0
            mov word [strcClyde + velocityY], 0
            ret
    
    GhostsSpeedUpdate:

        cmp word[Speed_Pixels], 1
        je .to2speed
        dec word[Speed_Pixels]
        ret
        .to2speed:
        inc word[Speed_Pixels]
        ret

    changePacManPosition:
        
        ; set next position
        mov bx, [strcPacMan + posX]
        add bx, [strcPacMan + velocityX]
        mov [pacManNextPosX], bx

        mov ax, [strcPacMan + posY]
        add ax, [strcPacMan + velocityY]
        mov [pacManNextPosY], ax

        ; check collision
        call isColliding

        ; if no collision, set next position

        call IsOnTeleporter

        mov bx, [strcPacMan + posX]
        add bx, [strcPacMan + velocityX]
        mov [strcPacMan + posX], bx

        mov ax, [strcPacMan + posY]
        add ax, [strcPacMan + velocityY]
        mov [strcPacMan + posY], ax
        ; Pellet eating
        call pelletEating
        
        ret

    changeGhostPosition:
    ; changes the ghosts' positions values according to the current velocity
    ; changes the direction if encounter a wall

        ;switch the direction if the ghost reached a side of the screen
        cmp bx, SCREEN_WIDTH - SPRITE_SIZE 
        jb .noXflip
        neg dx

        .noXflip:
        cmp ax, SCREEN_HEIGHT - SPRITE_SIZE 
        jb .noYflip
        neg cx

        .noYflip:
        ;inc/decremente the position
        add ax, cx
        add bx, dx

        ret

    changeGhostFrames:
    ; only changes the eyes' sprite according to the new direction

        cmp dx, 0
        jle .noEyesRight
        mov ax, EYES_RIGHT
        .noEyesRight:

        cmp dx, 0
        jge .noEyesLeft
        mov ax, EYES_LEFT
        .noEyesLeft:

        cmp cx, 0
        jle .noEyesDown
        mov ax, EYES_DOWN
        .noEyesDown:

        cmp cx, 0
        jge .noEyesUp
        mov ax, EYES_UP
        .noEyesUp:

        ret

    changeBlinkyPosition:
    ; changes the Blinky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov byte [targetGhost], 0
        call getGhostNextPosition
        ;check if the ghost is colliding with a wall
        call isGhostColliding
        cmp byte [isGhostCollid], 1
        je .changeBlinkyDirection

        mov ax, [strcBlinky + posY]
        mov bx, [strcBlinky + posX]
        mov cx, [strcBlinky + velocityY]
        mov dx, [strcBlinky + velocityX]

        call changeGhostPosition

        mov word [strcBlinky + posY], ax
        mov word [strcBlinky + posX], bx
        mov word [strcBlinky + velocityY], cx
        mov word [strcBlinky + velocityX], dx

        call changeGhostFrames

        mov word [Blinky_eyes], ax

        ret

        .changeBlinkyDirection:
            mov byte [isGhostCollid], 0
            call getNewDirection
            ret

    changeInkyPosition:
    ; changes the Inky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov ax, [strcInky + posY]
        mov bx, [strcInky + posX]
        mov cx, [strcInky + velocityY]
        mov dx, [strcInky + velocityX]

        call changeGhostPosition

        mov word [strcInky + posY], ax
        mov word [strcInky + posX], bx
        mov word [strcInky + velocityY], cx
        mov word [strcInky + velocityX], dx

        call changeGhostFrames

        mov word [Inky_eyes], ax

        ret

    changePinkyPosition:
    ; changes the Pinky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov ax, [strcPinky + posY]
        mov bx, [strcPinky + posX]
        mov cx, [strcPinky + velocityY]
        mov dx, [strcPinky + velocityX]

        call changeGhostPosition

        mov word [strcPinky + posY], ax
        mov word [strcPinky + posX], bx
        mov word [strcPinky + velocityY], cx
        mov word [strcPinky + velocityX], dx

        call changeGhostFrames

        mov word [Pinky_eyes], ax

        ret

    changeClydePosition:
    ; changes the Clyde's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov ax, [strcClyde + posY]
        mov bx, [strcClyde + posX]
        mov cx, [strcClyde + velocityY]
        mov dx, [strcClyde + velocityX]

        call changeGhostPosition

        mov word [strcClyde + posY], ax
        mov word [strcClyde + posX], bx
        mov word [strcClyde + velocityY], cx
        mov word [strcClyde + velocityX], dx

        call changeGhostFrames

        mov word [Clyde_eyes], ax

        ret

    stopPacMan:
        mov word [strcPacMan + velocityX], 0
        mov word [strcPacMan + velocityY], 0
        mov byte[isCollid], 0x00
        ret

        