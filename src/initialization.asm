section .bss
   BackgroundBufferSegment resw 1 ; where is stored the dynamic background (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage
   ScreenBufferSegment resw 1

   
section .text

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
      mov al, 0x29 ; color to fill the screen (white = 0x0F, black = 0x00)
            
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

   ; read the Maze model from the maze.asm, and build each bloc according to the hexacode, drawing the background into the background buffer

   MazeToBGbuffer: 
      xor dx, dx ; dh and dl are counters : dh will always contains the number of complete lines, dl contains the number of complete Tiles in this line
      push word [BackgroundBufferSegment]
      pop es
      ;ds is ok
      .eachTilesLine:
         mov dl, 0 ; Tiles in a line
         .eachTileOfTheLine:
            push dx
            mov ax, 8*SCREEN_WIDTH ; number of pixels in a Tile's line = 320*8 = (8*8 pixels)*(40 Tiles in a line) 
            mov bl, dh
            and bx, 0x00FF 
            mul bx
            mov di, ax ; di contains the number of pixels in complete lines
            pop dx

            mov ax, 40 ; number of Tiles in a Tile's line
            mov bl, dh
            mul bl
            mov cx, ax ; cx contains the number of Tiles in complete lines

            push dx
            and dx, 0x00FF
            add cx, dx ; cx now contains the number of complete Tiles
            pop dx

            mov ax, 8
            mov bl, dl
            mul bl
            add di, ax ; di now contains the position to write the next Tile

            mov si, MazeModel
            add si, cx
            xor ax, ax
            mov al, [ds:si] ; now al contains the hexa codes (for sprite) of the byte where is the 'cx'th Tile of mazemodel 
            
            
            push dx
            ; pick the sprite to display following the hexacode
            ; Get the offset of the sprite, following the hexa code
            mov si, MazeSpriteSheet
            mov bx, 8*8
            mul bx
            add si, ax ; si contains the offset of the sprite to display
            pop dx
            
            ;we draw the Tile
            push cx
            push dx
            mov dx,8
            .eachPixelsLine:
               mov cx, 8
               rep movsb
               add di, SCREEN_WIDTH - 8
               dec dx
               jnz .eachPixelsLine
            pop dx
            pop cx

            inc dl
            cmp dl, 40
            jb .eachTileOfTheLine
         inc dh
         cmp dh, 25
         jb .eachTilesLine
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

      mov word [strcPacMan + posX], 160
      mov word [strcPacMan + posY], 132
      mov word [frameOf_PacMan], PACMAN_RIGHT_2

      call Display_PacMan
      ret

   FirstDisplayGhosts:

      mov word [strcBlinky + posX], 160
      mov word [strcBlinky + posY], 84
      mov word [frameOf_Blinky], BLINKY_1
      mov word [frameOf_Blinky_eyes], EYES_RIGHT
      call Display_Blinky
      mov word [strcBlinky + velocityX], 1
      mov word [strcBlinky + velocityY], 0

      mov word [strcInky + posX], 144
      mov word [strcInky + posY], 108
      mov word [frameOf_Inky], INKY_1
      mov word [frameOf_Inky_eyes], EYES_DOWN
      call Display_Inky
      mov word [strcInky + velocityX], 0
      mov word [strcInky + velocityY], 1

      mov word [strcPinky + posX], 160
      mov word [strcPinky + posY], 108
      mov word [frameOf_Pinky], PINKY_1
      mov word [frameOf_Pinky_eyes], EYES_UP
      call Display_Pinky
      mov word [strcPinky + velocityX], 0
      mov word [strcPinky + velocityY], -1

      mov word [strcClyde + posX], 176
      mov word [strcClyde + posY], 108
      mov word [frameOf_Clyde], CLYDE_1
      mov word [frameOf_Clyde_eyes], EYES_LEFT
      call Display_Clyde
      mov word [strcClyde + velocityX], -1
      mov word [strcClyde + velocityY], 0

   ret

   