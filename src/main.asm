section .text

    start:
    
        call SetVideoMode
        call ClearScreen
        
        
        call BuildBackgroundBuffer 
        
        call DisplayMaze
        jmp exit
        
        call FirstDisplayPacMan
        
        
        
        ;call FirstDisplayGhosts

        


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
;reset the keyboard buffer and then wait for a keypress :
mov ax, 0C01h ; 
int 21h

;dos box default video mode
mov ax, 03h 
int 21h


int 20h ;quit