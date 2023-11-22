
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


changePos:
;switch the direction if the ghost reached a side of the screen
    cmp word [x_PacManPosition], SCREEN_WIDTH - SPRITE_SIZE 
    jb .noflip
    neg word [x_PacManVelocity]
    .noflip:
;inc/decremente the position
    mov bx, [x_PacManPosition]
    add bx, [x_PacManVelocity]
    mov [x_PacManPosition], bx
ret

Move_PacMan:

    call ClearPacMan
    mov bx, 1
    mov [x_PacManVelocity], bx
    call changePos
    call Display_PacMan
ret