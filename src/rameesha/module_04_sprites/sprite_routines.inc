; =====================================================================
;  Module 4 : sprites
; =====================================================================

; ---------------------------------------------------------------------
;  BuildSprites
;  Purpose : the sprite artwork is typed as ASCII pictures.  Convert every
;            character to its palette index once at start-up (in place).
;  Inputs/Outputs : none          Changes : none
; ---------------------------------------------------------------------
BuildSprites:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     si, sprite_data
        mov     di, sprite_data
        mov     cx, SPRITE_BYTES
BuildSprites_next:
        lodsb  ; AL = picture character
        push    cx
        push    di
        mov     di, spr_chars  ; search it in the character list
        mov     cx, SPR_CHARS_LEN
        repne   scasb
        mov     bx, SPR_CHARS_LEN - 1
        sub     bx, cx  ; BX = index of the character
        pop     di
        pop     cx
        mov     al, [spr_cols + bx]  ; palette colour of that character
        stosb
        loop    BuildSprites_next
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; ---------------------------------------------------------------------
;  DrawSprite(x, y, address, flags)
;  Purpose : draw a 16x16 sprite into the frame buffer.  Colour 0 is
;            transparent.  Clips at all four screen edges.
;  Inputs  : [bp+10]=x (signed) [bp+8]=y (signed) [bp+6]=sprite address
;            [bp+4]=flags: bit0 mirror left/right, bit1 blink (every
;            second pixel is skipped = half transparent)
;  Changes : none
; ---------------------------------------------------------------------
DrawSprite:
        push    bp
        mov     bp, sp
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    es
        sub     sp, 4  ; locals: [bp-20] rows left, [bp-22] row base
        mov     es, [fb_seg]
        mov     si, [bp + 6]
        mov     dx, [bp + 8]
        mov     word [bp - 16], 16
DrawSprite_row:
        cmp     dx, SCREEN_H  ; unsigned: also catches negative y
        jb      skip4
        jmp     DrawSprite_skip_row
skip4:
        mov     di, dx  ; row base = y*320
        push    cx
        mov     cl, 8
        shl     di, cl
        pop     cx
        mov     bx, dx
        push    cx
        mov     cl, 6
        shl     bx, cl
        pop     cx
        add     di, bx
        mov     [bp - 18], di
        mov     cx, 16  ; CX counts 16..1 along the row
DrawSprite_col:
        lodsb
        test    al, al
        jz      DrawSprite_next_px
        mov     bx, [bp + 10]
        test    byte [bp + 4], SPR_MIRROR
        jnz     DrawSprite_mirror
        add     bx, 16  ; normal:  px = x + (16 - CX)
        sub     bx, cx
        jmp     DrawSprite_have_x
DrawSprite_mirror:
        add     bx, cx  ; mirrored: px = x + CX - 1
        dec     bx
DrawSprite_have_x:
        cmp     bx, SCREEN_W
        jae     DrawSprite_next_px
        test    byte [bp + 4], SPR_BLINK
        jz      DrawSprite_plot
        mov     ah, bl  ; checkerboard: skip when (px+py) is odd
        add     ah, dl
        test    ah, 1
        jnz     DrawSprite_next_px
DrawSprite_plot:
        mov     di, [bp - 18]
        add     di, bx
        mov     [es:di], al
DrawSprite_next_px:
        loop    DrawSprite_col
        jmp     DrawSprite_row_done
DrawSprite_skip_row:
        add     si, 16  ; skip the 16 source bytes of this row
DrawSprite_row_done:
        inc     dx
        dec     word [bp - 16]
        jz      skip5
        jmp     DrawSprite_row
skip5:
        add     sp, 4
        pop     es
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        pop     bp
        ret     8
