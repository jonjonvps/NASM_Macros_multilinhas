;------------------------------------------
; Teste Prologue1, silly e Prologue 0
; nasm -felf64 prologue1.asm
; gcc -g -no-pie -o prologue1.o prologue1
; ./prologue1

; Comentar a funcao dependendo da utilizacao da macro.

%macro prologue 1
    push rbp                ; Base pointer
    mov rbp, rsp            ; Stack pointer recebe o mesmo valor do base pointer
    sub rsp, %1             ; Liberacao de um espaco de um frame
%endmacro

%macro prologue 0
    push rbp
    mov rbp, rsp
%endmacro

%macro silly 2
    %2: db %1, 10
%endmacro

%macro push 2
    push %1
    push %2
%endmacro

%macro multipush 1-*       ; numero infinito de parametro
    %rep %0                ; retorna o numero de parametros de 1-*, para interar no laço rep 
        push %1             
        %rotate 1          ; gira para a esquerda, pois a expre aritmetrica eh positiva, 
    %endrep                ; primeiro parametro torna o ultimo
%endmacro

%macro multipop 1-*
    %rep %0
        %rotate -1         ; gira para a direita, pois a expre aritmetrica eh negativa,
            pop %1         ; o ultimo parametro torna o primeiro
    %endrep
%endmacro

section .data
    silly   "Hello SB", hello 
    lensilly:  equ $-hello

    str: db "Hello World",10
    lenstr:  equ $-str

section .text
    global main

main:
    ;push hello, str
    multipush hello, str

    prologue 8
    ; push rbp
    ; mov rbp, rsp
    ; sub rsp, 8
    mov rbx,[rsp+24]        ; Acesso a hello utilizando o stack pointer como referencia
    mov rax,1               ; chamda de sistema para write
    mov rdi,1               ; Std out
    mov rsi,rbx             ; passando a string para o output
    mov rdx,lensilly        ; passando a qntd de bytes para o output
    syscall                 ; chamada de sistema
    mov rsp,rbp             ; fechar o acesso a pilha
    multipop rbp
    ;pop rbp

    ; prologue
    ; ; push rbp
    ; ; mov rbp, rsp
    ; mov rbx,[rbp+8]         ; Acesso a str utilizando o base pointer como refercia
    ; mov rax,1
    ; mov rdi,1
    ; mov rsi,rbx
    ; mov rdx,lenstr
    ; syscall
    ; mov rsp,rbp
    ; pop rbp
    
    mov rax,60
    mov rdi,0
    syscall