; ---- game
state           db      ST_TITLE
state_timer     dw      0
menu_sel        db      0  ; 0 = START GAME, 1 = EXIT
win_phase       db      0
mario_hidden    db      0
arg_temp        dw      0
zero_word       dw      0
score_lo        dw      0  ; 32-bit score (two words)
score_hi        dw      0
coins           dw      0
lives           dw      START_LIVES
time_left       dw      LEVEL_TIME
clock_acc       dw      0  ; ticks collected towards the next second
camera          dw      0  ; world x of the left edge of the screen
flag_y          dw      40  ; y of the flag on the pole
level_bonus     dw      0

; ---- hero (Mario): positions are 16.8 fixed point (word + fraction byte),
;      speeds are 8.8 fixed point
mx              dw      0  ; world x of the sprite's left edge
mxf             db      0
my              dw      0  ; world y of the FEET (bottom edge)
myf             db      0
vx              dw      0
vy              dw      0
on_ground       db      0
face            db      0  ; 0 = right, 1 = left
form            db      0  ; 0 = Small, 1 = Super
hp              db      1  ; health 1 or 2
hero_h          dw      16  ; hitbox height: 16 or 32
invuln          dw      0  ; frames of invulnerability left
stomp_chain     db      0
anim            db      0
jump_ready      db      1
prev_feet       dw      0
mr_x            dw      0  ; Mario's hitbox for entity tests
mr_y            dw      0
dm_col0         dw      0  ; DrawMap scratch
dm_xoff         dw      0
