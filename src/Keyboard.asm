org 100h
section .data
    keyPressed dw 0

section .text
readKeyboard:
    ; Read next key in buffer:
    xor ax, ax
    int 16h

    ; Overwrite the first char in 'charDump' with received char:
    mov [keyPressed] ,al

    cmp byte [keyPressed] ,1Bh
    je MoveLeft

    cmp byte [keyPressed] ,100
    je MoveRight

    cmp byte [keyPressed] ,18h
    je MoveUp

    cmp byte [keyPressed] ,19h
    je MoveDown

    ; Compare the red char with ESCAPE (ASCII #27)
    cmp byte [keyPressed] ,27
    jne readKeyboard        ; Loop while not "escape".

exit:
    ; Wait for key and terminate the program
    mov al,01h ; Clear buffer
    mov ah,0ch ; Read key
    int 21h ; Execute
    int 20h ; Exit