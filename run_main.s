# Avraham Sikirov - 318731478
#****************************
#.include "/home/avi/Desktop/Computer structure/Targil3/func_select.s"
.section .rodata
format_d: .string "%d\n"
format_s:  .ascii "%s\0"
#format_print: .string "this is the string: %s\n"

.text
.global run_main
.type run_main, @function
run_main:
    movq    %rsp, %rbp      #for correct debugging
    # write your code here
    xorq    %rax, %rax
    pushq   %r12
    pushq   %r13
    pushq   %r14
    pushq   %r15
    pushq   %rbp
    
    xorq    %r12, %r12
    xorq    %r13, %r13
    xorq    %r14, %r14
    xorq    %r15, %r15
    
                            #scanf first argumant to r12 (n1)
    subq    $16, %rsp       # align rsp to 16 and making space for input.
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)     # convert to aschii
    movq    (%rsp), %r12
    #addq $1, %r12
    
    
                            #scanf second argumant to r13 (n1 string)
    subq    $256, %rsp      # making space for the string input.
    movq    $format_s, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    sub     $1, %rsp
    mov     %r12b, (%rsp)
    mov     %rsp, %r13      # R13 pointing to first Pstring. 
        
    subq    $15, %rsp       # align rsp to 16 before scanf

    
                            #scanf first argumant to r14 (n2)
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    #addq    $48, (%rsp)     # convert to aschii
    movq    (%rsp), %r14
    #addq $1, %r14
    
                            #scanf third argumant to r15 (n2 string)
    subq    $256, %rsp      # making space for the string input.
    movq    $format_s, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    sub     $1, %rsp
    mov     %r14b, (%rsp)
    mov     %rsp, %r15      #R15 pointing to first Pstring. 
    


    subq    $15, %rsp       #align rsp to 16 before scanf
    
                            #scanf fith argumant to rdi (func selection number)
    movq    $format_d, %rdi
    movq    $0, %rax
    movq    %rsp, %rsi
    call    scanf
    xorq    %rdi, %rdi      # zero rdi.    
    movb    (%rsp), %dil    #assigning the user input for function select to 1nd argument.
    
    movq    %r13, %rsi      #assigning the first Pstring pointer to 2nd argument.
    movq    %r15, %rdx      #assigning the second Pstring pointer to 3nd argument.
    
           
    #movq $format_print, %rdi
    #xorq %rsi, %rsi
    #leaq 1(%r13), %rsi
    #movq $0, %rax
    #call printf   
    
    call    run_func
    movq    %rbp, %rsp     #back up everting (callee saved)
    subq    $32, %rsp
    pop     %r15
    pop     %r14
    pop     %r13
    pop     %r12      
    movq    %rbp, %rsp
    ret