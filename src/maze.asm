; MATCHING TABLE :

; INTER                       00             
; OUT_TOP_LEFT_CORNER         01
; OUT_TOP_RIGHT_CORNER        02
; OUT_BOTTOM_LEFT_CORNER      03
; OUT_BOTTOM_RIGHT_CORNER     04
; IN_TOP_LEFT_CORNER          05
; IN_TOP_RIGHT_CORNER         06
; IN_BOTTOM_LEFT_CORNER       07
; IN_BOTTOM_RIGHT_CORNER      08
; TOP_LINE                    09
; BOTTOM_LINE               0x0A
; LEFT_LINE                 0x0B
; RIGHT_LINE                0x0C
; PELLET                    0x0D
; SUPER_PELLET              0x0E
; BACKGROUND                0x0F


section .data

    MazeModel   db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                db 0x1A, 0x1B, 0x1C, 0x1A, 0x0F, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                db 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                db 0x1, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x02, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x01, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x02
                db 0xB, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C
                db 0xB, 0x0D, 0x05, 0x06, 0x0D, 0x05, 0x0A, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x0F, 0x0B, 0x0D, 0x0C, 0x01, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0C, 0x0B, 0x0D, 0x07, 0x08, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x0B, 0x0E, 0x0C, 0x0F, 0x0B, 0x0D, 0x07, 0x08, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0B, 0x0E, 0x0D, 0x0D, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x0F, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x05, 0x0A, 0x0A, 0x06, 0x0D, 0x0C, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x03, 0x04, 0x0A, 0x0A, 0x06, 0x0D, 0x0C
                db 0xB, 0x0D, 0x07, 0x08, 0x0D, 0x07, 0x09, 0x08, 0x0D, 0x05, 0x06, 0x0D, 0x0C, 0x01, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x02, 0x0B, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0B, 0x0D, 0x07, 0x08, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C
                db 0x4, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0F, 0x05, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0F, 0x0C, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x03
                db 0x9, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x04, 0x0A, 0x0A, 0x06, 0x0F, 0x0C, 0x01, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x02, 0x0B, 0x0F, 0x07, 0x08, 0x0D, 0x0C, 0x0F, 0x0F, 0x0B, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09
                db 0xF, 0x0F, 0x0F, 0x0F, 0x0D, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x0F, 0x0F, 0x0F, 0x0B, 0x0F, 0x0C, 0x0B, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0C, 0x0B, 0x0F, 0x0D, 0x0D, 0x0D, 0x0C, 0x0F, 0x0F, 0x0B, 0x0D, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                db 0xA, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x01, 0x09, 0x09, 0x08, 0x0F, 0x0C, 0x04, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x03, 0x0B, 0x0F, 0x05, 0x06, 0x0D, 0x0C, 0x0F, 0x0F, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x0A
                db 0x1, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x08, 0x0D, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0F, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0F, 0x0C, 0x0B, 0x0D, 0x07, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x02
                db 0xB, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0B, 0x0D, 0x05, 0x06, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C
                db 0xB, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x0C, 0x0B, 0x0D, 0x0C, 0x04, 0x0A, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x03, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x01, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0C, 0x0B, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x0C, 0x0F, 0x01, 0x09, 0x08, 0x0D, 0x07, 0x08, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x0B, 0x0E, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0F, 0x0B, 0x0D, 0x0D, 0x0E, 0x0D, 0x0D, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0C, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x06, 0x0D, 0x05, 0x0A, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x03, 0x04, 0x0A, 0x0A, 0x06, 0x0D, 0x05, 0x0A, 0x0A, 0x0A, 0x03, 0x0F, 0x0B, 0x0D, 0x05, 0x0A, 0x0A, 0x06, 0x0D, 0x0C
                db 0xB, 0x0D, 0x07, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x08, 0x0D, 0x0C, 0x0B, 0x0D, 0x07, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x09, 0x09, 0x09, 0x08, 0x0D, 0x07, 0x09, 0x09, 0x08, 0x0D, 0x0C
                db 0xB, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C, 0x0B, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0D, 0x0C
                db 0x4, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x03, 0x04, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x03
                  
    ; the tiles, 8x8 pixels, each byte is a color
    ; We can have maximum 256 tiles. When you add one tile, don't forget to reference it at the top of the file

    MazeSpriteSheet db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27 ; Inter                   0
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
                    db 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27, 0x27
    
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Out Top Left Corner     1
                    db 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01
                    db 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Out Top Right Corner    2
                    db 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00    

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00 ; Out Bottom Left Corner  3
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00
                    db 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Out Bottom Right Corner 4
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; In Top Left Corner      5
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; In Top Right Corner     6
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00 ; In Bottom Left Corner   7
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; In Bottom Right Corner  8
                    db 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Top Line                9
                    db 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Bottom Line             10
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Left Line               11
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00 ; Right Line              12
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Pellet                  13
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0E, 0x0E, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0E, 0x0E, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Super Pellet            14
                    db 0x00, 0x00, 0x00, 0x0E, 0x0E, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x0E, 0x0E, 0x0E, 0x0E, 0x00, 0x00
                    db 0x00, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x00
                    db 0x00, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x00
                    db 0x00, 0x00, 0x0E, 0x0E, 0x0E, 0x0E, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0E, 0x0E, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ; Background              15
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00 ;  Sprite zero            10
                    db 0x00, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00 ;  Sprite one             11
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite two             12
                    db 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F ;  Sprite three           13
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite four            14
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite five            15
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite six             16
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F ;  Sprite seven           17
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00 ;  Sprite eight           18
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite nine            19
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F ;  Sprite H               1A
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F ;  Sprite I               1B
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F ;  Sprite G               1C
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00 ;  Sprite S               1D
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite C               1E
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite O               1F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite R               20
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F ;  Sprite E               21
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F ;  Sprite U               22
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00 ;  Sprite H               23
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x0F, 0x0F
                    db 0x00, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x0F, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x0F, 0x0F, 0x00, 0x00, 0x00, 0x00, 0x00
                    db 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00