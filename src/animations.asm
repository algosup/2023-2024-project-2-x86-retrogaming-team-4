section .data

    afraid dw 0 ;   0 : normal ghost animation,  1 : afraid ghost animation

    PacmanAnimationCounter dw 0
    GhostsAnimationCounter dw 0
    directionBuffer dw 0
    afraidBlinker db 0

    PacmanDeathCounter dw PACMAN_DEATH_1 - 1
    PacmanFrameBuffer dw PACMAN_RIGHT_2

section .text

    AnimateGhosts:
        ; change the state of the ghost (normal, afraid or blinking afraid white / blue) and if the animation timer is reached, it switchs to the second frame of the actual state .

        inc word [GhostsAnimationCounter] ; counter is from 0 to 6 (6 frames = 0.25 seconds)

        cmp  word [GhostsAnimationCounter], FRAMES_COUNTER_GHOSTS_ANIMATION ; check the timer
        jne .noAnimation

        mov word [GhostsAnimationCounter],0 ; reset the counter/timer
        jmp .toggle ; toogle the frames of ghosts

        .toggle:
            call AnimatePinky
            call AnimateInky
            call AnimateBlinky
            call AnimateClyde

        ret

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
            cmp bx, AFRAID_4
            je .noBlinker
            mov edx, [endFrightTime]
            sub edx, [timestamp_of_next_frame] ; edx contains the lefting time
            cmp edx, 6000000 ; if , here, ax = 112, it's that eax was at 18 000 000 = 6 sec
            jle .whiteAfraid
            
            .noBlinker:
            mov ax, bx
            cmp ax, AFRAID_1
            je .toSecondAfraidFrame
            mov word bx, AFRAID_1

        ret

            .whiteAfraid:
                mov word bx, AFRAID_4

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

        cmp  word [PacmanAnimationCounter], FRAMES_COUNTER_PACMAN_ANIMATION ; check the timer
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
            mov word[PacmanFrameBuffer], PACMAN_FULL

        ret


    UpdateFrameOfPacman:
    ; just to change the direction if necessary, to have a reactive changing of orientation when a key is pressed

        cmp dx, word [directionBuffer] ; checks if the direction had changed from the last time
        jne .changeDirection

        ret

        .changeDirection:
            mov word[strcPacMan + frame],  ax
            mov word [directionBuffer], dx
            mov word[PacmanFrameBuffer], PACMAN_FULL

        ret

    SwitchMouthOpening:
    ; just toogles the frame of pacman if opened -> closed, and the reverse
        int3
        cmp bx, PACMAN_FULL
        je .toSlightlyClosed

        inc ax
        cmp ax, bx ; checks if the actual frame is the '_2'
        je .toOpenedOrCLosed
        

        .toSlightlyClosed:
        
            mov word[strcPacMan + frame], ax
            mov word[PacmanFrameBuffer], bx
        ret

        .toOpenedOrCLosed:
            dec ax
            cmp word[PacmanFrameBuffer], ax
            je .fullFrame
            mov word[strcPacMan + frame], ax
            mov word[PacmanFrameBuffer], bx
        ret

        .fullFrame:
            mov word[strcPacMan + frame], PACMAN_FULL
            mov word[PacmanFrameBuffer], bx
        ret

    PacmanDeathAnimation:
        
        cmp word[PacmanDeathCounter], PACMAN_DEATH_10
        jge .end
        inc word[PacmanDeathCounter]
        mov cx, word[PacmanDeathCounter]
        mov word[strcPacMan + frame] , cx
        mov word[timerDeathPacMan], 0
        ret
        .end:
        mov word[timerDeathPacMan], 0
        mov word[strcPacMan + isDead], 0
        
        ret