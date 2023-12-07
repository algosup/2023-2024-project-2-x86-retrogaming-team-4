[map symbols pac.map]
org 100h

jmp start

%include "heapLibrary.inc"
%include "constants.asm"
%include "maze.asm"
%include "sprites.asm"
%include "collider.asm"
%include "main.asm"
%include "initialization.asm"
%include "keyboard.asm"
%include "move_sprites.asm"