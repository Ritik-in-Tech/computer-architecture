.data
    prompt: .asciiz "Enter n to calculate the nth Catalan number: "
    result: .asciiz "The nth Catalan number is: "
    newline: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a0, $v0  


    jal catalan

    move $t0, $v0   
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall

catalan:
    slti $t0, $a0, 2
    beqz $t0, recursive
    li $v0, 1
    jr $ra

recursive:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)

    addi $a0, $a0, -1
    jal catalan

    lw $a0, 0($sp)
    sw $v0, 0($sp)

    sll $t0, $a0, 1    
    addi $t0, $t0, -1   
    sll $t0, $t0, 1   

 
    lw $v0, 0($sp)
    mult $v0, $t0
    mflo $v0

    
    addi $t1, $a0, 1   
    div $v0, $t1
    mflo $v0

   
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
