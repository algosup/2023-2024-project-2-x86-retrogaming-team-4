struc Sprite
    posX: resw 1
    posY: resw 1
    absPos: resw 1
    velocityX: resw 1
    velocityY: resw 1
    isChased: resb 1
    isDead: resb 1
endstruc

%define SCREEN_WIDTH 320
%define SCREEN_HEIGHT 200
%define SPRITE_SIZE 16
%define TILE_SIZE 8
%define BACKGROUND_COLOR 0

%define UP_KEY_SCANCODE 48h
%define DOWN_KEY_SCANCODE 50h
%define LEFT_KEY_SCANCODE 4bh
%define RIGHT_KEY_SCANCODE 4dh
%define EXIT_KEY_SCANCODE 01h

%define BACKGROUND_COLOR 0

%define BLINKY_1 0
%define BLINKY_2 1
%define PINKY_1 2
%define PINK_2 3
%define INKY_1 4
%define INKY_2 5
%define CLYDE_1 6
%define CLYDE_2 7
%define AFRAID_1 8
%define AFRAID_2 9
%define AFRAID_3 10
%define AFRAID_4 11
%define EYES_RIGHT 12
%define EYES_LEFT 13
%define EYES_UP 14
%define EYES_DOWN 15
%define PACMAN_RIGHT_1 16
%define PACMAN_RIGHT_2 17
%define PACMAN_UP_1 18
%define PACMAN_UP_2 19
%define PACMAN_LEFT_1 20
%define PACMAN_LEFT_2 21
%define PACMAN_DOWN_1 22
%define PACMAN_DOWN_2 23
%define CHERRY 24
%define STRAWBERRY 25
%define ORANGE 26
%define APPLE 27
%define MELON 28
%define GALAXIAN 29
%define BELL 30
%define KEY 31
%define PACMAN_FULL 32
%define PACMAN_DEATH_1 33
%define PACMAN_DEATH_2 34
%define PACMAN_DEATH_3 35
%define PACMAN_DEATH_4 36
%define PACMAN_DEATH_5 37
%define PACMAN_DEATH_6 38
%define PACMAN_DEATH_7 39
%define PACMAN_DEATH_8 40
%define PACMAN_DEATH_9 41
%define PACMAN_DEATH_10 42
%define DOT 43
%define POWER_PELLET 44

; Clock cycle per second and desired FPS
%define CCPS 3000000
%define FPS 24

; Clock percision is in µs
%define PERIOD CCPS / FPS


