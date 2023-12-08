section .data

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
    ; only changes the Pacman's positions values according to the current velocity 

        mov bx, [x_PacManPosition]
        add bx, [x_PacManVelocity]
        mov [x_PacManPosition], bx

        mov ax, [y_PacManPosition]
        add ax, [y_PacManVelocity]
        mov [y_PacManPosition], ax

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

    changePinkyPosition:
    ; changes the Pinky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction

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
    ; changes the Inky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction

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
    ; changes the Clyde's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction

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
    ; changes the Blinky's positions values according to the current velocity 
    ; changes the direction if encounter a wall
    ; changes the eyes' sprite according to the new direction

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




    