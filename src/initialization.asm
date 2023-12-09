section .bss

   BackgroundBufferSegment resw 1 ; segment of the adress of the dynamic background buffer (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage
   ScreenBufferSegment resw 1 ; segment of the adress of the screen buffer (a virtual video memory actually)

section .data

    timestamp_of_next_frame dd 0, 0 ; timestamp of the next frame

   
section .text

   setTimer:
   ; initialization of the clock for the game loop

      ; Display the period
      mov eax, PERIOD
      shr eax, 16
      ; Store the current time
      rdtsc
      mov [timestamp_of_next_frame], eax

      ret

   exit:
   ;video mode restored ,retore the command line window

      mov ax, 3h
      int 10h
      int 20h

      ret

    waitLoop:
    ; wait from the next frame , according to the clock state

      .wait_for_next_frame:
         ; Read the current time
         rdtsc

         ; If not yet the correct time, keep going
         cmp eax, [timestamp_of_next_frame]
         jb .wait_for_next_frame

      ; Set next wait time
      mov eax, [timestamp_of_next_frame]
      add eax, PERIOD
      mov [timestamp_of_next_frame], eax

      ret

   SetVideoMode:
   ; To have a display with a size of 320 x 200 pixels and using 256 colors

      mov ah, 00h ; chose the video mode setting function at the 10h interruption
      mov al, 13h ; set video mode option to 320 x 200 256 colors
      int 10h

      push word [ScreenBufferSegment] 
      pop es

      ret

   ClearScreen:
      ;clear the screen by filling it with a unique color (stored in al)
      mov al, 0x29 ; color to fill the screen (white = 0x0F, black = 0x00)
            
      ;set the destination 'es:di' :
      push word [ScreenBufferSegment]
      pop es
      mov di, 0
      mov cx, SCREEN_WIDTH*SCREEN_HEIGHT
      rep stosb ; from 'al' to 'es:di'

      ret

   FirstDisplayPacMan:
   ; set the initial position and frame (mouth closed or not, ...) and display it

      mov word [strcPacMan + posX], 160
      mov word [strcPacMan + posY], 132
      mov word [frameOf_PacMan], PACMAN_RIGHT_2

      call Display_PacMan

      ret

   FirstDisplayGhosts:
   ; for each ghost : set the initial : -POSITION- -FRAME- -EYES FRAME- -DIRECTION- -SPEED- and then display it

      mov word [strcBlinky + posX], 160
      mov word [strcBlinky + posY], 84
      mov word [frameOf_Blinky], BLINKY_1
      call Display_Blinky
      mov word [strcBlinky + velocityX], 0
      mov word [strcBlinky + velocityY], -1

      mov word [strcInky + posX], 144
      mov word [strcInky + posY], 108
      mov word [frameOf_Inky], INKY_1
      call Display_Inky
      mov word [strcInky + velocityX], 0
      mov word [strcInky + velocityY], 1

      mov word [strcPinky + posX], 160
      mov word [strcPinky + posY], 108
      mov word [frameOf_Pinky], PINKY_1
      call Display_Pinky
      mov word [strcPinky + velocityX], 1
      mov word [strcPinky + velocityY], 0

      mov word [strcClyde + posX], 176
      mov word [strcClyde + posY], 108
      mov word [frameOf_Clyde], CLYDE_1
      call Display_Clyde
      mov word [strcClyde + velocityX], -1
      mov word [strcClyde + velocityY], 0

      ret
   
   resetGame:
      mov word [strcPacMan + velocityX], 0
      mov word [strcPacMan + velocityY], 0
      mov byte [keyPressed], 0
      jmp resetPoint

      ret

   waitForAnyKeyPressed:
      mov ax, 0C01h
      int 21h

      ret