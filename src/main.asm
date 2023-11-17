
;%ifndef "entry.asm"
;%endif "entry.asm"

start:
    ; Set video mode to 320x200 256 colors graphic mode
    mov ax, 0013h
    int 10h
    push 0a000h
    pop es


    ;;;;;;;;;;;;;;;;;;;;;;
    ;;                  ;;
    ;;  MAIN CODE HERE  ;;
    ;;                  ;;
    ;;;;;;;;;;;;;;;;;;;;;;


    ; Exit
    jmp exit



exit:
    ; Wait for key and terminate the program
    mov al,01h ; Clear buffer
    mov ah,0ch ; Read key
    int 21h ; Execute
    int 20h ; Exit