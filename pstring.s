# Avraham Sikirov - 318731478
#****************************
.section .rodata
format_d: .string "%d\n"
format_s:  .ascii "%s\0"
format_print_invalid: .string "invalid input!\n"
format_print: .string "%s\n"

.text
.global pstrlen
.type pstrlen, @function
pstrlen:
    xorq    %rax, %rax
    movb    (%rdi), %al 
    ret
        
.global replaceChar
.type replaceChar, @function
replaceChar:
    pushq   %rdi
    xorq    %rcx, %rcx
    movb    (%rdi), %cl
    addq    $1, %rdi
    #sub     $48, %cl               # convert char to dec.
    leaq    (%rcx,%rdi), %rcx      # assgning last place in the array. 
.L0:         # while(not in the end of the array)
    cmpb    (%rdi), %sil
    jne .L2
    movb    %dl, (%rdi)
.L2:         #else
    addq    $1, %rdi               # forward rdi.
    cmp     %rcx, %rdi             # check if we are in the end of the array.
    jl .L0
.L1:        #after while
    popq    %rdi
    movq    %rdi, %rax
    ret   


.global pstrijcpy
.type pstrijcpy, @function
pstrijcpy:
    pushq   %rdi
    pushq   %rsi
    
    cmpb    $0, %dl               #if (i < 0) - invalid
    jl .L4
    cmpb    %dl, %cl               #if (i > j) - invalid
    jb .L4
    cmpb    (%rdi), %dl            #if (i > pstring.len) - invalid
    ja .L4
    je .L4
    cmpb    (%rsi), %cl            #if (j > pstring.len) - invalid.
    ja .L4
    je .L4
    

    leaq    1(%rdx,%rdi), %rdi   #forword first-pstring to i
    leaq    1(%rdx, %rsi), %rsi  #forword second-pstring to i

.L5:        # start of do while.
    xorq    %r8, %r8
    movb    (%rsi), %r8b
    movb    %r8b, (%rdi)
    addq    $1, %rdi               # forword first pstring
    addq    $1, %rsi               # forword second pstring
    addq    $1, %rdx               # i++
    cmpb    %cl, %dl               # if i > j break; 
    jle .L5
    jmp .L3
          
.L4:                 #if wrong input
    movq    $format_print_invalid, %rdi
    movq    $0, %rax
    call    printf
.L3: 
    popq    %rsi
    popq    %rdi
    movq    %rdi, %rax
    ret

.global swapCase
.type swapCase, @function
swapCase:
    pushq   %rdi
    pushq   %r15
    xorq    %rcx, %rcx
    movb    (%rdi), %cl
    addq    $1, %rdi
    #sub     $48, %cl             # convert char to dec.
    leaq    (%rcx,%rdi), %rcx    # assgning last place in the array. 
.L6:                             # while(not in the end of the array)
    xorq    %r15, %r15
    movb    (%rdi), %r15b
    cmpb    $122, (%rdi)         # if psring[i] > 122 continue.
    jg .L7
    cmpb    $97, (%rdi)          # if psring[i] >= 97 - lower case.
    jge .L9
    cmpb    $90, (%rdi)          # if psring[i] > 90 continue.
    jg .L7
    cmpb    $65, (%rdi)          # if psring[i] < 65 continue.
    jl .L7
    cmpb    $90, (%rdi)          # if psring[i] <= 90 - big case.
    jle .L10


.L9:        #if lower case
    subb    $32, (%rdi) 
    jmp .L7
    
.L10:       #if big case
    addb    $32, (%rdi) 
    jmp .L7


.L7:        #else
    addq    $1, %rdi             # forward rdi.
    cmp     %rcx, %rdi           # check if we are in the end of the array.
    jl .L6
.L8:        #after while
    popq    %r15
    popq    %rdi
    movq    %rdi, %rax
    ret   



.global pstrijcmp
.type pstrijcmp, @function
pstrijcmp:
    pushq   %rdi
    pushq   %rsi
    xorq    %rax, %rax
    
    cmpb    $0, %dl            #if (i < 0) - invalid
    jl .L11
    cmpb    %dl, %cl            #if (i > j) - invalid
    jl .L11
    cmpb    (%rdi), %dl         #if (i > pstring.len) - invalid
    ja .L11
    je .L11
    cmpb    (%rsi), %cl         #if (j > pstring.len) - invalid.
    ja .L11
    je .L11
    
    
    leaq    1(%rdx,%rdi), %rdi   #forword first-pstring to i
    leaq    1(%rdx, %rsi), %rsi  #forword second-pstring to i

.L13:       # start of do while.
    xorq    %r8, %r8
    movb    (%rsi), %r8b
    cmpb    (%rdi), %r8b
    jl .L14                   # if pstr1 > pstr2
    jg .L15                   # if pstr1 < pstr2
    addq    $1, %rdi          # forword first pstring
    addq    $1, %rsi          # forword second pstring
    addq    $1, %rdx          # i++
    cmpb    %cl, %dl          # if i > j break; 
    jle .L13
    jmp .L12
.L14:       # if pstr1 > pstr2
    popq    %rsi
    popq    %rdi
    movq    $1, %rax
    ret
.L15:       # if pstr1 < pstr2
    popq    %rsi
    popq    %rdi
    movq    $-1, %rax
    ret
          
.L11:       # if wrong input
    movq    $format_print_invalid, %rdi
    movq    $0, %rax
    call    printf
    movq    $-2, %rax
    popq    %rsi
    popq    %rdi
    ret
.L12: 
    popq    %rsi
    popq    %rdi
    movq    $0, %rax
    ret