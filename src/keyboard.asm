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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
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


        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
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


        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
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

        mov dx, word[Speed_Pixels]
        neg dx

        mov word[strcPacMan + velocityX], -1
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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
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

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
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

        mov dx, word[Speed_Pixels]

        mov word[strcPacMan + velocityX], dx
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
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

        mov dx, word[Speed_Pixels]
        neg dx

        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], dx
        mov word[strcPacMan + direction], UP_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoUp:

        ; Down
        cmp byte [keyPressed], DOWN_KEY_SCANCODE
        jne .NoDown


        ; We use the same kind of process as used for collisions, but we only check walls were we cannot go down
        ; The direction stays in buffer until Pac-Man can go down

        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call getCorners
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
        
        ; Set offset for the corner to check
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call getCorners
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
        
        mov dx, word[Speed_Pixels]
        
        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], 2
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
