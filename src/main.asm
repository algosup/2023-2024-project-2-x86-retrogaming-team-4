section .bss
    buffScreen resb SPRITE_SIZE*SPRITE_SIZE ; where is stored the backuped screen

section .data
    timestamp_of_next_frame dd 0, 0 ; timestamp of the next frame

section .text

    start:
        call SetVideoMode
        call BuildScreenBuffer ; set of functions allowing to write not directly in the video memory but in a buffer
        
        call ClearScreen

        call BuildBackgroundBuffer
        call MazeToBGbuffer
        call DisplayMaze
        call UpdateScreen
       
        call FirstDisplayPacMan
        call FirstDisplayGhosts

        ; Display the period
        mov eax, PERIOD
        shr eax, 16
        ; Store the current time
        rdtsc
        mov [timestamp_of_next_frame], eax

;-----------------------------------------------------------------------------------------
;THE GAME LOOP
    gameloop:
;-------------------------------------------------
        ;clear all
        call waitLoop
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
    mov ax, 3h
    int 10h
    int 20h

;-----------------------------------------------------------------------------------------
; WAIT FOR THE NEXT FRAME
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
;-----------------------------------------------------------------------------------------
