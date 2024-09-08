.data
prompt:     .asciiz "Enter a string: "     # Prompt to ask user for input
palindrome: .asciiz "P\n"                  # Message for Palindrome
notpalindrome: .asciiz "NP\n"             # Message for Not a Palindrome
buffer:     .space 100                     # Buffer to store input string, 100 bytes allocated

.text
.globl main
main:
    li $v0, 4                              # Syscall to print string
    la $a0, prompt                         # Load the address of the prompt message
    syscall                                # Print the prompt message
    
    
    li $v0, 8                              # Syscall to read a string
    la $a0, buffer                         # Load the address of the buffer
    li $a1, 100                            # Maximum length of the input (100 bytes)
    syscall                                # Perform the read syscall


    la $t0, buffer                         # Load the address of the input string into $t0
    li $t1, -1                              # Initialize the length counter

find_length:
    lb $t2, 0($t0)                         # Load byte from the string into $t2
    beq $t2, $zero, check_palindrome        # If null terminator is reached, go to palindrome check
    addi $t1, $t1, 1                       # Increment length counter
    addi $t0, $t0, 1                       # Move to the next byte in the string
    j find_length                          # Repeat loop

check_palindrome:
    la $t0, buffer                         # Set $t0 to the start of the string
    la $t3, buffer                         # Load the address of the string into $t3 (will store it if palindrome)
    add $t2, $t0, $t1                      # Set $t2 to the end of the string (past null terminator)
    sub $t2, $t2, 1                        # Adjust $t2 to point to the last character of the string

check_loop:
    lb $t4, 0($t0)                         # Load the byte at the start of the string into $t4
    lb $t5, 0($t2)                         # Load the byte at the end of the string into $t5
    bne $t4, $t5, not_palindrome           # If the characters are not equal, it's not a palindrome

    addi $t0, $t0, 1                       # Move the start pointer forward
    subi $t2, $t2, 1                       # Move the end pointer backward
    slt $t6, $t0, $t2                      # Check if the start pointer is still less than the end pointer
    bne $t6, $zero, check_loop             # Continue checking if $t0 < $t2

    li $v0, 4                              # Syscall to print string
    la $a0, palindrome                     # Load address of "P"
    syscall                                # Print "P"
    j exit                                 # Exit the program

not_palindrome:
    li $v0, 4                              # Syscall to print string
    la $a0, notpalindrome                 # Load address of "NP"
    syscall                                # Print "NP"

exit:
    li $v0, 10                             # Syscall to exit the program
    syscall