section .data 

    ;color palette of the following sprites
    palette db 0, 44, 40, 15, 66, 33, 84, 52, 88, 48, 78, 3, 65, 0

    ;spritesheet 
    spritesheet dd 0x00000000, 0x00000000, 0x22000000, 0x00000022, 0x22220000, 0x00002222, 0x22220200, 0x00202222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x20222002, 0x20022202, 0x20020002, 0x20002002, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x22000000, 0x00000022, 0x22220000, 0x00002222, 0x22220200, 0x00202222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22222202, 0x20222222, 0x22202202, 0x20220222, 0x02002200, 0x00220020, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x66000000, 0x00000066, 0x66660000, 0x00006666, 0x66660600, 0x00606666, 0x66666600, 0x00666666, 0x66666600, 0x00666666, 0x66666600, 0x00666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x60666006, 0x60066606, 0x60060006, 0x60006006, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x66000000, 0x00000066, 0x66660000, 0x00006666, 0x66660600, 0x00606666, 0x66666600, 0x00666666, 0x66666600, 0x00666666, 0x66666600, 0x00666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66666606, 0x60666666, 0x66606606, 0x60660666, 0x06006600, 0x00660060, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x77000000, 0x00000077, 0x77770000, 0x00007777, 0x77770700, 0x00707777, 0x77777700, 0x00777777, 0x77777700, 0x00777777, 0x77777700, 0x00777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x70777007, 0x70077707, 0x70070007, 0x70007007, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x77000000, 0x00000077, 0x77770000, 0x00007777, 0x77770700, 0x00707777, 0x77777700, 0x00777777, 0x77777700, 0x00777777, 0x77777700, 0x00777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77777707, 0x70777777, 0x77707707, 0x70770777, 0x07007700, 0x00770070, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x44000000, 0x00000044, 0x44440000, 0x00004444, 0x44440400, 0x00404444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x40444004, 0x40044404, 0x40040004, 0x40004004, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x44000000, 0x00000044, 0x44440000, 0x00004444, 0x44440400, 0x00404444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44444404, 0x40444444, 0x44404404, 0x40440444, 0x04004400, 0x00440040, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x55000000, 0x00000055, 0x55550000, 0x00005555, 0x55550500, 0x00505555, 0x55555500, 0x00555555, 0x55555500, 0x00555555, 0x85585500, 0x00558558, 0x85585505, 0x50558558, 0x55555505, 0x50555555, 0x55555505, 0x50555555, 0x58855805, 0x50855885, 0x85588505, 0x50588558, 0x55555505, 0x50555555, 0x50555005, 0x50055505, 0x50050005, 0x50005005, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x55000000, 0x00000055, 0x55550000, 0x00005555, 0x55550500, 0x00505555, 0x55555500, 0x00555555, 0x55555500, 0x00555555, 0x85585500, 0x00558558, 0x85585505, 0x50558558, 0x55555505, 0x50555555, 0x55555505, 0x50555555, 0x58855805, 0x50855885, 0x85588505, 0x50588558, 0x55555505, 0x50555555, 0x55505505, 0x50550555, 0x05005500, 0x00550050, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x33000000, 0x00000033, 0x33330000, 0x00003333, 0x33330300, 0x00303333, 0x33333300, 0x00333333, 0x33333300, 0x00333333, 0x23323300, 0x00332332, 0x23323303, 0x30332332, 0x33333303, 0x30333333, 0x33333303, 0x30333333, 0x32233203, 0x30233223, 0x23322303, 0x30322332, 0x33333303, 0x30333333, 0x30333003, 0x30033303, 0x30030003, 0x30003003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x33000000, 0x00000033, 0x33330000, 0x00003333, 0x33330300, 0x00303333, 0x33333300, 0x00333333, 0x33333300, 0x00333333, 0x23323300, 0x00332332, 0x23323303, 0x30332332, 0x33333303, 0x30333333, 0x33333303, 0x30333333, 0x32233203, 0x30233223, 0x23322303, 0x30322332, 0x33333303, 0x30333333, 0x33303303, 0x30330333, 0x03003300, 0x00330030, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x30030000, 0x00300300, 0x33330000, 0x00333300, 0x55330000, 0x00553300, 0x55330000, 0x00553300, 0x30030000, 0x00300300, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00300300, 0x00003003, 0x00333300, 0x00003333, 0x00335500, 0x00003355, 0x00335500, 0x00003355, 0x00300300, 0x00003003, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00550000, 0x00005500, 0x30550300, 0x00305503, 0x30330300, 0x00303303, 0x30330300, 0x00303303, 0x00330000, 0x00003300, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00330000, 0x00003300, 0x30330300, 0x00303303, 0x30330300, 0x00303303, 0x30550300, 0x00305503, 0x00550000, 0x00005500, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00000011, 0x11111100, 0x00000010, 0x11111100, 0x00000000, 0x10111101, 0x00000000, 0x00111101, 0x00000000, 0x00101101, 0x00000000, 0x00111101, 0x00000000, 0x10111101, 0x00000000, 0x11111100, 0x00000000, 0x11111100, 0x00000010, 0x11110100, 0x00000011, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00001111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11111101, 0x00001011, 0x11111101, 0x00000000, 0x00101101, 0x00000000, 0x11111101, 0x00000000, 0x11111101, 0x00001011, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00001001, 0x00110000, 0x00001101, 0x00110100, 0x00101101, 0x00111100, 0x00111101, 0x00111101, 0x10111101, 0x00111111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00100100, 0x00001100, 0x00101100, 0x00101100, 0x00111100, 0x00101101, 0x00111101, 0x00111101, 0x00111101, 0x00111101, 0x10111101, 0x00111111, 0x10111101, 0x00111111, 0x10111101, 0x00111111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11010000, 0x00001111, 0x11000000, 0x00101111, 0x01000000, 0x00101111, 0x00000000, 0x00111111, 0x00000000, 0x00111101, 0x00000000, 0x00111100, 0x00000000, 0x00111101, 0x00000000, 0x00111111, 0x01000000, 0x00101111, 0x11000000, 0x00101111, 0x11010000, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00001111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110000, 0x00111111, 0x01000000, 0x00111111, 0x00000000, 0x00111100, 0x01000000, 0x00111111, 0x11110000, 0x00111111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00001111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x10111101, 0x00111111, 0x00111101, 0x00111101, 0x00101101, 0x00111100, 0x00001101, 0x00110100, 0x00001001, 0x00110000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00001111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x10111101, 0x00111111, 0x10111101, 0x00111111, 0x10111101, 0x00111111, 0x00111101, 0x00111101, 0x00111101, 0x00111101, 0x00111100, 0x00101101, 0x00101100, 0x00101100, 0x00100100, 0x00001100, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00cc0000, 0x00000000, 0x00cccc00, 0x00000000, 0x00000ccc, 0x0c000000, 0x00000c00, 0xc0220200, 0x0000c000, 0x222c2200, 0x0000000c, 0x20222200, 0x0000222c, 0x02222300, 0x0020222c, 0x02322200, 0x00202222, 0x02220200, 0x00202232, 0x02000000, 0x00202223, 0x00000000, 0x00002222, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x03000000, 0x00000000, 0x93990000, 0x00009099, 0x99290200, 0x00002299, 0x29222200, 0x00202322, 0x22222300, 0x00202223, 0x23232200, 0x00202222, 0x22222200, 0x00203222, 0x23320200, 0x00002222, 0x22220200, 0x00002222, 0x32220000, 0x00000023, 0x22020000, 0x00000022, 0x02000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00009009, 0x0c000000, 0x00909999, 0x0c000000, 0x00009909, 0xcc440000, 0x000044c4, 0x4c440400, 0x00404444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44444400, 0x00444444, 0x44440400, 0x00404444, 0x44440400, 0x00404444, 0x44040000, 0x00004044, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x000000c0, 0x0c220200, 0x00002202, 0x2c222200, 0x00202222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222200, 0x00222222, 0x22222200, 0x00222322, 0x22222200, 0x00222322, 0x22220200, 0x00203222, 0x22220200, 0x00202222, 0x22220000, 0x00002222, 0x20020000, 0x00002022, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00b00000, 0x00000000, 0xbb0b0000, 0x000000bb, 0x0b000000, 0x00000000, 0x93000000, 0x00000090, 0x9b990000, 0x00009099, 0xb9b30900, 0x0000b999, 0x999b0900, 0x0000993b, 0x99b99300, 0x0090b9b9, 0x3b999b00, 0x00903b99, 0x99b99300, 0x009099b9, 0x3b9b0900, 0x0000993b, 0xb9990900, 0x0000b999, 0x999b0000, 0x0000909b, 0x99000000, 0x000000b0, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x02000000, 0x00000000, 0x22005000, 0x00500020, 0x22025000, 0x00500022, 0x12225100, 0x00502112, 0x12115100, 0x00501111, 0x11115500, 0x00501511, 0x01510500, 0x00005501, 0x01550000, 0x00005005, 0x01050000, 0x00000005, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x01000000, 0x00000010, 0x1d010000, 0x000010d1, 0x11110000, 0x00001111, 0xd1110000, 0x00001111, 0x111d0000, 0x00001111, 0x111d0100, 0x00101111, 0x111d0100, 0x00101111, 0x11110100, 0x00101111, 0x11d11100, 0x00111111, 0x11d11100, 0x00111111, 0x11111100, 0x00111111, 0xaaaa1a00, 0x00a1aa33, 0xaaaa0a00, 0x00a0aa33, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xaa000000, 0x000000a0, 0x00aa0000, 0x0000a00a, 0xaaaa0000, 0x0000a0aa, 0xaaaa0000, 0x0000a0aa, 0xaaaa0000, 0x0000a0aa, 0x3d000000, 0x00000030, 0x3d000000, 0x00000033, 0x3d000000, 0x00000030, 0x3d000000, 0x000000d0, 0x3d000000, 0x00000030, 0x3d000000, 0x00000033, 0x3d000000, 0x00000030, 0x03000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11010000, 0x00000011, 0x11110100, 0x00001111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11111101, 0x00111111, 0x11111101, 0x00111111, 0x11111101, 0x00111111, 0x11111101, 0x00111111, 0x11111101, 0x00111111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00001001, 0x00110000, 0x00001101, 0x00110100, 0x00101101, 0x00111100, 0x00111101, 0x00111101, 0x10111101, 0x00111111, 0x11111100, 0x00101111, 0x11111100, 0x00101111, 0x11110100, 0x00001111, 0x11010000, 0x00000011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000001, 0x00010000, 0x00001111, 0x10110100, 0x00101111, 0x10111100, 0x10111111, 0x10111111, 0x11111101, 0x00111111, 0x11111101, 0x00111111, 0x11111100, 0x00101111, 0x10110000, 0x00001011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00001011, 0x10110000, 0x00111111, 0x10111101, 0x11111111, 0x10111111, 0x11111101, 0x00111111, 0x11111100, 0x00101111, 0x10110000, 0x00001011, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00001111, 0x10110100, 0x11111111, 0x10111111, 0x11111111, 0x10111111, 0x11111101, 0x00111111, 0x10110100, 0x00001111, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11110000, 0x00001011, 0x11111111, 0x10111111, 0x11111111, 0x10111111, 0x11111101, 0x00111111, 0x10110100, 0x00001111, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x11000000, 0x00000010, 0x11110000, 0x00001011, 0x11111101, 0x00111111, 0x11111111, 0x10111111, 0x10111101, 0x00111111, 0x00110100, 0x00001101, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x01000000, 0x00000000, 0x11000000, 0x00000010, 0x11110000, 0x00001011, 0x11110100, 0x00001111, 0x11111101, 0x00111111, 0x10111101, 0x00111111, 0x00111100, 0x00101101, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x11000000, 0x00000010, 0x11000000, 0x00000010, 0x11000000, 0x00000010, 0x11010000, 0x00000011, 0x10000000, 0x00000010, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x01000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00010000, 0x00000001, 0x10000000, 0x00000010, 0x00000100, 0x00000100, 0x00100000, 0x00001000, 0x00000000, 0x00000000, 0x00001100, 0x00100100, 0x00000000, 0x00000000, 0x00100000, 0x00001000, 0x00000100, 0x00000100, 0x10000000, 0x00000010, 0x00010000, 0x00000001, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x08000000, 0x00000080, 0x08000000, 0x00000080, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x88000000, 0x00000088, 0x88080000, 0x00008088, 0x88880000, 0x00008888, 0x88880000, 0x00008888, 0x88880000, 0x00008888, 0x88880000, 0x00008888, 0x88080000, 0x00008088, 0x88000000, 0x00000088, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000, 0x00000000

