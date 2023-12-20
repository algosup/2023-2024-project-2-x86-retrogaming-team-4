section .bss

   BackgroundBufferSegment resw 1 ; segment of the adress of the dynamic background buffer (dynamic cuz gums are disappearing). Used to restore the screen after a ghost's passage
   ScreenBufferSegment resw 1 ; segment of the adress of the screen buffer (a virtual video memory actually)

section .data

    timestamp_of_next_frame dd 0, 0 ; timestamp of the next frame
    timerDeathPacMan dw 0

   
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

      mov word [strcPacMan + posX], PACMAN_START_X
      mov word [strcPacMan + posY], PACMAN_START_Y
      mov word [strcPacMan + frame], PACMAN_FULL
      call Display_PacMan

      ret

   FirstDisplayGhosts:
   ; for each ghost : set the initial : -POSITION- -FRAME- -EYES FRAME- -DIRECTION- -SPEED- and then display it

      mov word [strcBlinky + posX], 160
      mov word [strcBlinky + posY], 84
      mov word [strcBlinky + frame], BLINKY_1
      mov word [Blinky_eyes], EYES_UP
      call Display_Blinky
      mov word [strcBlinky + velocityX], 1*SPRITE_SPEED_PIXELS
      mov word [strcBlinky + velocityY], 0
      mov word [strcBlinky + nextVelocityX], 1*SPRITE_SPEED_PIXELS
      mov word [strcBlinky + nextVelocityY], 0

      mov word [strcInky + posX], 144
      mov word [strcInky + posY], 108
      mov word [strcInky + frame], INKY_1
      mov word [Inky_eyes], EYES_DOWN
      call Display_Inky
      mov word [strcInky + velocityX], 0
      mov word [strcInky + velocityY], 0
      mov word [strcInky + nextVelocityX], 0
      mov word [strcInky + nextVelocityY], 0

      mov word [strcPinky + posX], 160
      mov word [strcPinky + posY], 108
      mov word [strcPinky + frame], PINKY_1
      mov word [Pinky_eyes], EYES_RIGHT
      call Display_Pinky
      mov word [strcPinky + velocityX], 0
      mov word [strcPinky + velocityY], -1*SPRITE_SPEED_PIXELS
      mov word [strcPinky + nextVelocityX], 0
      mov word [strcPinky + nextVelocityY], -1*SPRITE_SPEED_PIXELS

      mov word [strcClyde + posX], 176
      mov word [strcClyde + posY], 108
      mov word [strcClyde + frame], CLYDE_1
      mov word [Clyde_eyes], EYES_LEFT
      call Display_Clyde
      mov word [strcClyde + velocityX], 0
      mov word [strcClyde + velocityY], 0
      mov word [strcClyde + nextVelocityX], 0
      mov word [strcClyde + nextVelocityY], 0

      ret
   
   resetGame:
      mov word [strcPacMan + velocityX], 0
      mov word [strcPacMan + velocityY], 0
      mov byte [keyPressed], 0
      jmp start.resetPoint

      ret

   waitForAnyKeyPressed:
      mov ax, 0C01h
      int 21h

      ret
   
   checkDeath:
      cmp word[strcPacMan + isDead], 1
      je .death
      ret
      .death:
         call DisplayMaze
         inc word[timerDeathPacMan]
         cmp word[timerDeathPacMan], 0x3; how many gameloop'sframes skip for frequency of actualization of the pacman death animation
         jne .NOTloadAnimation
         call PacmanDeathAnimation
         call Display_PacMan
         cmp word[strcPacMan + isDead], 0
         je .resetGame
         
         .NOTloadAnimation:
         ret

         .resetGame:
            call checkGameOver
            mov word[PacmanDeathCounter], PACMAN_DEATH_1-1
            call resetGame
            ret
         
   checkGameOver:
      cmp byte [isGameOver], 1
      jne .notGameOver
         call DisplayMaze
         call displayScore
         call displayGameOver
         call UpdateScreen
         call waitForAnyKeyPressed
         jmp exit
      .notGameOver:
      ret
