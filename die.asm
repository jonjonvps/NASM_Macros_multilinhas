; Macro com passagem de parametro default
; compilador online utilizado: https://www.tutorialspoint.com/compile_assembly_online.php

%macro die 0-1 hello2
    mov eax,4
    mov ebx,1
    mov ecx,%1
    mov edx,keypos
    int 0x80
%endmacro

SECTION .TEXT
    GLOBAL _start
    
_start:
    ;die hello               ; chamada com parametro
    ; mov eax,4
    ; mov ebx,1
    ; mov ecx,hello
    ; mov edx,keypos    
    ; int 0x80
    die                    ; chamada com parametro padrao
    ; mov eax,4
    ; mov ebx,1
    ; mov ecx,hello2
    ; mov edx,keypos    
    ; int 0x80 
    
    mov eax,1 
    mov edi,0
    int 0x80
    
SECTION .DATA
    hello: db 'Hello World', 10
    keypos: equ $-hello
    hello2: db 'Hello SB',10