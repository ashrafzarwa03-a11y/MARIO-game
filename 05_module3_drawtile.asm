
DrawTile:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        mov     si, [bp + 8]
        mov     di, [bp + 6]
        mov     bx, [bp + 4]
        cmp     bx, T_GROUND
        jne     skip6
        jmp     DrawTile_ground
skip6:
        cmp     bx, T_BRICK
        jne     skip7
        jmp     DrawTile_brick
skip7:
        cmp     bx, T_QCOIN
        jne     skip8
        jmp     DrawTile_qblock
skip8:
        cmp     bx, T_QMUSH
        jne     skip9
        jmp     DrawTile_qblock
skip9:
        cmp     bx, T_EMPTY
        jne     skip10
        jmp     DrawTile_empty
skip10:
        cmp     bx, T_PIPE_TL
        jne     skip11
        jmp     DrawTile_pipe_tl
skip11:
        cmp     bx, T_PIPE_TR
        jne     skip12
        jmp     DrawTile_pipe_tr
skip12:
        cmp     bx, T_PIPE_BL
        jne     skip13
        jmp     DrawTile_pipe_bl
skip13:
        cmp     bx, T_PIPE_BR
        jne     skip14
        jmp     DrawTile_pipe_br
skip14:
        cmp     bx, T_STAIR
        jne     skip15
        jmp     DrawTile_stair
skip15:
        cmp     bx, T_COIN
        jne     skip16
        jmp     DrawTile_coin
skip16:
        cmp     bx, T_POLE
        jne     skip17
        jmp     DrawTile_pole
skip17:
        jmp     DrawTile_out

DrawTile_ground:  ; brown earth with a brick pattern
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_BROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_TAN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 7
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 7
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 7
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 3
        push    ax
        mov     ax, di
        add     ax, 8
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 7
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 11
        push    ax
        mov     ax, di
        add     ax, 8
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 7
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        jmp     DrawTile_out

DrawTile_brick:  ; light bricks with dark mortar
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_TAN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 5
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 10
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 7
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 5
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 3
        push    ax
        mov     ax, di
        add     ax, 6
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 4
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 11
        push    ax
        mov     ax, di
        add     ax, 6
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 4
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 7
        push    ax
        mov     ax, di
        add     ax, 11
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 4
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 15
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        jmp     DrawTile_out

DrawTile_qblock:  ; golden block with a question mark
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GOLD
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_YELLOW
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_YELLOW
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 15
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 2
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 13
        push    ax
        mov     ax, di
        add     ax, 2
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 13
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 13
        push    ax
        mov     ax, di
        add     ax, 13
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 5
        push    ax
        mov     ax, di
        add     ax, 4
        push    ax
        mov     ax, '?'
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        mov     ax, 1
        push    ax
        call    DrawGlyph
        jmp     DrawTile_out

DrawTile_empty:  ; used-up block
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_BROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 15
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 12
        push    ax
        mov     ax, di
        add     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 12
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 12
        push    ax
        mov     ax, di
        add     ax, 12
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, C_DKBROWN
        push    ax
        call    FillRect
        jmp     DrawTile_out

DrawTile_pipe_tl:
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 3
        push    ax
        mov     ax, di
        add     ax, 2
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 12
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        jmp     DrawTile_out
DrawTile_pipe_tr:
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 15
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        jmp     DrawTile_out
DrawTile_pipe_bl:
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 14
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 2
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 5
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 2
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        jmp     DrawTile_out
DrawTile_pipe_br:
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 14
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GREEN
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 13
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_DKGREEN
        push    ax
        call    FillRect
        jmp     DrawTile_out

DrawTile_stair:  ; solid grey step block
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GRAY
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_WHITE
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 0
        push    ax
        mov     ax, di
        add     ax, 15
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, C_OUTLINE
        push    ax
        call    FillRect
        mov     ax, si
        add     ax, 15
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 1
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_OUTLINE
        push    ax
        call    FillRect
        jmp     DrawTile_out

DrawTile_coin:  ; loose coin: a sprite, blinks its width
        push    si
        push    di
        mov     ax, spr_coin
        push    ax
        mov     ax, 0
        push    ax
        call    DrawSprite
        jmp     DrawTile_out

DrawTile_pole:  ; flag pole piece (ball on the top piece)
        mov     ax, si
        add     ax, 7
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 3
        push    ax
        mov     ax, 16
        push    ax
        mov     ax, C_GREEN
        push    ax
        call    FillRect
        cmp     di, 2*TILE
        jne     DrawTile_out
        mov     ax, si
        add     ax, 5
        push    ax
        mov     ax, di
        add     ax, 0
        push    ax
        mov     ax, 7
        push    ax
        mov     ax, 6
        push    ax
        mov     ax, C_YELLOW
        push    ax
        call    FillRect
DrawTile_out:
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     6
