; ---------------------------------------------------------------------
;  Module 1 : named constants
; ---------------------------------------------------------------------
SCREEN_W        equ 320
SCREEN_H        equ 200
TILE            equ 16
MAP_W           equ 60  ; level width in tiles
MAP_H           equ 12  ; level height in tiles
MAP_SIZE        equ MAP_W*MAP_H  ; 720 bytes per map copy
WORLD_W         equ MAP_W*TILE  ; 960 pixels
CAM_MAX         equ WORLD_W-SCREEN_W  ; 640 = last camera position
CAM_FOLLOW      equ 160  ; screen x where the camera starts to follow
MARIO_MAX_X     equ WORLD_W-TILE  ; 944 = right end of the level
FB_PARAS        equ 0FA0h  ; 64000 bytes / 16 = frame buffer paragraphs
MAP_BOTTOM      equ MAP_H*TILE  ; 192 = pixel row where the map ends (pit)
START_X         equ 32
START_FEET_Y    equ 160
POLE_COL        equ 57  ; map column of the flag pole
CLOUD_COUNT     equ 9

; ---- palette indices (own palette, see SetPalette) ----
C_BLACK         equ 0
C_SKY           equ 1
C_RED           equ 2
C_SKIN          equ 3
C_DKBROWN       equ 4
C_BROWN         equ 5
C_GOLD          equ 6
C_GREEN         equ 7
C_DKGREEN       equ 8
C_WHITE         equ 9
C_GRAY          equ 10
C_BLUE          equ 11
C_GOOMBA        equ 12
C_TAN           equ 13
C_YELLOW        equ 14
C_OUTLINE       equ 15  ; solid black used inside sprites

; ---- scan codes (Appendix A.3) and debug keys ----
SC_ESC          equ 01h
SC_P            equ 19h
SC_ENTER        equ 1Ch
SC_SHIFT        equ 2Ah
SC_SPACE        equ 39h
SC_UP           equ 48h
SC_LEFT         equ 4Bh
SC_RIGHT        equ 4Dh
SC_DOWN         equ 50h
SC_F1           equ 3Bh  ; debug: time = 5 seconds
SC_F2           equ 3Ch  ; debug: coins = 99
SC_F3           equ 3Dh  ; debug: become Super Mario
SC_F4           equ 3Eh  ; debug: warp next to the stairs

; ---- game states (Section 5.12) ----
ST_TITLE        equ 0
ST_PLAYING      equ 1
ST_PAUSED       equ 2
ST_DYING        equ 3
ST_LIFELOST     equ 4
ST_WINSEQ       equ 5
ST_LEVELDONE    equ 6
ST_GAMEOVER     equ 7
ST_EXIT         equ 8

; ---- tile codes (Appendix A.2) ----
T_SKY           equ 0
T_GROUND        equ 1
T_BRICK         equ 2
T_QCOIN         equ 3
T_QMUSH         equ 4
T_EMPTY         equ 5
T_PIPE_TL       equ 6
T_PIPE_TR       equ 7
T_PIPE_BL       equ 8
T_PIPE_BR       equ 9
T_STAIR         equ 10
T_COIN          equ 11
T_POLE          equ 12

; ---- physics constants, 8.8 fixed point (Appendix A.5) ----
WALK_ACC        equ 0020h
BRAKE_ACC       equ 0040h  ; braking against the movement is faster
FRICTION        equ 0010h
WALK_MAX        equ 0180h
RUN_MAX         equ 0280h
GRAVITY         equ 0040h
JUMP_V          equ 0FA80h  ; -5.5
JUMP_CUT        equ 0FE00h  ; -2.0
MAX_FALL        equ 0400h
STOMP_BOUNCE    equ 0FD00h  ; -3.0
STOMP_BOUNCE_HI equ 0FB00h  ; -5.0 when Space is held
DEATH_HOP       equ 0FB20h  ; about -4.9  -> rises about 48 pixels
GOOMBA_EDGE_TURN equ 1
GOOMBA_SPEED    equ 0080h
KOOPA_SPEED     equ 00C0h
SHELL_SPEED     equ 0300h
MUSH_SPEED      equ 0100h

; ---- game limits (Appendix A.4) ----
START_LIVES     equ 3
MAX_LIVES       equ 99
LEVEL_TIME      equ 300
TICKS_PER_SEC   equ 30
INVULN_FRAMES   equ 60  ; 2 seconds
FLAT_FRAMES     equ 30  ; flat Goomba stays 1 second
KICK_GRACE      equ 8  ; shell ignores Mario for 8 frames
DYING_MIN       equ 30
LIFELOST_FRAMES equ 60
MAX_SCORE_HI    equ 000Fh  ; 999999 = 000F423Fh
MAX_SCORE_LO    equ 423Fh
TIMER_DIV       equ 39773  ; 1193182 / 39773 = 30 Hz

; ---- sprite flags ----
SPR_MIRROR      equ 1
SPR_BLINK       equ 2

; ---- entity records (enemies, shells, mushrooms): 12 bytes each ----
E_TYPE          equ 0  ; 0 free, 1 Goomba, 2 Koopa, 3 mushroom
E_STATE         equ 1  ; see ES_* below
E_X             equ 2  ; word, whole pixels (world)
E_Y             equ 4  ; word, top edge in pixels
E_XF            equ 6  ; byte, fraction of x
E_YF            equ 7  ; byte, fraction of y
E_DIR           equ 8  ; byte, 1 = right, 0FFh = left
E_TIMER         equ 9  ; byte, flat / kick-grace frames
E_VY            equ 10  ; word, 8.8 vertical speed
E_SIZE          equ 12
E_MAX           equ 10  ; 6 enemies + room for mushrooms

ET_NONE         equ 0
ET_GOOMBA       equ 1
ET_KOOPA        equ 2
ET_MUSH         equ 3

ES_WAIT         equ 0  ; stands still until close to the screen
ES_WALK         equ 1
ES_FLAT         equ 2  ; flattened Goomba
ES_SHELL        equ 3  ; stationary shell
ES_SLIDE        equ 4  ; sliding shell

FX_MAX          equ 4  ; coin pop effects: 6 bytes each
FX_SIZE         equ 6

; Note: a conditional jump can only reach 127 bytes, so a far target is
; reached with the opposite jump over a normal jmp (jne skip / jmp far / skip:)
