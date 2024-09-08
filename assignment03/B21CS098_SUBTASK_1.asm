.data
string1: .asciiz "Ritik"   # Fist string 
string2: .asciiz "Tiwari"   # Second String
result:  .space 100   # Allocate 100 bytes to store the result

.text
main:
     
    la $t0, string1      #  Load address of string1 at t0
    la $t1, string2       # Load address of string2 at t1
    la $t2, result        # load address of result buffer into t2

    
copy_string1:
    lb $t3, 0($t0)       # load byte from t0 (string1) into t3
    beq $t3, $zero, copy_string2  # if the byte of t3 becomes null then go to branch copy_string2
    sb $t3, 0($t2)       # store the byte address of t3 to t2
    addi $t0, $t0, 1     # increement t0 by one
    addi $t2, $t2, 1     # increment t2 by one
    j copy_string1        

  
copy_string2:
    lb $t3, 0($t1)        # load byte from t1 (string2) into t3
    beq $t3, $zero, done  # if strting2 bytes ended then move to done
    sb $t3, 0($t2)        # store byte of t3 into t2
    addi $t1, $t1, 1     # increment string2 byte by one
    addi $t2, $t2, 1      # increment t2 byte by one
    j copy_string2        

done:
    sb $zero, 0($t2)      # null terminator for t2 (result string)
    li $v0, 4            # syscall to print
    la $a0, result       # load the address of result into a0 for print
    syscall

   
    li $v0, 10           # syscall for program termination
    syscall
