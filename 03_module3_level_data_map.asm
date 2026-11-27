
level_src:
        db      "............................................................"  ; row  0
        db      "............................................................"  ; row  1
        db      ".........................................................F.."  ; row  2
        db      ".........................................................F.."  ; row  3
        db      ".........................................................F.."  ; row  4
        db      ".........................................................F.."  ; row  5
        db      "......Q.M.Q.BBB.......oo........MQ..........BBB......S...F.."  ; row  6
        db      ".................ooo......[]..........oo....ooo.....SS...F.."  ; row  7
        db      "....oo................[]..().......................SSS...F.."  ; row  8
        db      "......................()..()......................SSSS...S.."  ; row  9
        db      "#################...##################..####################"  ; row 10
        db      "#################...##################..####################"  ; row 11

BuildMap:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     si, level_src
        mov     di, level_orig
        mov     cx, MAP_SIZE
BuildMap_next:
        lodsb
        push    cx
        push    di
        mov     di, map_chars
        mov     cx, MAP_CHARS_LEN
        repne   scasb  ; position of the character = tile code
        mov     ax, MAP_CHARS_LEN - 1
        sub     ax, cx
        pop     di
        pop     cx
        stosb
        loop    BuildMap_next
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; ---------------------------------------------------------------------
;  ResetMap
;  Purpose : restore the working map from the untouched original copy
;            with one block-move instruction
;  Inputs/Outputs : none          Changes : none
; ---------------------------------------------------------------------
ResetMap:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     si, level_orig
        mov     di, level_work
        mov     cx, MAP_SIZE/2
        rep     movsw
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; data used by this part
level_orig      times MAP_SIZE db 0  ; never changed
level_work      times MAP_SIZE db 0  ; changes while playing
map_chars       db      ".#BQME[]()SoF"
MAP_CHARS_LEN   equ     13
