section .text
SetVideoMode:
;set the video mode
   mov ah, 00h ; set video mode requirement
   mov al, 13h ; set video mode option to 320 x 200 256 colors
   int 10h ; call the dos interupt regarding to ax
   push 0a000h
   pop es
   ret
SetScreen:
;clear the screen
    mov al, 0x18 ; color to fill the screen (white = 0x0F, black = 0x00)
    call clearScreen
    ret