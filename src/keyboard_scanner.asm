[map symbols exo.map]
org 100h

section .bss

keyboard_map resb 256
old_interrupt_segment resb 1
old_interrupt_offset resb 1

section .text

    mainloop:
        call keyboard_initialization
        call keyboard_run
        call keyboard_done

    jmp mainloop

    keyboard_initialization: 
        mov ah, 35h ; select the function of 21h that get the interrupt value of a vector
        mov al, 09h ; the int XX function we want the result stored in es:bx (here vector number 9)
        int 21h ; call the interruption
        ;save the result in memory
        mov ax, es
        mov [old_interrupt_segment], ax 
        mov [old_interrupt_offset], bx

    ret

    keyboard_run:
        mov ax, 2509h
        
    ret

    keyboard_done:
        mov ax, 2509h

        push ds
        mov ax, [old_interrupt_segment]
        mov ds, ax
        mov dx, [old_interrupt_offset]
        int 21h

        pop ds
    ret 

    keyboard_handler:
        pusha
        in al, 60h
        mov bl, al
        and al, 0b01111111 ; save the number of the scan code
        and bl, 0b10000000 ; save the state of the key (pressed or released)
        mov [cs:keyboard_map], bl
        mov al, 0x20
        out 0x20, al
        popa
    iret ; interrupt return


    exit:
    int 20h ;quit