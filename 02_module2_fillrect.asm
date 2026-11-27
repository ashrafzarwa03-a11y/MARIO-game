
FillRect:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    es
        mov     ax, [bp + 12]
        mov     bx, [bp + 10]
        mov     cx, [bp + 8]
        mov     dx, [bp + 6]
        cmp     ax, 0  ; clip left edge
        jge     FillRect_xl_ok
        add     cx, ax  ; width shrinks by the hidden part
        xor     ax, ax
FillRect_xl_ok:
        mov     si, ax  ; clip right edge
        add     si, cx
        cmp     si, SCREEN_W
        jle     FillRect_xr_ok
        mov     cx, SCREEN_W
        sub     cx, ax
FillRect_xr_ok:
        cmp     cx, 0
        jle     FillRect_out
        cmp     bx, 0  ; clip top edge
        jge     FillRect_yt_ok
        add     dx, bx
        xor     bx, bx
FillRect_yt_ok:
        mov     si, bx  ; clip bottom edge
        add     si, dx
        cmp     si, SCREEN_H
        jle     FillRect_yb_ok
        mov     dx, SCREEN_H
        sub     dx, bx
FillRect_yb_ok:
        cmp     dx, 0
        jle     FillRect_out
        mov     di, bx
        push    cx
        mov     cl, 8
        shl     di, cl
        pop     cx
        push    cx
        mov     cl, 6
        shl     bx, cl
        pop     cx
        add     di, bx
        add     di, ax  ; DI = start offset
        mov     es, [fb_seg]
        mov     al, [bp + 4]
FillRect_row:
        push    cx
        push    di
        rep     stosb  ; one row of the rectangle
        pop     di
        pop     cx
        add     di, SCREEN_W
        dec     dx
        jnz     FillRect_row
FillRect_out:
        pop     es
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     10
