section .bss

   BackgroundBufferSegment resw 1 ; where is stored the dynamic background (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage
   ScreenBufferSegment resw 1

section .data

    timestamp_of_next_frame dd 0, 0 ; timestamp of the next frame

section .text

   setTimer:
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

   
   ; WAIT FOR THE NEXT FRAME function
    waitLoop:
      .wait_for_next_frame:
         ; Read the current time
         rdtsc

         ; If not yet the correct time, keep going
         cmp eax, [timestamp_of_next_frame]
         jb .wait_for_next_frame

      ; Set next wait time
      ; mov eax, [timestamp_of_next_frame]
      add eax, PERIOD
      mov [timestamp_of_next_frame], eax

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

   FirstDisplayPacMan:

      mov word [x_PacManPosition], 160
      mov word [y_PacManPosition], 132
      mov word [frameOf_PacMan], PACMAN_RIGHT_2
      call Display_PacMan

      ret

   FirstDisplayGhosts:
      ;pinky
      mov word [x_PinkyPosition], 160
      mov word [y_PinkyPosition], 108
      mov word [frameOf_Pinky], PINKY_1
      mov word [frameOf_Pinky_eyes], EYES_UP
      call Display_Pinky
      mov word [x_PinkyVelocity], 0
      mov word [y_PinkyVelocity], -1
      ;blinky
      mov word [x_BlinkyPosition], 160
      mov word [y_BlinkyPosition], 84
      mov word [frameOf_Blinky], BLINKY_1
      mov word [frameOf_Blinky_eyes], EYES_RIGHT
      call Display_Blinky
      mov word [x_BlinkyVelocity], 1
      mov word [y_BlinkyVelocity], 0
      ;inky
      mov word [x_InkyPosition], 144
      mov word [y_InkyPosition], 108
      mov word [frameOf_Inky], INKY_1
      mov word [frameOf_Inky_eyes], EYES_DOWN
      call Display_Inky
      mov word [x_InkyVelocity], 0
      mov word [y_InkyVelocity], 1
      ;clyde
      mov word [x_ClydePosition], 176
      mov word [y_ClydePosition], 108
      mov word [frameOf_Clyde], CLYDE_1
      mov word [frameOf_Clyde_eyes], EYES_LEFT
      call Display_Clyde
      mov word [x_ClydeVelocity], -1
      mov word [y_ClydeVelocity], 0

      ret

   