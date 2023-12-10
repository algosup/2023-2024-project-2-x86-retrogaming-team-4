section .data
    keyPressed dw 0
    changed db 0

section .text
readKeyboard:
    ; Don't do anything if no key was pressed
    mov ah, 01h
    int 16h
    jz .skipBufferRead

    ; Read last key in buffer:
    .keepReadingBuffer:
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

        call getCorners

        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        sub si, 1
        cmp byte[si], 0x0B
        je .NoLeft
        cmp byte[si], 0x06
        je .NoLeft
        cmp byte[si], 0x08
        je .NoLeft
        cmp byte[si], 0x02
        je .NoLeft
        cmp byte[si], 0x04
        je .NoLeft

        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        sub si, 1
        cmp byte[si], 0x0B
        je .NoLeft
        cmp byte[si], 0x06
        je .NoLeft
        cmp byte[si], 0x08
        je .NoLeft
        cmp byte[si], 0x02
        je .NoLeft
        cmp byte[si], 0x04
        je .NoLeft

        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        sub si, 1
        cmp byte[si], 0x0B
        je .NoLeft
        cmp byte[si], 0x06
        je .NoLeft
        cmp byte[si], 0x08
        je .NoLeft
        cmp byte[si], 0x02
        je .NoLeft
        cmp byte[si], 0x04
        je .NoLeft

        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        sub si, 1
        cmp byte[si], 0x0B
        je .NoLeft
        cmp byte[si], 0x06
        je .NoLeft
        cmp byte[si], 0x08
        je .NoLeft
        cmp byte[si], 0x02
        je .NoLeft
        cmp byte[si], 0x04
        je .NoLeft

        mov word[strcPacMan + velocityX], -1
        mov word[strcPacMan + velocityY], 0
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_LEFT_2
        inc byte[changed]
        .NoLeft:

        ; Right
        cmp byte [keyPressed], RIGHT_KEY_SCANCODE
        jne .NoRight
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        add si, 1
        cmp byte[si], 0x0C
        je .NoRight
        cmp byte[si], 0x07
        je .NoRight
        cmp byte[si], 0x05
        je .NoRight
        cmp byte[si], 0x03
        je .NoRight
        cmp byte[si], 0x01
        je .NoRight
        mov word[strcPacMan + velocityX], 1
        mov word[strcPacMan + velocityY], 0
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_RIGHT_2
        inc byte[changed]
        .NoRight:

        ; Up
        cmp byte [keyPressed], UP_KEY_SCANCODE
        jne .NoUp
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        sub si, 40
        cmp byte[si], 0x09
        je .NoUp
        cmp byte[si], 0x07
        je .NoUp
        cmp byte[si], 0x08
        je .NoUp
        cmp byte[si], 0x03
        je .NoUp
        cmp byte[si], 0x04
        je .NoUp
        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], -1
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_UP_2
        inc byte[changed]
        .NoUp:

        ; Down
        cmp byte [keyPressed], DOWN_KEY_SCANCODE
        jne .NoDown
        call getTileAbsPos
        mov si, MazeModel
        add si, [tileAbsPos]
        add si, 40
        cmp byte[si], 0x0A
        je .NoDown
        cmp byte[si], 0x06
        je .NoDown
        cmp byte[si], 0x05
        je .NoDown
        cmp byte[si], 0x01
        je .NoDown
        cmp byte[si], 0x02
        je .NoDown
        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], 1
        call changePacManPosition
        mov word[frameOf_PacMan], PACMAN_DOWN_2
        inc byte[changed]
        .NoDown:

        cmp byte [changed], 0
        jne .NoChange
        call changePacManPosition
        .NoChange:

        and byte [changed], 00
    ret
