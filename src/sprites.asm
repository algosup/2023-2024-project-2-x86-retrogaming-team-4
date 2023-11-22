calculate_screen_position:
    ; Set first position on screen
    ; Parameters: y coord in ax, x coord in bx
    ; Result in dx
    ; Override: ax, bx, dx
    push bx
    mov bx, SCREEN_WIDTH
    mul bx
    pop bx
    add ax, bx
    mov dx, ax
    ret

calculate_spritesheet_position:
    ; Set first position on spritesheet
    ; Parameter: sprite ID in ax
    ; Result in bx
    ; Override: ax, bx
    push dx
    mov dx, SPRITE_SIZE * SPRITE_SIZE
    mul dx
    shr ax, 1 ; Because there are two pixels in a byte
    mov bx, ax
    pop dx
    ret

draw_sprite:
    ; TODO: Dynamic sprite size (DSP)
    ; bx: Base position on spritesheet
    ; cx: Index on sprite
    ; dx: Pos on screen

    ; Decrement as increment is at the beginning of the loop
    dec dx
    ; Number of pixels draw
    mov cx, 0x00ff ; TODO: DSP

.draw_loop:
    inc dx
    inc cl ; TODO: DSP

    ; Read the color index
    push cx
    shr cx, 1 ; Because there are two pixels in a byte
    mov di, spritesheet
    add di, bx
    add di, cx
    mov al, [ds:di]

    ; Check if the color is in the high or low nibble
    pop cx
    test cl, 1 ; TODO: DSP
    jnz .low_byte
    shr ax, 4
.low_byte:
    and ax, 0xf ; TODO: DSP
    je .transparent_skip

    ; Get color from palette
    mov di, palette
    add di, ax
    mov al, [ds:di]

    ; Set the pixel
    mov di, dx
    mov [es:di], al

    ; If we need to go to the next line
.transparent_skip:
    not cl
    test cl, 0xf ; TODO: DSP
    not cl
    jne .draw_loop
    add dx, SCREEN_WIDTH - SPRITE_SIZE
    cmp cl, 0xff
    jne .draw_loop
    ret