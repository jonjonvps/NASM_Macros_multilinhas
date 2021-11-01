; Implementacao da concatenacao do de duas macros.
; compilador online utilizado: https://www.tutorialspoint.com/compile_assembly_online.php

%macro keytab_entry 2
    mov eax,4
    mov ebx,1
    mov ecx,%1
    mov edx,%2     
    int 80h                    
%endmacro

%macro loop 2
    mov esi, %1
    loop:
        cmp esi,%2
        je END
        keytab_entry hello, keypos
        add esi,1
        jnz loop
        END:
%endmacro

SECTION .TEXT
    GLOBAL _start
    
_start:
    loop 0,10
    
    mov eax,1
    mov edi,0
    int 80h
    
SECTION .DATA
    hello: db 'Hello world', 10
    keypos: equ $-hello