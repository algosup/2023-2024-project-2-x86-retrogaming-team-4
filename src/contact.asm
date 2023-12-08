section .text

    readContact:

        .PinkyContact:
            mov cx, [strcPinky  + posX]
            mov dx, [strcPinky  + posY]
            call isThereContact
        
        .BlinkyContact:
            mov cx, [strcBlinky  + posX]
            mov dx, [strcBlinky  + posY]
            call isThereContact

        .InkyContact:
            mov cx, [strcInky  + posX]
            mov dx, [strcInky  + posY]
            call isThereContact
        
        .ClydeContact:
            mov cx, [strcClyde  + posX]
            mov dx, [strcClyde  + posY]
            call isThereContact

        ret

    isThereContact:

    ; read if a ghost touched pacman (or the reverse)
        mov ax, [strcPacMan + posX]
        mov bx, [strcPacMan + posY]

        int3
        cmp ax, cx
        je .onSameXaxis
        cmp bx, dx
        je .onSameYaxis
        
        jmp  .notTouched

        .onSameXaxis:
            mov ax, bx
            mov cx, dx

        .onSameYaxis:
            int3
            ; get the difference between pacman and ghost position
            sub ax, cx

            ; get the absolute value of this difference
            mov cx, ax
            sar cx, 15
            xor ax, cx
            shr cx, 15
            add ax, cx
            
            ; check if they are touching each other
            cmp ax, SPRITE_SIZE
            jg .notTouched

        .touched:
            cmp byte [afraid], 0
            je .normalContact
            
        .afraidContact:
            ;nothing yet (never afraid for now)
            jmp .notTouched

        .normalContact:

            call outOfGameLoop

        .notTouched:

        ret


    
    
