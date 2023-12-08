section .text

    readContact:

        .PinkyContact:
            mov bx, [strcPinky  + posX]
            mov ax, [strcPinky  + posY]
            call isThereContact
        
        .BlinkyContact:
            mov bx, [strcBlinky  + posX]
            mov ax, [strcBlinky  + posY]
            call isThereContact

        .InkyContact:
            mov bx, [strcInky  + posX]
            mov ax, [strcInky  + posY]
            call isThereContact
        
        .ClydeContact:
            mov bx, [strcClyde  + posX]
            mov ax, [strcClyde  + posY]
            call isThereContact

        ret

    isThereContact:
    ; read if a ghost touched pacman (or the reverse)

        push ds ; pop at the end

        ;calculates the linear position of the ghost (result in ax)
        mov cx, SCREEN_WIDTH
        mul cx
        add ax, bx 

        ;stores the color of pacman into 'ah'
        mov di, palette
        inc di, ;(add 1 to di) cause '1' is the color of pacman according to the palette of colors for the spritesheet
        xor bx, bx
        mov bl, [ds:di]

        ;the destination is 'al'
        
        ;set the source 'ds:si'
        push word [ScreenBufferSegment]
        pop ds
        mov si, ax  
        
        mov dx, SPRITE_SIZE
        .eachLine:
            mov cx, SPRITE_SIZE
            .eachPixel:
                lodsb 
                int3
                cmp al, bl
                je .touched
                dec cx
                jnz .eachPixel
            add si, SCREEN_WIDTH - SPRITE_SIZE
            dec dx
            jnz .eachLine
        pop ds
        jmp .notTouched

        .touched:
            pop ds
            cmp byte [afraid], 0
            je .normalContact
            
        .afraidContact:
            ;nothing yet (never afraid for now)
            jmp .notTouched

        .normalContact:

            jmp resetPoint

        .notTouched:
        
        ret


    
    
