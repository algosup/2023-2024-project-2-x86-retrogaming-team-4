section .data

    afraid dw 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

    PacmanAnimationCounter dw 0
    GhostsAnimationCounter dw 0
    directionBuffer dw 0

section .text

    AnimateBlinky:
        cmp word[strcBlinky + isChased], 1
        je .afraid
        mov word[strcBlinky + frame], BLINKY_1
        ret
        .afraid:
            mov word[strcBlinky + frame], AFRAID_1
        ret
    AnimateClyde:
        cmp word[strcClyde + isChased], 1
        je .afraid
        mov word[strcClyde + frame], CLYDE_1
        ret
        .afraid:
            mov word[strcClyde + frame], AFRAID_1
        ret
    AnimateInky:
        cmp word[strcInky + isChased], 1
        je .afraid
        mov word[strcInky + frame], INKY_1
        ret
        .afraid:
            mov word[strcInky + frame], AFRAID_1
        ret
    AnimatePinky:
        cmp word[strcPinky + isChased], 1
        je .afraid
        mov word[strcPinky + frame], PINKY_1
        ret
        .afraid:
            mov word[strcPinky + frame], AFRAID_1
        ret

    AnimatePacMan:
    ; changes at least the orientation of the frame, and, if the timer is reached, it switchs to the second frame of the actual orientation.
        
        inc word [PacmanAnimationCounter] ; counter is from 0 to 6 (6 frames = 0.25 seconds)

        mov bx, word[strcPacMan + frame] ; ax contain the id of the actual frame
        mov cl, 2
        mov ax, [strcPacMan + direction]
        mov dx, ax
        mul cl
        add ax, 16 ; ax contains the id of the frame "..._1" (the first) of the direction of pacman

        mov cx , word[strcPacMan + velocityX] ; stops animation if pacman is stopped
        add cx , word[strcPacMan + velocityY]
        
        cmp cx, 0
        je .pauseAnimation

        cmp  word [PacmanAnimationCounter], 0x6 ; check the timer
        jne .noAnimation
        
        mov word [PacmanAnimationCounter],0 ; reset the counter/timer
        call SwitchMouthOpening ; toogle the frame

        ret

        .noAnimation:
            call UpdateFrameOfPacman 

        ret
        
        .pauseAnimation:
            mov word [PacmanAnimationCounter],0
            inc ax ; to have the closed mouth frame in ax
            mov word[strcPacMan + frame],  ax

        ret


    UpdateFrameOfPacman:
    ; just to change the direction if necessary, to have a reactive changing of orientation when a key is pressed

        cmp dx, word [directionBuffer] ; checks if the direction had changed from the last time
        jne .changeDirection

        ret

        .changeDirection:
            mov word[strcPacMan + frame],  ax
            mov word [directionBuffer], dx

        ret

    SwitchMouthOpening:
    ; just toogle the frame of pacman if opened -> closed, and the reverse

        cmp ax, bx ; checks if the actual frame is the '_1'
        je .toSecondFrame

        mov word[strcPacMan + frame],  ax ; as the frame loaded in ax was the first one

        ret

        .toSecondFrame:
            inc ax ; as the frame loaded in ax was the first one
            mov word[strcPacMan + frame],  ax

        ret