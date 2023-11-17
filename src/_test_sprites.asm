start:
    ; Set video mode to 320x200 256 colors graphic mode
    mov ax, 0013h
    int 10h
    push 0a000h
    pop es

    ; TEMP: Draw all the sprites
    call draw_spritesheet

    ; TEMP: Randomly add a ghost with eyes
    mov ax, 80
    mov bx, 160
    call calculate_screen_position
    push dx
    mov ax, BLINKY_1
    call calculate_spritesheet_position
    call draw_sprite
    pop dx
    mov ax, EYES_RIGHT
    call calculate_spritesheet_position
    call draw_sprite

    ; Exit
    jmp exit



exit:
    ; Wait for key and terminate the program
    mov al,01h ; Clear buffer
    mov ah,0ch ; Read key
    int 21h ; Execute
    int 20h ; Exit