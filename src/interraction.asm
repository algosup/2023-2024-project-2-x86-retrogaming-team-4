section .data

    pacManTilePos: dw 0
    pacManCenterX: dw 0
    pacManCenterY: dw 0
    score: dw 0
    scoreUnit: dw 0
    endFrightTime: dd 0, 0

section .text

    pelletEating:
        mov bx, [strcPacMan + posX]
        add bx, 5
        mov [pacManCenterX], bx
        mov ax, [strcPacMan + posY]
        add ax, 5
        mov [pacManCenterY], ax

        ; get pacman's position in tile coordinates
        mov ax, [pacManCenterY]
        shr ax, 3
        mov bx, MAZE_WIDTH
        mul bx
        mov [pacManTilePos], ax

        mov ax, [pacManCenterX]
        shr ax, 3
        add [pacManTilePos], ax

        ; get the tile at pacman's position
        mov si, MazeModelBuffer
        add si, [pacManTilePos]
        ;compare the tile to the pellet
        cmp byte[si], 0x0D
        je .pellet    

        cmp byte[si], 0x0E
        je .powerPellet      

        .erase:
        xor ax, ax
        xor bx, bx
        mov ax, [pacManCenterY]
        mov bx, [pacManCenterX]
        call replaceTile


        ret

        .pellet:
            call isPellet
            jmp .erase

        .powerPellet:
            call isPowerPellet
            jmp .erase

    isPellet:
        ; increment score
        add word[score], 10

        ; get the tile at pacman's position
        mov si, MazeModelBuffer
        add si, [pacManTilePos]

        ; set the tile to empty
        mov byte[si], 0x0F
        xor ax, ax
        xor bx, bx

        ret

    isPowerPellet:
        ; increment score
        add word[score], 50

        ; get the tile at pacman's position
        mov si, MazeModelBuffer
        add si, [pacManTilePos]

        ; set the tile to empty
        mov byte[si], 0x0F
        xor ax, ax
        xor bx, bx

        ret

    frightTime:
        mov byte[strcBlinky + isChased], 1
        mov byte[strcInky + isChased], 1
        mov byte[strcPinky + isChased], 1
        mov byte[strcClyde + isChased], 1
        mov byte[strcPacMan + isChased], 0
        mov eax, [timestamp_of_next_frame]
        add eax, 18000000
        mov [endFrightTime], eax
        mov word [frameOf_Blinky], AFRAID_1
        mov word [frameOf_Inky], AFRAID_1
        mov word [frameOf_Pinky], AFRAID_1
        mov word [frameOf_Clyde], AFRAID_1
        ret

    checkFrightTime:
        mov eax, [timestamp_of_next_frame]
        cmp eax, [endFrightTime]
        jne .stillFrightTime
            mov byte[strcBlinky + isChased], 0
            mov word [frameOf_Blinky], BLINKY_1
            mov word [frameOf_Inky], INKY_1
            mov word [frameOf_Pinky], PINKY_1
            mov word [frameOf_Clyde], CLYDE_1
            mov byte[strcInky + isChased], 0
            mov byte[strcPinky + isChased], 0
            mov byte[strcClyde + isChased], 0
            mov byte[strcPacMan + isChased], 1
        .stillFrightTime:
        ret
    
    IsOnTeleporter:
        ; check if on teleporter
        ; teleport to the other side
        cmp word[strcPacMan + posX], 0
        jne .noTPLeft
        add word[strcPacMan + posX], 303
        .noTPLeft:
        cmp word[strcPacMan + posX], 304
        jne .noTP
        sub word[strcPacMan + posX], 303
        .noTP:
        ret