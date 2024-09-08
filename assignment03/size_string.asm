.data
prompt:     .asciiz "Enter a string: "  # Prompt message
resultMsg:  .asciiz "\nThe size of the string is: "  # Message to display the length
buffer:     .space 100   # Buffer to store the input string, 100 bytes allocated for the user input

.text
.globl main
main:
    li $v0, 4                # Syscall for printing a string
    la $a0, prompt           # Load the address of the prompt message into $a0
    syscall                  # Print the prompt message


    li $v0, 8                # Syscall for reading a string
    la $a0, buffer           # Load the address of the buffer where the string will be stored
    li $a1, 100              # Specify the maximum length of the input (100 bytes)
    syscall                  # Perform the read syscall


    la $t0, buffer           # Load the address of the input string into $t0
    li $t1, -1               # Initialize the length counter to -1

count_loop:
    lb $t2, 0($t0)           # Load byte from the string into $t2
    beq $t2, $zero, print_result  # If null terminator is reached, exit the loop
    addi $t1, $t1, 1         # Increment the length counter
    addi $t0, $t0, 1         # Move to the next byte in the string
    j count_loop             # Repeat the loop

print_result:
    li $v0, 4                # Syscall for printing a string
    la $a0, resultMsg        # Load the address of the result message into $a0
    syscall                  # Print the result message

    li $v0, 1                # Syscall for printing an integer
    move $a0, $t1            # Move the length counter into $a0
    syscall                  # Print the integer


    li $v0, 10               # Syscall to terminate the program
    syscall
