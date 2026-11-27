
DrawMap:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     ax, [camera]
        mov     cl, 4
        shr     ax, cl
        mov     [dm_col0], ax  ; first map column on screen
        mov     ax, [camera]
        and     ax, 15
        neg     ax
        mov     [dm_xoff], ax  ; screen x of that column = -(camera mod 16)
        xor     si, si  ; SI = screen column 0..20
DrawMap_column:
        mov     ax, [dm_col0]
        add     ax, si  ; map column
        cmp     ax, MAP_W
        jae     DrawMap_out
        mov     di, ax
        xor     bx, bx  ; BX = map row 0..11
DrawMap_row:
        mov     ax, bx  ; index = row*60 + column
        mov     dx, MAP_W
        mul     dx
        add     ax, di
        push    bx
        mov     bx, ax
        xor     ax, ax
        mov     al, [level_work + bx]
        pop     bx
        test    ax, ax
        jz      DrawMap_next_row
        mov     cx, ax  ; CX = tile code
        mov     ax, si  ; x = screen column * 16 + offset
        push    cx
        mov     cl, 4
        shl     ax, cl
        pop     cx
        add     ax, [dm_xoff]
        push    ax
        mov     ax, bx  ; y = row * 16
        push    cx
        mov     cl, 4
        shl     ax, cl
        pop     cx
        push    ax
        push    cx
        call    DrawTile  ; DrawTile(x, y, code)
DrawMap_next_row:
        inc     bx
        cmp     bx, MAP_H
        jb      DrawMap_row
        inc     si
        cmp     si, 21
        jae     DrawMap_out
        jmp     DrawMap_column
DrawMap_out:
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; ---------------------------------------------------------------------
;  DrawBackground
;  Purpose : clouds scrolling at half the camera speed (bonus: parallax),
;            the castle behind the flag pole and the sliding flag
;  Inputs  : camera, flag_y          Changes : none
; ---------------------------------------------------------------------
DrawBackground:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     si, cloud_table
        mov     cx, CLOUD_COUNT
DrawBackground_cloud:
        mov     ax, [si]  ; world x of the cloud
        mov     bx, [camera]
        shr     bx, 1  ; half speed
        sub     ax, bx
        cmp     ax, -40
        jl      DrawBackground_next_cloud
        cmp     ax, SCREEN_W
        jge     DrawBackground_next_cloud
        mov     dx, [si + 2]  ; y of the cloud
        mov     bx, ax  ; BX = x, DX = y
        mov     ax, bx  ; three overlapping boxes = a cloud
        add     ax, 4
        push    ax
        mov     ax, dx
        add     ax, 6
        push    ax
        mov     ax, 24
        push    ax
        mov     ax, 8
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        mov     ax, bx
        add     ax, 10
        push    ax
        mov     ax, dx
        add     ax, 2
        push    ax
        mov     ax, 12
        push    ax
        mov     ax, 6
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        mov     ax, bx
        add     ax, 2
        push    ax
        mov     ax, dx
        add     ax, 10
        push    ax
        mov     ax, 28
        push    ax
        mov     ax, 4
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
DrawBackground_next_cloud:
        add     si, 4
        dec     cx
        jz      skip18
        jmp     DrawBackground_cloud
skip18:
; castle (world x 928..959)
        mov     ax, 928
        sub     ax, [camera]
        cmp     ax, SCREEN_W
        jge     DrawBackground_flag
        mov     si, ax
        push    si
        mov     ax, 112
        push    ax
        mov     ax, 32
        push    ax
        mov     ax, 48
        push    ax
        mov     ax, C_BROWN
        push    ax
        call    FillRect
        mov     bx, 0  ; three battlements
DrawBackground_battle:
        mov     ax, bx
        add     ax, si
        push    ax
        mov     ax, 104
        push    ax
        mov     ax, 8
        push    ax
        mov     ax, 8
        push    ax
        mov     ax, C_BROWN
        push    ax
        call    FillRect
        add     bx, 12
        cmp     bx, 36
        jb      DrawBackground_battle
        mov     ax, si
        add     ax, 8
        push    ax
        mov     ax, 128  ; door
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 32
        push    ax
        mov     ax, C_BLACK
        push    ax
        call    FillRect
DrawBackground_flag:
; the flag hangs on the pole at column 57
        mov     ax, POLE_COL*TILE - 8
        sub     ax, [camera]
        cmp     ax, -16
        jl      DrawBackground_out
        cmp     ax, SCREEN_W
        jge     DrawBackground_out
        push    ax
        push    word [flag_y]
        mov     ax, spr_flag
        push    ax
        mov     ax, 0
        push    ax
        call    DrawSprite
DrawBackground_out:
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
