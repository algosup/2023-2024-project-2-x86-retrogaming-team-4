
; functions to allocate and then use the heap (which is a part of memory located out of the 64kio of memory containing the code, data, bss section)
; used for the screen and background buffers

section .bss

    nextFreeSegment resw 1

section .text

    heapInit:
    ; executed once before using the 'heapAllocParagraph' functions as many time as wanted

        mov ax, cs ; we get the adress of the beginning of the code, data, etc... (64Kio)
        add ax,1000h ; we jump to after the end of this window (1000h = 64Kio = 65 536)
        mov cs:[nextFreeSegment],ax ; the nextFreeSegment variable, in bss, contains the segment adress of the beginning of the 'heap'
        
        ret

    heapAllocParagraph:
    ; this function will allocate a piece of the heap : 
    ; in ax, put how many paragraphs (16 bits) (cause a paragraph is a segment with the offset=0 , and between two segment at the offset 0, there are 16 bits)
    ; the segment corresponding to this space allocated is moved in bx
    ; then, we change the value of the next segment available, at the end at the one just created

        mov bx, cs:[nextFreeSegment] ; we 
        add cs:[nextFreeSegment], ax
        
        ret
