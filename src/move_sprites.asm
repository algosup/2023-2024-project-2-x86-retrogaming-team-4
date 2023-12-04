section .data
    strcPacMan:
        istruc PacMan
            at posX, dw 10
            at posY, dw 10
            at absPos, dw 10*10
            at velocityX, db 0
            at velocityY, db 0
            at isChased, db 1
            at isDead, db 0
        iend
    
    strcBlinky:
        istruc Blinky
            at posX, dw 274
            at posY, dw 30
            at absPos, dw 274*30
            at velocityX, db 0
            at velocityY, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcInky:
        istruc Inky
            at posX, dw 90
            at posY, dw 100
            at absPos, dw 90*100
            at velocityX, db 0
            at velocityY, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcPinky:
        istruc Pinky
            at posX, dw 30
            at posY, dw 30
            at absPos, dw 30*30
            at velocityX, db 0
            at velocityY, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    strcClyde:
        istruc Clyde
            at posX, dw 70
            at posY, dw 100
            at absPos, dw 70*100
            at velocityX, db 0
            at velocityY, db 0
            at isChased, db 0
            at isDead, db 0
        iend

    x_PacManVelocity dw 0 ; PacMan's translation vector on x axis (px/screen update) (if it=-3, pac man will go down  3 pixel, 24 times per second)
    y_PacManVelocity dw 0 ; PacMan's translation vector on y axis (px/screen update) (if it=+2, pac man will go right 2 pixel, 24 times per second)

    x_BlinkyVelocity dw 0 ; Blinky's translation vector on x axis (px/screen update) (if it=-3, Blinky will go down  3 pixel, 24 times per second)
    y_BlinkyVelocity dw 0 ; Blinky's translation vector on y axis (px/screen update) (if it=+2, Blinky will go right 2 pixel, 24 times per second)

    x_PinkyVelocity dw 0 ; Pinky's translation vector on x axis (px/screen update) (if it=-3, Pinky will go down  3 pixel, 24 times per second)
    y_PinkyVelocity dw 0 ; Pinky's translation vector on y axis (px/screen update) (if it=+2, Pinky will go right 2 pixel, 24 times per second)

    x_ClydeVelocity dw 0 ; Clyde's translation vector on x axis (px/screen update) (if it=-3, Clyde will go down  3 pixel, 24 times per second)
    y_ClydeVelocity dw 0 ; Clyde's translation vector on y axis (px/screen update) (if it=+2, Clyde will go right 2 pixel, 24 times per second)

    x_InkyVelocity dw 0 ; Inky's translation vector on x axis (px/screen update) (if it=-3, Inky will go down  3 pixel, 24 times per second)
    y_InkyVelocity dw 0 ; Inky's translation vector on y axis (px/screen update) (if it=+2, Inky will go right 2 pixel, 24 times per second)


section .text

changePacManPosition:
    mov bx, [strcPacMan + posX]
    add bx, [strcPacMan + velocityX]
    mov [strcPacMan + posX], bx

    mov ax, [strcPacMan + posY]
    add ax, [strcPacMan + velocityY]
    mov [strcPacMan + posY], ax
    ret

changeGhostPosition:

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

    cmp dx, 1
    jne .noEyesRight
    mov ax, EYES_RIGHT
    .noEyesRight:

    cmp dx, -1
    jne .noEyesLeft
    mov ax, EYES_LEFT
    .noEyesLeft:

    cmp cx, 1
    jne .noEyesDown
    mov ax, EYES_DOWN
    .noEyesDown:

    cmp cx, -1
    jne .noEyesUp
    mov ax, EYES_UP
    .noEyesUp:

    ret

changePinkyPosition:

    mov ax, [y_PinkyPosition]
    mov bx, [x_PinkyPosition]
    mov cx, [y_PinkyVelocity]
    mov dx, [x_PinkyVelocity]

    call changeGhostPosition

    mov word [y_PinkyPosition], ax
    mov word [x_PinkyPosition], bx
    mov word [y_PinkyVelocity], cx
    mov word [x_PinkyVelocity], dx

    call changeGhostFrames

    mov word [frameOf_Pinky_eyes], ax

    ret

changeInkyPosition:

    mov ax, [y_InkyPosition]
    mov bx, [x_InkyPosition]
    mov cx, [y_InkyVelocity]
    mov dx, [x_InkyVelocity]

    call changeGhostPosition

    mov word [y_InkyPosition], ax
    mov word [x_InkyPosition], bx
    mov word [y_InkyVelocity], cx
    mov word [x_InkyVelocity], dx

    call changeGhostFrames

    mov word [frameOf_Inky_eyes], ax

    ret

changeClydePosition:

    mov ax, [y_ClydePosition]
    mov bx, [x_ClydePosition]
    mov cx, [y_ClydeVelocity]
    mov dx, [x_ClydeVelocity]

    call changeGhostPosition

    mov word [y_ClydePosition], ax
    mov word [x_ClydePosition], bx
    mov word [y_ClydeVelocity], cx
    mov word [x_ClydeVelocity], dx

    call changeGhostFrames

    mov word [frameOf_Clyde_eyes], ax

    ret

changeBlinkyPosition:

    mov ax, [y_BlinkyPosition]
    mov bx, [x_BlinkyPosition]
    mov cx, [y_BlinkyVelocity]
    mov dx, [x_BlinkyVelocity]

    call changeGhostPosition

    mov word [y_BlinkyPosition], ax
    mov word [x_BlinkyPosition], bx
    mov word [y_BlinkyVelocity], cx
    mov word [x_BlinkyVelocity], dx

    call changeGhostFrames

    mov word [frameOf_Blinky_eyes], ax

    ret




    