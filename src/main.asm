section .text

    start:

        call SetVideoMode
        call ClearScreen
        call BuildBackgroundBuffer ; !!!!!THE ERROR IS IN THIS FUNCTION!!!!!!
        call DisplayMaze
        ;call FirstDisplayGhosts
        call FirstDisplayPacMan

        jmp exit

        pusha ; for the clock, maybe not usefull

;-----------------------------------------------------------------------------------------
;THE GAME LOOP
    gameloop:
;-------------------------------------------------

    call GetClockAndCompare

    call Move_PacMan


;-------------------------------------------------
; GOTO GAME LOOP
    jmp gameloop
;-----------------------------------------------------------------------------------------

exit: