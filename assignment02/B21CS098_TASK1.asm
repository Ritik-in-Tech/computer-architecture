.data
prompt_choice: .asciiz "Choose an operation:\n1. Add\n2. Subtract\n3. Multiply\n4. Custom\n"
prompt_op: .asciiz "Enter the operation (+, -, *): "
prompt_num1: .asciiz "Enter the first number: "
prompt_num2: .asciiz "Enter the second number: "
result: .asciiz "Result: "
newline: .asciiz "\n"


.text
.globl main

main:
    # Display the menu
    li $v0, 4
    la $a0, prompt_choice
    syscall
    
    # Read user's choice
    li $v0, 5
    syscall
    move $t4, $v0  # Save user's choice in $t4
    
    # Check the user's choice and jump to the corresponding code block
    li $t5, 1
    beq $t4, $t5, add_operation
    
    li $t5, 2
    beq $t4, $t5, subtract_operation
    
    li $t5, 3
    beq $t4, $t5, multiply_operation
    
    li $t5, 4
    beq $t4, $t5, custom_operation
    
    # If an invalid choice, exit
    j exit

add_operation:
    li $t0, 5       # Load immediate value 5 into $t0
    li $t1, 3       # Load immediate value 3 into $t1
    add $t2, $t0, $t1   # $t2 = $t0 + $t1
    j print_result

subtract_operation:
    li $t0, 5       # Load immediate value 5 into $t0
    li $t1, 3       # Load immediate value 3 into $t1
    sub $t2, $t0, $t1   # $t2 = $t0 - $t1
    j print_result

multiply_operation:
    li $t0, 5       # Load immediate value 5 into $t0
    li $t1, 3       # Load immediate value 3 into $t1
    mul $t2, $t0, $t1   # $t2 = $t0 * $t1
    j print_result

custom_operation:
    # Display the prompt to enter the operation
    li $v0, 4
    la $a0, prompt_op
    syscall
    
    # Read the operation
    li $v0, 12
    syscall
    move $t3, $v0
    
    li $v0, 4
    la $a0, newline
    syscall
    
    # Read the first number
    li $v0, 4
    la $a0, prompt_num1
    syscall
    
    li $v0, 5
    syscall
    move $t0, $v0
    
    # Read the second number
    li $v0, 4
    la $a0, prompt_num2
    syscall
    
    li $v0, 5
    syscall
    move $t1, $v0
    
    # Perform the operation based on user's input
    beq $t3, '+', add_op
    beq $t3, '-', sub_op
    beq $t3, '*', mul_op
    j exit
    
add_op:
    add $t2, $t0, $t1
    j print_result
    
sub_op:
    sub $t2, $t0, $t1
    j print_result
    
mul_op:
    mul $t2, $t0, $t1
    j print_result
    
print_result:
    li $v0, 4
    la $a0, result
    syscall
    
    li $v0, 1
    move $a0, $t2
    syscall
    
exit:
    li $v0, 10
    syscall
