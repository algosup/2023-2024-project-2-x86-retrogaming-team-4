section .data
    xPos dw 160
    yPos dw 80
    xVelocity dw 1
    PACMANDir dw PACMAN_RIGHT_2

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

changePos:
;switch the direction if the ghost reached a side of the screen
    cmp byte [oldKeyPressed] ,113
    je MoveLeft

    cmp byte [oldKeyPressed] ,100
    je MoveRight

    cmp byte [oldKeyPressed] ,122
    je MoveUp

    cmp byte [oldKeyPressed] ,115
    je MoveDown

DrawSprite:
    mov ax, [yPos]
    mov bx, [xPos]
    call calculate_screen_position
    mov ax, [PACMANDir]
    call calculate_spritesheet_position
    call draw_sprite
    ret

MoveRight:
    mov bx, [xVelocity]
    add [xPos], bx
    mov word [PACMANDir], PACMAN_RIGHT_2
    ;call clearScreen
    call DrawSprite
    ret

MoveLeft:
    mov bx, [xVelocity]
    sub [xPos], bx
    mov word [PACMANDir], PACMAN_LEFT_2
    ;call clearScreen
    call DrawSprite
    ret

MoveUp:
    mov bx, [xVelocity]
    sub [yPos], bx
    mov word [PACMANDir], PACMAN_UP_2
    ;call clearScreen
    call DrawSprite
    ret

MoveDown:
    mov bx, [xVelocity]
    add [yPos], bx
    mov word [PACMANDir], PACMAN_DOWN_2
    ;call clearScreen
    call DrawSprite
    ret

changePinkyPosition:
;switch the direction if the ghost reached a side of the screen
    cmp word [x_PinkyPosition], SCREEN_WIDTH - SPRITE_SIZE 
    jb .noXflip
    neg word [x_PinkyVelocity]
    mov word [frameOf_Pinky_eyes], EYES_LEFT
    cmp word [x_PinkyVelocity], 1
    jne .noEyesRight
    mov word [frameOf_Pinky_eyes], EYES_RIGHT
    .noEyesRight:
    .noXflip:

    cmp word [y_PinkyPosition], SCREEN_HEIGHT - SPRITE_SIZE 
    jb .noYflip
    neg word [y_PinkyVelocity]
    mov word [frameOf_Pinky_eyes], EYES_UP
    cmp word [y_PinkyVelocity], 1
    jne .noEyesDown
    mov word [frameOf_Pinky_eyes], EYES_DOWN
    .noEyesDown:
    .noYflip:
;inc/decremente the position
    mov bx, [x_PinkyPosition]
    add bx, [x_PinkyVelocity]
    mov [x_PinkyPosition], bx

    mov ax, [y_PinkyPosition]
    add ax, [y_PinkyVelocity]
    mov [y_PinkyPosition], ax
    ret