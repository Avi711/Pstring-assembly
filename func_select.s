# Avraham Sikirov - 318731478
#****************************
#.include "/home/avi/Desktop/Computer structure/Targil3/pstring.s"
.section .rodata
format_print50: .string "first pstring length: %d, second pstring length: %d\n"
format_print52: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
format_print53: .string "length: %d, string: %s\n"
format_print54: .string "length: %d, string: %s\n"
format_print55: .string "compare result: %d\n"
format_printDEF: .string "invalid option!\n"
#format_print_invalid: .string "invalid input!\n"
format_c: .string "%c\n"
format_d: .string "%d\n"


#format_s:  .ascii "%s\0"
#format_print: .string "this is the string: %s\n"

.align 8 # Aliggn adress to multiple of 8

.LTABLE:
    .quad .L50 #Case 50
    .quad .LDEF #case 51
    .quad .L52 #Case 52
    .quad .L53 #Case 53
    .quad .L54 #Case 54
    .quad .L55 #Case 55
    .quad .LDEF #Case 56
    .quad .LDEF #Case 57
    .quad .LDEF #Case 58
    .quad .LDEF #Case 59
    .quad .L50 #Case 60
    
.text
.global run_func
.type run_func, @function
run_func:
    pushq   %rbp
    movq    %rsp, %rbp      #for correct debugging
    movq    %rsp, %rbp      #for correct debugging
    pushq   %r15
    pushq   %r14
    pushq   %r13
    pushq   %r12
    xorq    %r12, %r12
    xorq    %r13, %r13
    xorq    %r13, %r13
    xorq    %r13, %r13
    xorq    %r13, %r13
    xorq    %rax, %rax
    #movq $55, %rdi
    leaq    -50(%rdi), %r8
    cmpq    $10, %r8        #check if input > 60
    ja .LDEF                #jump to defult.
    jmp *.LTABLE (,%r8,8)
    
.LEND:
    movq    %rbp, %rsp      # move rsp to the correct location to pop. 
    subq    $32, %rsp       # move rsp to the correct location to pop. 
    popq    %r12
    popq    %r13
    popq    %r14
    popq    %r15
    movq    %rbp, %rsp
    popq    %rbp
    ret
    

# Case 50, 60
.L50:
    movq    %rsi, %rdi
    call    pstrlen
    movq    %rax, %r14      # save first pstring length on r14
    #subq    $48, %r14       # convert to int (aschii)
    movq    %rdx, %rdi
    call    pstrlen
    movq    %rax, %r15      # save second pstring length on r15
    #subq    $48, %r15       # convert to int (aschii)
    movq    $format_print50, %rdi
    movq    %r15, %rdx       
    movq    %r14, %rsi
    movq    $0, %rax
    call    printf 
    jmp .LEND


# Case 52
.L52:
    subq    $16, %rsp              # align for scanf.
    movq    %rsi, %r14             # save first pstring on r14
    movq    %rdx, %r15             # save second pstring on r15
    movq    $format_c, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    movb    (%rsp), %r13b          # old char in r13
    subq    $16, %rsp              # align for scanf.
    movq    $format_c, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    movb    (%rsp), %r12b          # new char in r12

    movq    %r14, %rdi             # Preparations for the call to "replaceChar"
    movq    %r13, %rsi
    movq    %r12, %rdx   
    call    replaceChar
    movq    %rax, %r14             # first pstring in r14 
    
    movq    %r15, %rdi             # Preparations for the call to "replaceChar"
    movq    %r13, %rsi
    movq    %r12, %rdx   
    call    replaceChar
    movq    %rax, %r15             # second pstring in r15
    
    movq    $format_print52, %rdi  # Preparations for the call to "printf"
    movq    %r13, %rsi
    movq    %r12, %rdx
    leaq    1(%r14), %rcx
    leaq    1(%r15), %r8
    movq    $0, %rax
    call    printf
    
    jmp .LEND


# Case 53
.L53:
    subq    $16, %rsp              # align for scanf.
    movq    %rsi, %r14             # save first pstring on r14
    movq    %rdx, %r15             # save second pstring on r15
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)            # convert to aschii
    xorq    %r13, %r13
    movb    (%rsp), %r13b          # i in r13
    subq    $16, %rsp              # align for scanf.
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)            # convert to aschii
    xorq    %r12, %r12
    movb    (%rsp), %r12b          # j in r12


    movq    %r14, %rdi             # Preparations for the call to "pstrijcpy"
    movq    %r15, %rsi
    movq    %r13, %rdx
    movq    %r12, %rcx
    call    pstrijcpy
    
    
    movq    $format_print53, %rdi  # Preparations for the call to "printf"
    xorq    %rsi, %rsi
    movb    (%rax), %sil
    #subb    $48, %sil
    leaq    1(%rax), %rdx
    movq    $0, %rax
    call    printf 
    
    movq    $format_print53, %rdi  # Preparations for the call to "printf"
    xorq    %rsi, %rsi
    movb    (%r15), %sil
    #subb    $48, %sil
    leaq    1(%r15), %rdx
    movq    $0, %rax
    call    printf    
    jmp     .LEND

# Case 54
.L54:
    movq    %rsi, %r14             # save first pstring on r14
    movq    %rdx, %r15             # save second pstring on r15
    
    movq    %r14, %rdi
    call    swapCase               # Preparations for the call to "swapCase"
    movq    %rax, %r14
    movq    $format_print54, %rdi  # Preparations for the call to "printf"
    xorq    %rsi, %rsi
    movb    (%r14), %sil
    #subb    $48, %sil
    leaq    1(%r14), %rdx
    call    printf

    
    movq    %r15, %rdi             # Preparations for the call to "pstrijcmp"
    call    swapCase
    movq    %rax, %r15    
    movq    $format_print54, %rdi  # Preparations for the call to "printf"
    xorq    %rsi, %rsi
    movb    (%r15), %sil
    #subb    $48, %sil
    leaq    1(%r15), %rdx
    call    printf
    

    jmp .LEND
# Case 55
.L55:
    subq    $16, %rsp        # align for scanf.
    movq    %rsi, %r14       # save first pstring on r14
    movq    %rdx, %r15       # save second pstring on r15
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)      # convert to aschii
    movb    (%rsp), %r13b    # i in r13
    subq    $16, %rsp        # align for scanf.
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)      # convert to aschii
    movb    (%rsp), %r12b    # j in r12


    movq    %r14, %rdi       # Preparations for the call to "pstrijcmp"
    movq    %r15, %rsi
    movq    %r13, %rdx
    movq    %r12, %rcx
    call    pstrijcmp
    
    movq    $format_print55, %rdi
    movq    %rax, %rsi
    call    printf

    jmp .LEND

# Defult
.LDEF:
    movq    $format_printDEF, %rdi
    call    printf
    jmp     .LEND