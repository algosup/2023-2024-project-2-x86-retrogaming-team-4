

org 100h

jmp start

;To merge all the files into one program
%include "heapLibrary.inc"
%include "constants.asm"
%include "maze.asm"
%include "sprites.asm"
%include "collider.asm"
%include "initialization.asm"
%include "buffers.asm"
%include "keyboard.asm"
%include "move_sprites.asm"
%include "interraction.asm"

section .text

;-----------------------------------------------------------------------------------------
;THE SETTINGS
    start:
;-----------------------------------------------------------------------------------------
        ;Set the VideoMode
        call SetVideoMode

        ;Set the Screen
        call BuildScreenBuffer 
        call ClearScreen

        ;Set the maze
        call BuildBackgroundBuffer

        resetPoint:

        call MazeToBGbuffer
        call DisplayMaze
        call BuildMazeModelBuffer


        ;Set the sprites (first state) 
        call FirstDisplayGhosts
        call FirstDisplayPacMan
        
        ;Display all
        call UpdateScreen

        ;Set the Timer and clock for the game loop
        call setTimer
        
        call waitForAnyKeyPressed
;-----------------------------------------------------------------------------------------
;THE GAME LOOP
    gameloop:
;-------------------------------------------------
        
        call waitLoop
        call checkFrightTime
        
        ;clear All the moving sprites 
        call ClearPinky        
        call ClearBlinky
        call ClearInky
        call ClearClyde
        call ClearPacMan

        ;look at "arrows pressed ?" and move PacMan according to the direction pressed
        call readKeyboard

        ; move the ghosts according to the defined velocity of each one
        call changePinkyPosition
        call changeBlinkyPosition
        call changeInkyPosition
        call changeClydePosition

        ;display all in the screen buffer according to the new positions (quite slow) 
        ; !!! first ghosts, then pacman !!! (to see if pacman overwrited a ghost = touched it)
        call Display_Pinky
        call Display_Blinky
        call Display_Inky
        call Display_Clyde
        call Display_PacMan
        call displayScore

        ;read if a ghost hit pacman or the reverse
        call readContact


        ;display all on the real screen (quick)
        call UpdateScreen
        
;-------------------------------------------------
; GOTO GAME LOOP
        jmp gameloop
;----------------------------------------------------------------------------------------

    