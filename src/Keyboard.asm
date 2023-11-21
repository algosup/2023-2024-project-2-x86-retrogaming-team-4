org 100h
section .data
    keyPressed dw 0
    oldKeyPressed dw 100

section .text
readKeyboard:
    ; Read next key in buffer:
    xor ax, ax
    mov ah, 01h
    int 16h
    cmp al, 0
    je NoKey
    
    int 16h
    ; Overwrite the first char in 'charDump' with received char:
    mov [keyPressed] ,al

    cmp byte [keyPressed] ,113
    je ChangeKeyL

    cmp byte [keyPressed] ,100
    je ChangeKeyR

    cmp byte [keyPressed] ,122
    je ChangeKeyU

    cmp byte [keyPressed] ,115
    je ChangeKeyD

    ; Compare the red char with ESCAPE (ASCII #27)
    cmp byte [keyPressed] ,27
    je exit        ; Loop while not "escape".

    xor ax, ax
NoKey:
    ret

ChangeKeyL:
    pusha
    mov bx, [keyPressed]
    mov [oldKeyPressed], bx
    popa
    jmp MoveLeft

ChangeKeyR:
    pusha
    mov bx, [keyPressed]
    mov [oldKeyPressed], bx
    popa
    jmp MoveRight

ChangeKeyU:
    pusha
    mov bx, [keyPressed]
    mov [oldKeyPressed], bx
    popa
    jmp MoveUp

ChangeKeyD:
    pusha
    mov bx, [keyPressed]
    mov [oldKeyPressed], bx
    popa
    jmp MoveDown

exit:
    ; Wait for key and terminate the program
    mov al,01h ; Clear buffer
    mov ah,0ch ; Read key
    int 21h ; Execute
    int 20h ; Exit