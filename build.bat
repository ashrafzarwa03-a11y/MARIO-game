@echo off
nasm -f bin mario.asm -o MARIO.COM
if errorlevel 1 (echo BUILD FAILED) else (echo Built MARIO.COM)
