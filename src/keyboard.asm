section .data

    keyPressed dw 0
    keyChanged db 0
    jumpNoLeft db 0
    jumpNoRight db 0
    jumpNoUp db 0
    jumpNoDown db 0

section .text
    checkLeft:
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

        .end:
            ret

        .NoLeft:
            mov byte[jumpNoLeft], 1
            jmp .end

    checkRight:
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

        .end:
            ret

        .NoRight:
            mov byte[jumpNoRight], 1
            jmp .end


    checkUp:
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

        .end:
            ret

        .NoUp:
            mov byte[jumpNoUp], 1
            jmp .end

    checkDown:
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

        .end:
            ret

        .NoDown:
            mov byte[jumpNoDown], 1
            jmp .end

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

        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call checkLeft
        cmp byte[jumpNoLeft], 1
        je .NoLeft
        

        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call checkLeft
        cmp byte[jumpNoLeft], 1
        je .NoLeft


        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call checkLeft
        cmp byte[jumpNoLeft], 1
        je .NoLeft


        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call checkLeft
        cmp byte[jumpNoLeft], 1
        je .NoLeft

        mov word[strcPacMan + velocityX], -1
        mov word[strcPacMan + velocityY], 0
        mov word[strcPacMan + direction], LEFT_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoLeft:
        mov byte[jumpNoLeft], 0

        ; Right
        cmp byte [keyPressed], RIGHT_KEY_SCANCODE
        jne .NoRight

        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call checkRight
        cmp byte[jumpNoRight], 1
        je .NoRight

        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call checkRight
        cmp byte[jumpNoRight], 1
        je .NoRight


        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call checkRight
        cmp byte[jumpNoRight], 1
        je .NoRight

        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call checkRight
        cmp byte[jumpNoRight], 1
        je .NoRight

        mov word[strcPacMan + velocityX], 1
        mov word[strcPacMan + velocityY], 0
        mov word[strcPacMan + direction], RIGHT_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoRight:
        mov byte[jumpNoRight], 0

        ; Up
        cmp byte [keyPressed], UP_KEY_SCANCODE
        jne .NoUp

        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call checkUp
        cmp byte[jumpNoUp], 1
        je .NoUp
        
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call checkUp
        cmp byte[jumpNoUp], 1
        je .NoUp

        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call checkUp
        cmp byte[jumpNoUp], 1
        je .NoUp
        
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call checkUp
        cmp byte[jumpNoUp], 1
        je .NoUp

        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], -1
        mov word[strcPacMan + direction], UP_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoUp:
        mov byte[jumpNoUp], 0

        ; Down
        cmp byte [keyPressed], DOWN_KEY_SCANCODE
        jne .NoDown


        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 4
        call checkDown
        cmp byte[jumpNoDown], 1
        je .NoDown
        
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 4
        call checkDown
        cmp byte[jumpNoDown], 1
        je .NoDown
        
        mov word [cornerOffsetX], 4
        mov word [cornerOffsetY], 11
        call checkDown
        cmp byte[jumpNoDown], 1
        je .NoDown
        
        mov word [cornerOffsetX], 11
        mov word [cornerOffsetY], 11
        call checkDown
        cmp byte[jumpNoDown], 1
        je .NoDown


        mov word[strcPacMan + velocityX], 0
        mov word[strcPacMan + velocityY], 1
        mov word[strcPacMan + direction], DOWN_DIRECTION
        call changePacManPosition
        inc byte[keyChanged]
        .NoDown:
            mov byte[jumpNoDown], 0
            cmp byte [keyChanged], 0
            jne .NoChange
            call changePacManPosition
            .NoChange:

            and byte [keyChanged], 00
        
        ret
