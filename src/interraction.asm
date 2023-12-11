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
        mov bx, SCREEN_WIDTH/8
        mul bx
        mov [pacManTilePos], ax

        mov ax, [pacManCenterX]
        shr ax, 3
        add [pacManTilePos], ax

        ; get the tile at pacman's position
        mov si, MazeModel
        add si, [pacManTilePos]
        
        ;compare the tile to the pellet
        cmp byte[si], 0x0D
        je .pellet        

        ret

        .pellet:
            call isOnPellet
        ret

    isOnPellet:
        ; increment score
        ; inc word[score]

        ; get the tile at pacman's position
        ; mov si, MazeModel
        ; add si, [pacManTilePos]

        ; set the tile to empty
        ; mov byte[si], 0x0F
        xor ax, ax
        xor bx, bx
        mov ax, [pacManCenterY]
        mov bx, [pacManCenterX]
        call replaceTile
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