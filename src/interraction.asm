section .data

    pacManTilePos: dw 0
    pacManCenterX: dw 0
    pacManCenterY: dw 0
    score: dw 0

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