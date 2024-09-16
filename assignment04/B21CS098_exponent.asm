.data
	prompt_x:   .asciiz "Enter the value of x: "
	prompt_n:   .asciiz "Enter the number of terms n: "
	result_msg: .asciiz "The approximation of e^x is: "
	
	fl_one: .float 1.0
	fl_zero: .float 0.0

.text
.globl main

main:
	la $a0, prompt_x
	li $v0, 4
	syscall

	li $v0, 6
	syscall
	mov.s $f0, $f0  

	la $a0, prompt_n
	li $v0, 4
	syscall

	li $v0, 5
	syscall
	move $t0, $v0  

	jal exp

	la $a0, result_msg
	li $v0, 4
	syscall

	mov.s $f12, $f0
	li $v0, 2
	syscall

	li $v0, 10
	syscall

exp:
	l.s $f2, fl_one   
	l.s $f4, fl_one   
    
	li $t1, 1                
	
loop_exp:
	bgt $t1, $t0, end_exp

	mul.s $f6, $f2, $f0    
	mtc1 $t1, $f8
	cvt.s.w $f8, $f8       
	div.s $f2, $f6, $f8    

	add.s $f4, $f4, $f2
    
	addi $t1, $t1, 1

	j loop_exp

end_exp:
	mov.s $f0, $f4
	jr $ra