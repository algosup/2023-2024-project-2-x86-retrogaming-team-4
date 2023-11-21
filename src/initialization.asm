section .bss

   background_buffer resb SCREEN_WIDTH*SCREEN_HEIGHT ; where is stored the dynamic background (pellet diappearing) to restore the screen after the ghost passage


section .text

   BuildBackground: 
      mov al, 0x78 ; color of the background (simulate the maze) (to be change)
      
      pop es ; put it as the destination segment of stosb
      lea di, [background_buffer] ; load the effective adress (L.E.A.) of the backup in the destination offset
      ;set the source 'ds:si' to A000:xpos  (it's needed to have si defined before the call)
      push 
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; set the counter for 8 pixel per line
      rep stosb ; to mov the source from adress ds:si into the target from adress es:di byte per byte, 8 time (8 bits)
      dec dx ; decrementatin de dx, when it reach 0, the flag is 0 too cause of the dec propreties
      
      ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning
      push es 
      pop ds

   ret

   SetVideoMode:
   ;set the video mode
      mov ah, 00h ; set video mode requirement
      mov al, 13h ; set video mode option to 320 x 200 256 colors
      int 10h ; call the dos interupt regarding to ax

      ; move the adress of video memory 'A000' in the register which contains the address of the destination segment used by the automatic data transfer functions (like movs, stos, ...)
      push 0xA000 
      pop es
   ret

   ClearScreen:
   ;clear the screen by filling it with a unique color (stored in al)
      mov al, 0x18 ; color to fill the screen (white = 0x0F, black = 0x00)
      call FillScreen
   ret

   FillScreen:
      ;stosb copy byte per byte the content of al to es:di, di increasing.
      ;so we set the adress of the segments and the offsets
      ;set the destination 'es:di' :
      push 0xA000 ; video memory adress = 0xA000
      pop es ; define it as the adress of the destination segment
      mov di, 0 ; begin the offset (pixel position) at 0
      mov cx, 200*320 ; how many times 'rep' action will be repeated
      rep stosb ; store (byte per byte) the content of al into es:di, es = 0xA000, di increasing from 0 to 200*320
   ret