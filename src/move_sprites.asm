section .data
    strcPacMan:
        istruc Sprite
            at posX, dw 10
            at posY, dw 10
            at frame, dw PACMAN_FULL
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 1 ; not used
            at isDead, db 0
            at nextPosX, dw 10
            at nextPosY, dw 10
            at nextVelocityX, dw 0
            at nextVelocityY, dw 0
        iend
    
    strcBlinky:
        istruc Sprite
            at posX, dw 274
            at posY, dw 30
            at frame, dw BLINKY_1
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0 ; not used
            at nextPosX, dw 274
            at nextPosY, dw 30
            at nextVelocityX, dw 0
            at nextVelocityY, dw 0
        iend

    strcInky:
        istruc Sprite
            at posX, dw 90
            at posY, dw 100
            at frame, dw INKY_1
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0 ; not used
            at nextPosX, dw 90
            at nextPosY, dw 100
            at nextVelocityX, dw 0
            at nextVelocityY, dw 0
        iend

    strcPinky:
        istruc Sprite
            at posX, dw 30
            at posY, dw 30
            at frame, dw PINKY_1
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0 ; not used
            at nextPosX, dw 30
            at nextPosY, dw 30
            at nextVelocityX, dw 0
            at nextVelocityY, dw 0
        iend

    strcClyde:
        istruc Sprite
            at posX, dw 70
            at posY, dw 100
            at frame, dw CLYDE_1
            at velocityX, dw 0
            at velocityY, dw 0
            at direction, db 0
            at isChased, db 0
            at isDead, db 0 ; not used
            at nextPosX, dw 70
            at nextPosY, dw 100
            at nextVelocityX, dw 0
            at nextVelocityY, dw 0
        iend

    pacManNextPosX dw 0
    pacManNextPosY dw 0

    Speed_Pixels dw 1

section .text
    
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
        
         ; set next position
        mov bx, [strcBlinky + posX]
        add bx, [strcBlinky + velocityX]
        mov [strcBlinky + nextPosX], bx

        call changeGhostPosition

        mov word [strcBlinky + posY], ax
        mov word [strcBlinky + posX], bx
        mov word [strcBlinky + velocityY], cx
        mov word [strcBlinky + velocityX], dx


        ; call changeGhostFrames

        mov word [strcBlinky + eyes], ax

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

        mov word [strcInky + eyes], ax

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

        mov word [strcPinky + eyes], ax

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

        mov word [strcClyde + eyes], ax

        ret

    stopPacMan:
        mov word [strcPacMan + velocityX], 0
        mov word [strcPacMan + velocityY], 0
        mov byte[isCollid], 0x00
        ret

    