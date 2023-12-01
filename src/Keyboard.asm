org 100h
section .data
    keyPressed dw 0
    oldKeyPressed dw 100

section .text
readKeyboard:
    ; Don't do anything if no key was pressed
    mov ah, 01h
    int 16h
    jz .skipBufferRead

    ; Read last key in buffer:
    .keepReadingBuffer:
    int3
    mov ah, 00h
    int 16h
    mov bx, ax
    mov ah, 01h
    int 16h
    jnz .keepReadingBuffer

    ; Overwrite the first char in 'charDump' with received char:
    mov ax, [keyPressed]
    mov [oldKeyPressed], ax
    mov [keyPressed], bh

    .skipBufferRead:

    ; Exit if ESCAPE
    cmp byte [keyPressed], EXIT_KEY_SCANCODE
    je exit

    ; Left
    cmp byte [keyPressed], LEFT_KEY_SCANCODE
    je MoveLeft

    ; Right
    cmp byte [keyPressed], RIGHT_KEY_SCANCODE
    je MoveRight

    ; Up
    cmp byte [keyPressed], UP_KEY_SCANCODE
    je MoveUp

    ; Down
    cmp byte [keyPressed], DOWN_KEY_SCANCODE
    je MoveDown

    ret
