; -----------------------------------------------------------------------------
; nasm -felf64 echo.asm
; nasm -felf echo.asm
; ./a.out oi oi oi
; -----------------------------------------------------------------------------

        global  main
        extern  puts
        section .text

        %macro multipush 1-*       ; numero infinito de parametro
            %rep %0                ; retorna o numero de parametros de 1-*, para interar no laço rep 
                push %1             
                %rotate 1          ; gira para a esquerda, pois a expre aratmetrica eh positiva, 
            %endrep                ; primeiro parametro torna o ultimo
        %endmacro

        %macro multipop 1-*
            %rep %0
                %rotate -1         ; gira para a direita, pois a expre aratmetrica eh negativa,
                    pop %1         ; o ultimo parametro torna o primeiro
            %endrep
        %endmacro



main:
        ;push    rdi                    ; salva o registrador que o usuario coloca
        ;push    rsi    
       
        multipush rdi, rsi

        sub     rsp, 8                  ; alinha a pilha antes da chamada 

        mov     rdi, [rsi]              ; string do argumento a ser exibida
        call    puts                    ; printa

        add     rsp, 8                  ; restaurar %rsp para o valor pré-alinhado
        
        
        ;pop     rsi                     ; restaura os registradores
        ;pop     rdi

        multipop rdi, rsi

        add     rsi, 8                  ; aponta para o próximo argumento
        dec     rdi                     ; decrescenta
        jnz     main                    ; se nao terminou continua
        ret