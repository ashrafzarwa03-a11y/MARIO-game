; =====================================================================
;  PROGRAM ENTRY
; =====================================================================
main:
        cld
; ---- Module 5: release spare memory, then allocate the frame buffer
        mov     bx, 1000h  ; keep exactly 64 KB for the program
        mov     ah, 4Ah  ; DOS: resize memory block (ES = PSP)
        int     21h
        jnc     skip1
        jmp     no_memory
skip1:
        mov     bx, FB_PARAS  ; 64000 bytes in paragraphs
        mov     ah, 48h  ; DOS: allocate memory block
        int     21h
        jnc     skip2
        jmp     no_memory
skip2:
        mov     [fb_seg], ax  ; segment of the off-screen frame buffer

        call    BuildMap  ; ASCII level -> tile codes (original copy)
        call    BuildSprites  ; ASCII sprites -> palette indices
        mov     ax, 0013h  ; Module 2: VGA mode 13h (320x200x256)
        int     10h
        call    SetPalette
        call    InstallHandlers  ; keyboard + timer interrupts

        mov     byte [menu_sel], 0
        mov     ax, ST_TITLE
        push    ax
        call    SetState

main_frame_loop:  ; ---- one iteration = one timer tick
        call    WaitTick
        cmp     byte [state], ST_TITLE
        je      run_0
        cmp     byte [state], ST_PLAYING
        je      run_1
        cmp     byte [state], ST_PAUSED
        je      run_2
        cmp     byte [state], ST_DYING
        je      run_3
        cmp     byte [state], ST_LIFELOST
        je      run_4
        cmp     byte [state], ST_WINSEQ
        je      run_5
        cmp     byte [state], ST_LEVELDONE
        je      run_6
        cmp     byte [state], ST_GAMEOVER
        je      run_7
        jmp     run_done
run_0:
        call    StateTitle
        jmp     run_done
run_1:
        call    StatePlaying
        jmp     run_done
run_2:
        call    StatePaused
        jmp     run_done
run_3:
        call    StateDying
        jmp     run_done
run_4:
        call    StateLifeLost
        jmp     run_done
run_5:
        call    StateWinSeq
        jmp     run_done
run_6:
        call    StateLevelDone
        jmp     run_done
run_7:
        call    StateGameOver
        jmp     run_done
run_done:
        cmp     byte [state], ST_EXIT
        je      skip3
        jmp     main_frame_loop
skip3:
