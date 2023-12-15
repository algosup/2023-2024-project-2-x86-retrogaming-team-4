[map symbols pac.map]
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
%include "animations.asm"
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


        call MazeToBGbuffer

        resetPoint:

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

        call checkDeath
        
        cmp word[strcPacMan + isDead], 1
        je .skipForDeath

        call checkFrightTime
        call lifeManagement
        
        ;clear All the moving sprites 
        call ClearPinky        
        call ClearBlinky
        call ClearInky
        call ClearClyde
        call ClearPacMan 
        
        ;look at "arrows pressed ?" and move PacMan according to the direction pressed
        
        call readKeyboard
        
        call GhostsSpeedUpdate
        ; move the ghosts according to the defined velocity of each one
        call changePinkyPosition
        call changeBlinkyPosition
        call changeInkyPosition
        call changeClydePosition
        

        call AnimatePacMan
        call AnimateGhosts

        ;display all in the screen buffer according to the new positions (quite slow) 
        ; !!! first ghosts, then pacman !!! (to see if pacman overwrited a ghost = touched it)
        call Display_Pinky
        call Display_Blinky
        call Display_Inky
        call Display_Clyde
        .skipForDeath:
        call Display_PacMan

        ;read if a ghost hit pacman or the reverse
        
        call readContact

        ;display fruits
        call setFruits
        call checkFruitPrint
        
        ;display all on the real screen (quick)
        call UpdateScreen
        
;-------------------------------------------------
; GOTO GAME LOOP
        jmp gameloop
;----------------------------------------------------------------------------------------

    