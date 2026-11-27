
GetTile:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        mov     ax, [bp + 6]
        mov     bx, [bp + 4]
        cmp     ax, 0
        jl      GetTile_solid_edge
        cmp     ax, WORLD_W
        jge     GetTile_solid_edge
        cmp     bx, 0
        jl      GetTile_sky
        cmp     bx, MAP_BOTTOM
        jge     GetTile_sky
        mov     cl, 4
        shr     ax, cl  ; column = px / 16
        shr     bx, cl  ; row    = py / 16
        mov     dx, MAP_W
        push    ax
        mov     ax, bx
        mul     dx  ; row * 60
        pop     bx
        add     bx, ax  ; + column
        xor     ax, ax
        mov     al, [level_work + bx]
        jmp     GetTile_done
GetTile_solid_edge:
        mov     ax, T_GROUND
        jmp     GetTile_done
GetTile_sky:
        xor     ax, ax
GetTile_done:
        mov     [bp - 2], ax  ; return value in the saved AX
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     4

; ---------------------------------------------------------------------
;  IsSolid(px, py)  ->  AX
;  Purpose : 1 if the tile at that world pixel stops Mario (codes 1..10)
;  Inputs  : [bp+6]=px  [bp+4]=py        Outputs : AX = 0 or 1
;  Changes : AX only
; ---------------------------------------------------------------------
IsSolid:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    word [bp + 6]
        push    word [bp + 4]
        call    GetTile
        xor     bx, bx
        cmp     ax, T_GROUND
        jb      IsSolid_store
        cmp     ax, T_STAIR
        ja      IsSolid_store
        mov     bx, 1
IsSolid_store:
        mov     [bp - 2], bx
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     4
