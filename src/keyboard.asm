section .data

    keyPressed dw 0
    keyChanged db 0

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

        cmp byte [keyPressed], EXIT_KEY_SCANCODE
        je exit

        ; Left
        cmp byte [keyPressed], LEFT_KEY_SCANCODE
        jne .NoLeft

        ; We use the same kind of process as used for collisions, but we only check walls were we cannot go left
        ; The direction stays in buffer until Pac-Man can go left
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

        mov word[strcPacMan + velocityX], -1*SPRITE_SPEED_PIXELS
        mov word[strcPacMan + velocityY], 0
        mov word[strcPacMan + direction], LEFT_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoLeft:

        ; Right
        cmp byte [keyPressed], RIGHT_KEY_SCANCODE
        jne .NoRight

        ; We use the same kind of process as used for collisions, but we only check walls were we cannot go right
        ; The direction stays in buffer until Pac-Man can go right
        call getCorners

        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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

        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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

        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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

        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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

        mov word[strcPacMan + velocityX], 1*SPRITE_SPEED_PIXELS
        mov word[strcPacMan + velocityY], 0
        mov word[strcPacMan + direction], RIGHT_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoRight:

        ; Up
        cmp byte [keyPressed], UP_KEY_SCANCODE
        jne .NoUp

        ; We use the same kind of process as used for collisions, but we only check walls were we cannot go up
        ; The direction stays in buffer until Pac-Man can go up
        call getCorners

        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        mov word[strcPacMan + velocityY], -1*SPRITE_SPEED_PIXELS
        mov word[strcPacMan + direction], UP_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoUp:

        ; Down
        cmp byte [keyPressed], DOWN_KEY_SCANCODE
        jne .NoDown

        call getCorners

        ; We use the same kind of process as used for collisions, but we only check walls were we cannot go down
        ; The direction stays in buffer until Pac-Man can go down
        mov ax, [corner0X]
        mov bx, [corner0Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner1X]
        mov bx, [corner1Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner2X]
        mov bx, [corner2Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        
        mov ax, [corner3X]
        mov bx, [corner3Y]
        mov [checkedCornerX], ax
        mov [checkedCornerY], bx
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
        mov word[strcPacMan + velocityY], 1*SPRITE_SPEED_PIXELS
        mov word[strcPacMan + direction], DOWN_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoDown:
            cmp byte [keyChanged], 0
            jne .NoChange
            call changePacManPosition
            .NoChange:

            and byte [keyChanged], 00
        
        ret

