org 100h

section .text
jmp start

%include "constants.asm"
%include "sprites.asm"
%include "main.asm"
%include "initialization.asm"
%include "keyboard.asm"
%include "collider.asm"
%include "move_sprites.asm"
%include "scoring.asm"