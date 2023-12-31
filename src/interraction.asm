section .data

    pacManTilePos: dw 0
    pacManCenterX: dw 0
    pacManCenterY: dw 0
    scoreForLife: dw 0
    lifeCounter: db 3
    livesPosX: dw 0
    pelletEaten: dw 0
    score: dd 0
    scoreUnit: dd 0

    endFrightTime: dd 0, 0
    
    endFruitTime: dd 0, 0
    fruitTilePos: dw 0
    fruitSprite: dw 0
    level dw 1
    numberPelletEaten dw 0
    killStreak db 0

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

    checkLevel:
        cmp word [numberPelletEaten], NUMBER_OF_PELLETS
        jne .endFunc
            mov word [numberPelletEaten], 0
            add word [level], 1
            mov word [strcPacMan + velocityX], 0
            mov word [strcPacMan + velocityY], 0
            mov byte [keyPressed], 0
            call displayNextLevel
            call UpdateScreen
            call waitForAnyKeyPressed
            .NewLevel:
            mov byte [strcPinky + isChased], 0
            mov byte [strcBlinky + isChased], 0
            mov byte [strcClyde + isChased], 0
            mov byte [strcInky + isChased], 0
            call resetPelletEaten
            call BuildMazeModelBuffer
            mov dh, FIRST_LINE_OF_MAZE
            call MazeToBGbuffer.chooseFirstLine
            jmp start.resetPoint
        .endFunc:
        ret
    

    isPellet:
        ; increment score
        add long[score], 1
        add word [numberPelletEaten], 1
        add word[scoreForLife], 1
        inc word[pelletEaten]
        call setTileEmpty

        ret

    isPowerPellet:
        ; increment score
        add long[score], 5
        add word [numberPelletEaten], 1
        add word[scoreForLife], 5
        call frightTime
        call setTileEmpty

        ret
    
    isCherry:
        ; increment score
        add long[score], 20
        add word[scoreForLife], 20
        call setTileEmpty

        ret

    isStrawberry:
        
        ; increment score
        add long[score], 30
        add word[scoreForLife], 30
        call setTileEmpty

        ret

    isOrange:
        ; increment score
        add long[score], 50
        add word[scoreForLife], 50
        call setTileEmpty

        ret

    isApple:
        ; increment score
        add long[score], 70
        add word[scoreForLife], 70
        call setTileEmpty

        ret

    isMelon:
        ; increment score
        add long[score], 100
        add word[scoreForLife], 100
        call setTileEmpty

        ret

    isGalaxianFlagship	:
        ; increment score
        add long[score], 200
        add word[scoreForLife], 200
        call setTileEmpty

        ret

    isBell:
        ; increment score
        add long[score], 300
        add word[scoreForLife], 300
        call setTileEmpty

        ret

    isKey:
        ; increment score
        add long[score], 500
        add word[scoreForLife], 500
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        add eax, FRUIT_TIME
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
        mov byte [killStreak], 0
        mov byte[strcBlinky + isChased], 1
        mov byte[strcInky + isChased], 1
        mov byte[strcPinky + isChased], 1
        mov byte[strcClyde + isChased], 1
        mov eax, [timestamp_of_next_frame]
        add eax, PACMAN_FRIGHTENED_TIME ; 8 sec (6 sec blue + 2 sec White/blue)
        mov [endFrightTime], eax
        
        ret

    checkFrightTime:
        mov eax, [timestamp_of_next_frame]
        cmp eax, [endFrightTime]
        jne .stillFrightTime
            mov byte[strcBlinky + isChased], 0
            mov byte[strcInky + isChased], 0
            mov byte[strcPinky + isChased], 0
            mov byte[strcClyde + isChased], 0
        .stillFrightTime:
        ret
    
    IsOnTeleporter:
        ; check if on teleporter
        ; teleport to the other side
        cmp word[strcPacMan + posX], 1
        ja .noTPLeft
        mov word[strcPacMan + posX], 302
        .noTPLeft:
        cmp word[strcPacMan + posX], 303
        jb .noTP
        mov word[strcPacMan + posX], 2
        .noTP:
        ret

    setFruits:
        cmp word[level], 8
        je .level8
        cmp word[level], 9
        je .level9
        cmp word[level], 10
        je .level10
        cmp word[level], 11
        je .level11
        cmp word[level], 12
        je .level12
        cmp word[level], 13
        je .level13
        cmp word[level], 14
        jae .levelMore

        cmp word[pelletEaten], 70
        je addCherry
        
        cmp word[pelletEaten], 170
        je addStrawberry
        jmp .exit

        .level8:

        cmp word[pelletEaten], 70
        je addStrawberry

        cmp word[pelletEaten], 170
        je addOrange
        jmp .exit

        .level9:

        cmp word[pelletEaten], 70
        je addOrange

        cmp word[pelletEaten], 170
        je addApple
        jmp .exit

        .level10:

        cmp word[pelletEaten], 70
        je addApple

        cmp word[pelletEaten], 170
        je addMelon
        jmp .exit

        .level11:

        cmp word[pelletEaten], 70
        je addMelon

        cmp word[pelletEaten], 170
        je addGalaxianFlagship
        jmp .exit

        .level12:

        cmp word[pelletEaten], 70
        je addGalaxianFlagship

        cmp word[pelletEaten], 170
        je addBell
        jmp .exit

        .level13:

        cmp word[pelletEaten], 70
        je addBell

        cmp word[pelletEaten], 170
        je addKey
        jmp .exit

        .levelMore:

        cmp word[pelletEaten], 70
        je addKey

        cmp word[pelletEaten], 170
        je addKey

        .exit:
        ret

    resetPelletEaten:
        cmp word[pelletEaten], 770
        jne .noReset
        mov word[pelletEaten], 0
        .noReset:
        ret

    checkFruitPrint:
        mov eax, [timestamp_of_next_frame]
        cmp eax, [endFruitTime]
        jne .stillFruitTime

        mov si, MazeModelBuffer
        add si, FRUIT_TILE_POS
        mov byte[si], 0x0F
        call replaceFruit

        .stillFruitTime:
        ret

    lifeManagement: 
        cmp word[scoreForLife], 1000
        jb .noNewLife
            mov word[scoreForLife], 0
            cmp byte [lifeCounter], 5
            je .noNewLife
            inc byte [lifeCounter]
            mov word [frameOf_Lives], PACMAN_LEFT_2
            call whereToDisplayLife
            call displayLives
        .noNewLife:
        ret

    whereToDisplayLife:
        cmp byte [lifeCounter], 2
        jne .notTwo
            mov ax, 28*TILE_SIZE+8*TILE_SIZE
            mov [livesPosX], ax
            ret
        .notTwo:

        cmp byte [lifeCounter], 3
        jne .notThree
            mov ax, 28*TILE_SIZE+6*TILE_SIZE
            mov [livesPosX], ax
            ret
        .notThree:

        cmp byte [lifeCounter], 4
        jne .notFour
            mov ax, 28*TILE_SIZE+4*TILE_SIZE
            mov [livesPosX], ax
            ret
        .notFour:

        mov ax, 28*TILE_SIZE+2*TILE_SIZE
        mov [livesPosX], ax
        ret