

section .text
    
    blinkySimpleAI:
        call distanceBetweenTwoPoints
        cmp ax, 
    
        

    distanceBetweenTwoPoints:
        mov ax, [strcPacMan + posX]
        sub ax, [strcBlinky + posX]
        mov bx, [strcPacMan + posY]
        sub bx, [strcBlinky + posY]
        ret