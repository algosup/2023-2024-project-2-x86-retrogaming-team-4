
section .text

    start:
        call SetVideoMode
        call BuildScreenBuffer ; set of functions allowing to write not directly in the video memory but in a buffer
        
        ;call ClearScreen
        call BuildBackgroundBuffer
        call MazeToBGbuffer
        call DisplayMaze
        ;call FirstDisplayPacMan
        call FirstDisplayGhosts

        
        
        
        




;-----------------------------------------------------------------------------------------
;THE GAME LOOP
    gameloop:
;-------------------------------------------------
    
    call ClearPinky
    call changePinkyPosition
    call Display_Pinky
    call UpdateScreen


;-------------------------------------------------
; GOTO GAME LOOP
    jmp gameloop
;-----------------------------------------------------------------------------------------

