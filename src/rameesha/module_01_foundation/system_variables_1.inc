; ---- system: timer, vectors, frame buffer
tick            dw      0  ; incremented by TimerISR (30 per second)
last_tick       dw      0
bios_acc        dw      0  ; decides when the BIOS timer handler is chained
frame_ticks     dw      1  ; ticks since the previous frame
frame_no        dw      0  ; frame counter (animation, blinking)
old_int08       dd      0
