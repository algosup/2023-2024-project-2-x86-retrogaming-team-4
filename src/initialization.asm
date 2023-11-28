section .bss

   BackgroundBufferSegment resw 1 ; where is stored the dynamic background (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage
   ScreenBufferSegment resw 1

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

   BuildScreenBuffer:
      call heapInit
      mov ax, (SCREEN_HEIGHT*SCREEN_WIDTH/16) ; in ax, the number of paragraph to allocate (1 para = 16bits)
      call heapAllocParagraph
      mov [ScreenBufferSegment],bx
   
   ret

   UpdateScreen:
      push ds
      push es

      mov ax,cs:[ScreenBufferSegment]
      mov ds,ax ; backBuffer segment adress
      mov ax,0xa000 ; video memory segment adress
      mov es,ax 
      xor si,si ; beginning of the backbuffer (0)
      xor di,di ; beginning of the video memory (0)
      mov cx, SCREEN_HEIGHT*SCREEN_WIDTH
      rep movsb

      pop es
      pop ds
   ret

   

   SetVideoMode:

      mov ah, 00h ; chose the video mode setting function at the 10h interruption
      mov al, 13h ; set video mode option to 320 x 200 256 colors
      int 10h ; call the dos interupt regarding to ax

      ; write the adress of video memory (A000) in the register which contains the address of the destination segment used by the automatic data transfer functions (like movs, stos, ...)
      push word [ScreenBufferSegment] 
      pop es

   ret

   ClearScreen:
      ;clear the screen by filling it with a unique color (stored in al)
      mov al, 0x83 ; color to fill the screen (white = 0x0F, black = 0x00)
      call FillScreen
   ret

   FillScreen:

      ;stosb copy byte per byte the content from 'al' to 'es:di', di increasing.
      
      ;set the destination 'es:di' :
      push word [ScreenBufferSegment] ; video memory adress = 0xA000
      pop es ; define it as the adress of the destination segment
      mov di, 0 ; begin the offset (pixel position) at 0
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; how many times 'rep' action will be repeated
      rep stosb ; store (byte per byte) the content of al into es:di, es = 0xA000, di increasing from 0 to 200*320
   ret

   

   BuildBackgroundBuffer: 
      mov ax, (SCREEN_HEIGHT*SCREEN_WIDTH/16) ; in ax, the number of paragraph to allocate (1 para = 16bits)
      call heapAllocParagraph
      mov [BackgroundBufferSegment],bx
   
   ret

   MazeToBGbuffer:
      ;source of stosb 'al'
      mov al, 0x36 ; color of the background (simulate the maze) (to be change)
      
      ;destination of stosb 'es:di'
      push word [BackgroundBufferSegment] 
      pop es
      xor di,di

      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; set the counter for rep
      rep stosb ; to copy al into each byte of the target adress es:di byte per byte
      
      ; as es was containing ds, and ds was changed , we need to revert es and ds as in the begginning
   ret

   DisplayMaze:
      push es
      push ds
      ;HEART OF THE FUNCTION : 'movsb' writes byte per byte the content from 'ds:si' to 'es:di', increasing both si and di each time it is executed

      ;set destination 'es:di'
      push word [ScreenBufferSegment]
      pop es 
      xor di, di

      ;set source 'ds:si'
      push word [BackgroundBufferSegment]
      pop ds
      xor si, si

      
       
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT ; set the counter for rep
      rep movsb ; 'movsb' writes byte per byte the content from 'ds:si' to 'es:di', increasing both si and di each time it is executed

      pop ds
      pop es
   ret

   FirstDisplayPacMan:

      mov word [x_PacManPosition], 30
      mov word [y_PacManPosition], 30
      mov word [frameOf_PacMan], PACMAN_RIGHT_2

      call Display_PacMan
   ret

   FirstDisplayGhosts:
   ;PINKY ONLY

      mov word [x_PinkyPosition], 30
      mov word [y_PinkyPosition], 30
      mov word [frameOf_Pinky], PINKY_1
      mov word [frameOf_Pinky_eyes], EYES_UP
      call Display_Pinky
      mov word [x_PinkyVelocity], 1
      mov word [y_PinkyVelocity], -1

   ret

   