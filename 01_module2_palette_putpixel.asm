
SetPalette:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     dx, 3C8h
        xor     al, al  ; start at colour 0
        out     dx, al
        inc     dx  ; port 3C9h: R, G, B (6 bits each)
        mov     si, palette_data
        mov     cx, 24*3
SetPalette_outp:
        lodsb
        out     dx, al
        loop    SetPalette_outp
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; ---------------------------------------------------------------------
;  PutPixel(x, y, colour)
;  Purpose : write one pixel into the frame buffer (clipped to the screen)
;  Inputs  : [bp+8]=x  [bp+6]=y  [bp+4]=colour       Changes : none
;  Offset  : y*320 + x  = (y<<8) + (y<<6) + x
; ---------------------------------------------------------------------
PutPixel:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    es
        mov     ax, [bp + 8]
        cmp     ax, SCREEN_W  ; unsigned test also rejects negatives
        jae     PutPixel_out
        mov     bx, [bp + 6]
        cmp     bx, SCREEN_H
        jae     PutPixel_out
        mov     di, bx
        push    cx
        mov     cl, 8
        shl     di, cl
        pop     cx  ; y * 256
        push    cx
        mov     cl, 6
        shl     bx, cl
        pop     cx  ; y * 64
        add     di, bx  ; y * 320
        add     di, ax  ; + x
        mov     es, [fb_seg]
        mov     al, [bp + 4]
        mov     [es:di], al
PutPixel_out:
        pop     es
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     6

; data used by SetPalette
; ---- palette: 24 colours, 6 bits per channel (R, G, B)
palette_data    db      0,0,0,     23,37,63,  53,8,2,    63,46,28  ; black sky red skin
                db      28,14,2,   50,28,8,   63,50,6,   4,46,8  ; dkbrown brown gold green
                db      2,24,4,    63,63,63,  38,38,38,  6,14,56  ; dkgreen white grey blue
                db      46,26,10,  58,40,18,  63,60,10,  0,0,0  ; (spare) tan yellow outline
                db      36,12,48,  52,30,60,  63,38,4,   63,34,44  ; purple lilac orange pink
                db      6,44,48,   0,0,0,     0,0,0,     0,0,0  ; teal
