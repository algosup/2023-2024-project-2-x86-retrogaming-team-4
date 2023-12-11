section .text

    BuildScreenBuffer:
    ;allocates the space for the buffer in the 'heap' memory
    
        call heapInit ; called ONCE, before any use of the rest of the heap library
        mov ax, (SCREEN_HEIGHT*SCREEN_WIDTH/16) ; in ax, the number of paragraph to allocate (1 para = 16bits)
        call heapAllocParagraph
        mov [ScreenBufferSegment],bx

        ret
    
    BuildBackgroundBuffer: 
    ;allocates the space for the buffer in the 'heap' memory
        mov ax, (SCREEN_HEIGHT*SCREEN_WIDTH/16) ; in ax, the number of paragraph to allocate (1 para = 16bits)
        call heapAllocParagraph
        mov [BackgroundBufferSegment],bx
   
        ret

    UpdateScreen:
    ; clone the content of the screen buffer in the video memory adress to display it

        push ds
        push es

        mov ax,cs:[ScreenBufferSegment]
        mov ds,ax ; backBuffer segment adress
        mov ax,0xA000 ; video memory segment adress
        mov es,ax 
        xor si,si ; beginning of the backbuffer (0)
        xor di,di ; beginning of the video memory (0)
        mov cx, SCREEN_HEIGHT*SCREEN_WIDTH
        rep movsb

        pop es
        pop ds

        ret

   
   MazeToBGbuffer: 
   ; read the Maze model (array of tiles) from 'maze.asm', and build the pixels of each tile in the background buffer, according to the hexacode read in the maze model.

        xor dx, dx ; dh and dl are counters : dh will always contains the number of complete lines, dl contains the number of complete Tiles in this line
        push word [BackgroundBufferSegment]
        pop es
        ;ds is ok
        .eachTilesLine:
            mov dl, 0 ; Tiles in a line
            .eachTileOfTheLine:
            push dx
            mov ax, 8*SCREEN_WIDTH ; number of pixels in a Tile's line = 320*8 = (8*8 pixels)*(40 Tiles in a line) 
            mov bl, dh
            and bx, 0x00FF 
            mul bx
            mov di, ax ; di contains the number of pixels in complete lines
            pop dx

            mov ax, 40 ; number of Tiles in a Tile's line
            mov bl, dh
            mul bl
            mov cx, ax ; cx contains the number of Tiles in complete lines

            push dx
            and dx, 0x00FF
            add cx, dx ; cx now contains the number of complete Tiles
            pop dx

            mov ax, 8
            mov bl, dl
            mul bl
            add di, ax ; di now contains the position to write the next Tile

            mov si, MazeModel
            add si, cx
            xor ax, ax
            mov al, [ds:si] ; now al contains the hexa codes (for sprite) of the byte where is the 'cx'th Tile of mazemodel 
            
            
            push dx
            ; pick the sprite to display following the hexacode
            ; Get the offset of the sprite, following the hexa code
            mov si, MazeSpriteSheet
            mov bx, 8*8
            mul bx
            add si, ax ; si contains the offset of the sprite to display
            pop dx
            
            ;we draw the Tile
            push cx
            push dx
            mov dx,8
            .eachPixelsLine:
                mov cx, 8
                rep movsb
                add di, SCREEN_WIDTH - 8
                dec dx
                jnz .eachPixelsLine
            pop dx
            pop cx

            inc dl
            cmp dl, 40
            jb .eachTileOfTheLine
            inc dh
            cmp dh, 25
            jb .eachTilesLine
        
        ret


    DisplayMaze:
    ; it just clones the background buffer into the screen buffer

        push es
        push ds
        ;HEART OF THE FUNCTION : 'movsb' writes byte per byte the content from 'ds:si' to 'es:di', increasing both si and di each time it is executed

        ;set destination 'es:di'
        push word [ScreenBufferSegment]
        pop es 
        xor di, di

        ;set source 'ds:si'
        push word [BackgroundBufferSegment]
        pop ds
        xor si, si

        ;write
        mov cx, SCREEN_WIDTH*SCREEN_HEIGHT 
        rep movsb 

        pop ds
        pop es

        ret