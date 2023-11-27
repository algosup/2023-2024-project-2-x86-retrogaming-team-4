section .bss

   background_buffer resb SCREEN_WIDTH*SCREEN_HEIGHT ; where is stored the dynamic background (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage

section .data

   base: equ 0xf9fe
   old_time: equ base+0x06

section .text

   GetClockAndCompare:
      pusha

      mov ax, 0
      int 1ah ; BIOS clock read
      cmp dx, [old_time] ; Wait for change
      je gameloop ; Loop
      mov [old_time], dx
      
      popa

   ret

   SetVideoMode:

      mov ah, 00h ; chose the video mode setting function at the 10h interruption
      mov al, 13h ; set video mode option to 320 x 200 256 colors
      int 10h ; call the dos interupt regarding to ax

      ; write the adress of video memory (A000) in the register which contains the address of the destination segment used by the automatic data transfer functions (like movs, stos, ...)
      push 0xA000 
      pop es

   ret

   FillScreen:

      ;stosb copy byte per byte the content from 'al' to 'es:di', di increasing.
      
      ;set the destination 'es:di' :
      push 0xA000 ; video memory adress = 0xA000
      pop es ; define it as the adress of the destination segment
      mov di, 0 ; begin the offset (pixel position) at 0
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; how many times 'rep' action will be repeated
      rep stosb ; store (byte per byte) the content of al into es:di, es = 0xA000, di increasing from 0 to 200*320
   ret

   ClearScreen:
   ;clear the screen by filling it with a unique color (stored in al)
      mov al, 0x85 ; color to fill the screen (white = 0x0F, black = 0x00)
      call FillScreen
   ret

   BuildBackgroundBuffer: 
      ;source of stosb 'al'
      mov al, 0x36 ; color of the background (simulate the maze) (to be change)
      
      ;destination of stosb 'es:di'
      push ds ; adress of the data segment (even if 'es' probably already contains '0x489D')
      pop es 
      lea di, [background_buffer] ; load the effective adress (L.E.A.) of the backup in the destination offset 'di'
      
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; set the counter for rep
      rep stosb ; to copy al into each byte of the target adress es:di byte per byte
      
      ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning

   ret

   DisplayMaze:

      ;HEART OF THE FUNCTION : 'movsb' writes byte per byte the content from 'ds:si' to 'es:di', increasing both si and di each time it is executed

      ;set source 'ds:si'
      push 0x489D ; adress of the data segment
      pop ds
      lea si, [background_buffer] ; load the effective adress (L.E.A.) of the dynamic background buffer

      ;set destination 'es:di'
      push 0xA000 ; adress of the video memory 
      pop es 
      mov di, 0 ; from the beginning of the screen
       
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; set the counter for rep
      rep movsb ; 'movsb' writes byte per byte the content from 'ds:si' to 'es:di', increasing both si and di each time it is executed

   ret

   FirstDisplayPacMan:

      ;mov x_PacManPosition, 30
      ;mov y_PacManPosition, 30
      ;mov frameOf_PacMan, PACMAN_FULL

      call Display_PacMan
   

   