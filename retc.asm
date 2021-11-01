; Macro retc
; compilador online utilizado: https://www.tutorialspoint.com/compile_assembly_online.php

%macro retc 1
    j%+1 %%skip
    ret
%%skip:
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, keypos
    int 80h
    
%endmacro

SECTION .text
    GLOBAL _start
    
_start:
    retc d
    
    mov eax,1
    mov edi,0
    int 80h
    
SECTION .DATA
    hello: db 'Hello world', 10
    keypos: equ $-hello