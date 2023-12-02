section .data
    keyPressed dw 0

section .text
readKeyboard:
    ; Don't do anything if no key was pressed
    mov ah, 01h
    int 16h
    jz .skipBufferRead

    ; Read last key in buffer:
    .keepReadingBuffer:
        int3
        mov ah, 00h
        int 16h
        mov bx, ax
        mov ah, 01h
        int 16h
        jnz .keepReadingBuffer

    ; Overwrite the first char in 'charDump' with received char:
    mov [keyPressed], bh

    .skipBufferRead:

        ; Exit if ESCAPE
        cmp byte [keyPressed], EXIT_KEY_SCANCODE
        je exit

        ; Left
        cmp byte [keyPressed], LEFT_KEY_SCANCODE
        jne .NoLeft
        mov word[x_PacManVelocity], -1
        mov word[y_PacManVelocity], 0
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_LEFT_2
        .NoLeft:

        ; Right
        cmp byte [keyPressed], RIGHT_KEY_SCANCODE
        jne .NoRight
        mov word[x_PacManVelocity], 1
        mov word[y_PacManVelocity], 0
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_RIGHT_2
        .NoRight:

        ; Up
        cmp byte [keyPressed], UP_KEY_SCANCODE
        jne .NoUp
        mov word[x_PacManVelocity], 0
        mov word[y_PacManVelocity], -1
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_UP_2
        .NoUp:

        ; Down
        cmp byte [keyPressed], DOWN_KEY_SCANCODE
        jne .NoDown
        mov word[x_PacManVelocity], 0
        mov word[y_PacManVelocity], 1
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_DOWN_2
        .NoDown:

    ret

