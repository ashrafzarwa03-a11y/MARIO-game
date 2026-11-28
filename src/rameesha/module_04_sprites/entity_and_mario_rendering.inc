; ---------------------------------------------------------------------
;  DrawEntities
;  Purpose : enemies, shells, mushrooms and coin pops, minus the camera
;            (only when on screen: -16 < screen_x < 320)
;  Changes : none
; ---------------------------------------------------------------------
DrawEntities:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     si, enemy_tbl
        mov     cx, E_MAX
DrawEntities_entity:
        cmp     byte [si + E_TYPE], ET_NONE
        jne     skip34
        jmp     DrawEntities_next
skip34:
        cmp     byte [si + E_STATE], ES_WAIT
        jne     skip35
        jmp     DrawEntities_next
skip35:
        mov     di, [si + E_X]
        sub     di, [camera]  ; DI = screen x
        cmp     di, -16
        jg      skip36
        jmp     DrawEntities_next
skip36:
        cmp     di, SCREEN_W
        jge     DrawEntities_next
        xor     dx, dx  ; DX = sprite flags
        mov     bx, spr_goomba
        mov     al, [si + E_TYPE]
        cmp     al, ET_GOOMBA
        je      DrawEntities_goomba
        cmp     al, ET_KOOPA
        je      DrawEntities_koopa
        mov     bx, spr_mushroom
        jmp     DrawEntities_draw
DrawEntities_goomba:
        cmp     byte [si + E_STATE], ES_FLAT
        jne     DrawEntities_goomba_walk
        mov     bx, spr_goomba_flat
        jmp     DrawEntities_draw
DrawEntities_goomba_walk:
        test    word [frame_no], 8  ; walking animation: swap feet every 8 frames
        jz      DrawEntities_draw
        mov     dx, SPR_MIRROR
        jmp     DrawEntities_draw
DrawEntities_koopa:
        mov     bx, spr_shell
        cmp     byte [si + E_STATE], ES_WALK
        jne     DrawEntities_draw
        mov     bx, spr_koopa
        test    byte [si + E_DIR], 80h  ; the Koopa picture looks left
        jnz     DrawEntities_draw
        mov     dx, SPR_MIRROR
DrawEntities_draw:
        push    di
        push    word [si + E_Y]
        push    bx
        push    dx
        call    DrawSprite
DrawEntities_next:
        add     si, E_SIZE
        dec     cx
        jz      DrawEntities_fx
        jmp     DrawEntities_entity
DrawEntities_fx:
        mov     si, fx_tbl
        mov     cx, FX_MAX
DrawEntities_fx_loop:
        cmp     word [si], 0
        je      DrawEntities_fx_next
        mov     ax, [si + 2]
        sub     ax, [camera]
        push    ax
        push    word [si + 4]
        mov     ax, spr_coin
        push    ax
        mov     ax, 0
        push    ax
        call    DrawSprite
DrawEntities_fx_next:
        add     si, FX_SIZE
        loop    DrawEntities_fx_loop
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; ---------------------------------------------------------------------
;  DrawMario
;  Purpose : draw Small (16x16) or Super (16x32) Mario with the right
;            pose, facing, and blinking while invulnerable
;  Changes : none
; ---------------------------------------------------------------------
DrawMario:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        cmp     byte [mario_hidden], 0
        je      skip37
        jmp     DrawMario_out
skip37:
        cmp     word [invuln], 0  ; blink: draw only on alternate frames
        je      DrawMario_visible
        test    word [frame_no], 1
        jz      skip38
        jmp     DrawMario_out
skip38:
DrawMario_visible:
        mov     ax, [mx]
        sub     ax, [camera]  ; screen x
        mov     di, ax
        xor     bx, bx  ; BX = pose: 0 stand, 1 run, 2 jump
        cmp     byte [on_ground], 0
        jne     DrawMario_on_ground
        mov     bx, 2
        jmp     DrawMario_pose_done
DrawMario_on_ground:
        cmp     word [vx], 0
        je      DrawMario_pose_done
        test    byte [anim], 4  ; swap run / stand pictures
        jz      DrawMario_pose_done
        mov     bx, 1
DrawMario_pose_done:
        shl     bx, 1  ; word table index
        xor     dx, dx
        cmp     byte [face], 0
        je      DrawMario_flags_ok
        mov     dx, SPR_MIRROR
DrawMario_flags_ok:
        cmp     byte [form], 0
        jne     DrawMario_super
        push    di
        mov     ax, [my]
        sub     ax, 16
        push    ax
        push    word [small_pose + bx]
        push    dx
        call    DrawSprite
        jmp     DrawMario_out
DrawMario_super:
        push    di  ; upper half
        mov     ax, [my]
        sub     ax, 32
        push    ax
        mov     ax, spr_super_top
        push    ax
        push    dx
        call    DrawSprite
        push    di  ; lower half (legs depend on the pose)
        mov     ax, [my]
        sub     ax, 16
        push    ax
        push    word [super_pose + bx]
        push    dx
        call    DrawSprite
DrawMario_out:
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
