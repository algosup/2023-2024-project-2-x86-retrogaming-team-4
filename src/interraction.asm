section .data

    pacManTilePos: dw 0
    pacManCenterX: dw 0
    pacManCenterY: dw 0

    pelletEaten: dw 0
    score: dw 0
    scoreUnit: dd 0

    endFrightTime: dd 0, 0
    
    endFruitTime: dd 0, 0
    fruitTilePos: dw 0
    fruitSprite: dw 0

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

        cmp byte[si], 0x17
        je .cherry

        cmp byte[si], 0x10
        je .strawberry

        cmp byte[si], 0x11
        je .orange

        cmp byte[si], 0x12
        je .apple

        cmp byte[si], 0x13
        je .melon

        cmp byte[si], 0x14
        je .galaxianFlagship

        cmp byte[si], 0x15
        je .bell

        cmp byte[si], 0x16
        je .key
        
        .erase:
            xor ax, ax
            xor bx, bx
            mov ax, [pacManCenterY]
            mov bx, [pacManCenterX]
            call replaceTile
            ret
        
        .eraseFruit:
            call replaceFruit
            ret

        .pellet:
            call isPellet
            jmp .erase

        .powerPellet:
            call isPowerPellet
            jmp .erase

        .cherry:
            call isCherry
            jmp .eraseFruit

        .strawberry:
            call isStrawberry
            jmp .eraseFruit

        .orange:
            call isOrange
            jmp .eraseFruit

        .apple:
            call isApple
            jmp .eraseFruit

        .melon:
            call isMelon
            jmp .eraseFruit

        .galaxianFlagship:
            call isGalaxianFlagship
            jmp .eraseFruit

        .bell:
            call isBell
            jmp .eraseFruit

        .key:
            call isKey
            jmp .eraseFruit

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
    
    isCherry:
        ; increment score
        add word[score], 200
        call setTileEmpty

        ret

    isStrawberry:
        
        ; increment score
        add word[score], 300
        call setTileEmpty

        ret

    isOrange:
        ; increment score
        add word[score], 500
        call setTileEmpty

        ret

    isApple:
        ; increment score
        add word[score], 700
        call setTileEmpty

        ret

    isMelon:
        ; increment score
        add word[score], 1000
        call setTileEmpty

        ret

    isGalaxianFlagship	:
        ; increment score
        add word[score], 2000
        call setTileEmpty

        ret

    isBell:
        ; increment score
        add word[score], 3000
        call setTileEmpty

        ret

    isKey:
        ; increment score
        add word[score], 5000
        call setTileEmpty

        ret

    addCherry:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x17
        mov word[fruitSprite], CHERRY
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax

        .exit:
        ret

    addStrawberry:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x10
        mov word[fruitSprite], STRAWBERRY
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax

        .exit:
        ret

    addOrange:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x11
        mov word[fruitSprite], ORANGE
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret

    addApple:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x12
        mov word[fruitSprite], APPLE
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret

    addMelon:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x13
        mov word[fruitSprite], MELON
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret

    addGalaxianFlagship:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x14
        mov word[fruitSprite], GALAXIAN
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret

    addBell:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x15
        mov word[fruitSprite], BELL
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret
    
    addKey:
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS

        cmp byte[si], 0x0F
        jne .exit

        mov byte[si], 0x16
        mov word[fruitSprite], KEY
        call displayFruit

        mov eax, [timestamp_of_next_frame]
        add eax, 30000000
        mov [endFruitTime], eax
        
        .exit:
        ret

    setTileEmpty:
        ; get the tile at pacman's position
        mov si, MazeModelBuffer
        add si, [pacManTilePos]

        ; set the tile to empty
        mov byte[si], 0x0F
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

    setFruits:
        cmp word[pelletEaten], 70
        je addCherry
        
        cmp word[pelletEaten], 170
        je addStrawberry

        cmp word[pelletEaten], 270
        je addOrange

        cmp word[pelletEaten], 370
        je addApple

        cmp word[pelletEaten], 470
        je addMelon

        cmp word[pelletEaten], 570
        je addGalaxianFlagship

        cmp word[pelletEaten], 670
        je addBell

        cmp word[pelletEaten], 770
        je addKey

        ret

    checkFruitPrint:
        mov eax, [timestamp_of_next_frame]
        cmp eax, [endFruitTime]
        jne .stillFruitTime

        int3
        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS
        mov byte[si], 0x0F
        call replaceFruit

        .stillFruitTime:
        ret