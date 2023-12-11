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

        ret

        .pellet:
            call isOnPellet
        ret

    isOnPellet:
    int3
        ; increment score
        inc word[score]

        ; get the tile at pacman's position
        mov si, MazeModelBuffer
        add si, [pacManTilePos]

        ; set the tile to empty
        ; mov byte[si], 0x0F
        xor ax, ax
        xor bx, bx
        mov ax, [pacManCenterY]
        mov bx, [pacManCenterX]
        ; (and si contains the offset of the tile into the mazemodel ('ds:si' = hexacode of the tile))
        call RemovePellet
        ret