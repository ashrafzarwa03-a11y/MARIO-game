no_memory:
        mov     dx, msg_nomem
        mov     ah, 09h
        int     21h
        mov     ax, 4C01h
        int     21h
