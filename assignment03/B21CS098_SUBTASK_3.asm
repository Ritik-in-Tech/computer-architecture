.data
prompt:    .asciiz "Enter a string: "    # Prompt message for user input
buffer:    .space 100                    # Buffer to store the input string, 100 bytes allocated
newline:   .asciiz "\nReversed string: " # Message to indicate the reversed string

.text
.globl main
main:
    li $v0, 4                 # Syscall for printing a string
    la $a0, prompt            # Load address of the prompt message
    syscall                   # Print the prompt message

    li $v0, 8                 # Syscall to read a string
    la $a0, buffer            # Load address of the buffer where the string will be stored
    li $a1, 100               # Maximum length of the input (100 bytes)
    syscall                   # Perform the read syscall

    la $t0, buffer            # Load the address of the input string into $t0
    li $t1, 0                 # Initialize the length counter

find_length:
    lb $t2, 0($t0)            # Load byte from the string into $t2
    beq $t2, $zero, reverse   # If null terminator is reached, go to reverse section
    addi $t1, $t1, 1          # Increment length counter
    addi $t0, $t0, 1          # Move to the next byte in the string
    j find_length             # Repeat loop

reverse:
    li $v0, 4                 # Syscall to print a string
    la $a0, newline           # Load address of the newline message
    syscall                   # Print newline message

    la $t0, buffer            # Load the address of the input string
    add $t0, $t0, $t1         # Move $t0 to the end of the string (excluding null terminator)
    sub $t0, $t0, 1           # Decrement to get to the last character

print_reverse:
    lb $t2, 0($t0)            # Load byte from the string into $t2
    beq $t1, $zero, exit       # If length is 0, exit loop
    li $v0, 11                # Syscall to print a character
    move $a0, $t2             # Move the character to $a0 (for printing)
    syscall                   # Print the character
    sub $t0, $t0, 1           # Move pointer to the previous character
    sub $t1, $t1, 1           # Decrease the length counter
    j print_reverse           # Repeat until the string is fully reversed

exit:
    li $v0, 10                # Syscall to exit the program
    syscall
