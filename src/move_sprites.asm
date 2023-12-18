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

section .text
    
    SpritesSpeedUpdate:

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
        cmp cx, SCREEN_WIDTH - SPRITE_SIZE
        jl .noXflip
        cmp cx, SPRITE_SIZE
        jg .noXflip
        neg ax

        .noXflip:
        cmp bx, SCREEN_HEIGHT - SPRITE_SIZE
        jl .noYflip
        cmp bx, SPRITE_SIZE
        jg .noYflip
        neg dx
        
        
        .noYflip:
        push cx
        cmp ax, 0
        je .zeroX
        mov cx, ax
        xor ax, ax
        mov al, byte [Speed_Pixels]
        test cx, cx
        jns .zeroX
        neg ax
        .zeroX:
        cmp dx, 0
        je .zeroY
        mov cx, dx
        xor dx, dx
        mov dl, byte [Speed_Pixels]
        test cx, cx
        jns .zeroY
        neg dx
        .zeroY:
        pop cx
        add bx, dx
        add cx, ax
        ret

    ChangeEyesFrame:
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
        mov bx, [strcBlinky + posY]
        mov cx, [strcBlinky + posX]
        mov dx, [strcBlinky + velocityY]
        mov ax, [strcBlinky + velocityX]

        call changeGhostPosition

        mov word [strcBlinky + posY], bx
        mov word [strcBlinky + posX], cx
        mov word [strcBlinky + velocityY], dx
        mov word [strcBlinky + velocityX], ax

        call ChangeEyesFrame

        mov word [Blinky_eyes], ax

        ret

    changeInkyPosition:
    ; changes the Inky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov bx, [strcInky + posY]
        mov cx, [strcInky + posX]
        mov dx, [strcInky + velocityY]
        mov ax, [strcInky + velocityX]

        call changeGhostPosition

        mov word [strcInky + posY], bx
        mov word [strcInky + posX], cx
        mov word [strcInky + velocityY], dx
        mov word [strcInky + velocityX], ax

        call ChangeEyesFrame

        mov word [Inky_eyes], ax

        ret

    changePinkyPosition:
    ; changes the Pinky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov bx, [strcPinky + posY]
        mov cx, [strcPinky + posX]
        mov dx, [strcPinky + velocityY]
        mov ax, [strcPinky + velocityX]

        call changeGhostPosition

        mov word [strcPinky + posY], bx
        mov word [strcPinky + posX], cx
        mov word [strcPinky + velocityY], dx
        mov word [strcPinky + velocityX], ax

        call ChangeEyesFrame

        mov word [Pinky_eyes], ax

        ret

    changeClydePosition:
    ; changes the Clyde's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction
        mov bx, [strcClyde + posY]
        mov cx, [strcClyde + posX]
        mov dx, [strcClyde + velocityY]
        mov ax, [strcClyde + velocityX]

        call changeGhostPosition

        mov word [strcClyde + posY], bx
        mov word [strcClyde + posX], cx
        mov word [strcClyde + velocityY], dx
        mov word [strcClyde + velocityX], ax

        call ChangeEyesFrame

        mov word [Clyde_eyes], ax

        ret

    stopPacMan:
        mov word [strcPacMan + velocityX], 0
        mov word [strcPacMan + velocityY], 0
        mov byte[isCollid], 0x00
        ret

        