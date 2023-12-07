section .bss
    buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen

section .text

    start:
        call SetVideoMode
        call BuildScreenBuffer ; set of functions allowing to write not directly in the video memory but in a buffer
        
        call ClearScreen
        call UpdateScreen

        call BuildBackgroundBuffer
        call MazeToBGbuffer
        call DisplayMaze
        call UpdateScreen
        jmp exit
       
        call FirstDisplayPacMan
        call FirstDisplayGhosts

        
        
        
        




;-----------------------------------------------------------------------------------------
;THE GAME LOOP
    gameloop:
;-------------------------------------------------
        ;clear all
        call ClearPinky
        call ClearBlinky
        call ClearInky
        call ClearClyde
        call ClearPacMan

        call readKeyboard

        call changePinkyPosition
        call changeBlinkyPosition
        call changeInkyPosition
        call changeClydePosition

        call Display_PacMan
        call Display_Pinky
        call Display_Blinky
        call Display_Inky
        call Display_Clyde

        call UpdateScreen


;-------------------------------------------------
; GOTO GAME LOOP
        jmp gameloop
;-----------------------------------------------------------------------------------------

exit:
;reset the keyboard buffer and then wait for a keypress :
   mov ax, 0C01h ;
   int 21h

