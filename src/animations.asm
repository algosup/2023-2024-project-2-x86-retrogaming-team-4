section .data

    afraid dw 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

    PacmanAnimationCounter dw 0
    PinkyAnimationCounter dw 0
    BlinkyAnimationCounter dw 0
    InkyAnimationCounter dw 0
    ClydeAnimationCounter dw 0
    GhostsAnimationCounter dw 0
    directionBuffer dw 0

section .text

    AnimateGhosts:
        ; change the state of the ghost (normal, afraid or blinking afraid white / blue) and if the animation timer is reached, it switchs to the second frame of the actual state .

        inc word [GhostsAnimationCounter] ; counter is from 0 to 6 (6 frames = 0.25 seconds)
        cmp  word [GhostsAnimationCounter], 0x6 ; check the timer
        jne .noAnimation
        mov word [GhostsAnimationCounter],0 ; reset the counter/timer
        jmp .toggle ; toogle the frames of ghosts

        ret

        .toggle:
            call AnimatePinky
            call AnimateInky
            call AnimateBlinky
            call AnimateClyde

        .noAnimation:
    
        ret

    SwitchGhostFrame:
    ; So afraid or not, it toogle the frame of the ghost, need to define : 
    ; bx = actual frame of the ghost
    ; cx = first frame of the ghost
    ; dx = is afraid or not (0 or 1)

        cmp dx, 1
        je .afraid

        mov ax, bx
        cmp ax, cx
        je .toSecondFrame
        mov word bx, cx

        ret

        .toSecondFrame:
        inc cx
        mov word bx, cx

        ret

        .afraid:
            mov ax, bx
            cmp ax, AFRAID_1
            je .toSecondAfraidFrame
            mov word bx, AFRAID_1

        ret

        .toSecondAfraidFrame:
            mov word bx, AFRAID_2

        ret

    AnimateBlinky:
        mov dx, word[strcBlinky + isChased]
        mov bx, [strcBlinky + frame]
        mov cx, BLINKY_1
        call SwitchGhostFrame
        mov word[strcBlinky + frame], bx

        ret

    AnimateClyde:
        mov dx, word[strcClyde + isChased]
        mov bx, [strcClyde + frame]
        mov cx, CLYDE_1
        call SwitchGhostFrame
        mov word[strcClyde + frame], bx

        ret

    AnimateInky:
        mov dx, word[strcInky + isChased]
        mov bx, [strcInky + frame]
        mov cx, INKY_1
        call SwitchGhostFrame
        mov word[strcInky + frame], bx

        ret

    AnimatePinky:
        mov dx, word[strcPinky + isChased]
        mov bx, [strcPinky + frame]
        mov cx, PINKY_1
        call SwitchGhostFrame
        mov word[strcPinky + frame], bx

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
    ; just toogles the frame of pacman if opened -> closed, and the reverse

        cmp ax, bx ; checks if the actual frame is the '_1'
        je .toSecondFrame

        mov word[strcPacMan + frame],  ax ; as the frame loaded in ax was the first one

        ret

        .toSecondFrame:
            inc ax ; as the frame loaded in ax was the first one
            mov word[strcPacMan + frame],  ax

        ret