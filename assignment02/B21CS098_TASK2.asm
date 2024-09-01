.data
    prompt1: .asciiz "Enter the number of employees: "
    prompt2: .asciiz "Enter regular hours worked: "
    prompt3: .asciiz "Enter overtime hours worked: "
    prompt4: .asciiz "Enter hourly wage $: "
    grossMsg: .asciiz "Gross Salary: $"
    deductMsg: .asciiz "Total Deductions: $"
    netMsg: .asciiz "Net Salary: $"
    newline: .asciiz "\n"
    floatZero: .float 0.0
    floatOne: .float 1.0
    floatOnePointFive: .float 1.5
    floatEight: .float 8.0
    floatHundred: .float 100.0
    floatSixteen: .float 16.0

.text
    main:
        # Get the number of employees
        li $v0, 4                   
        la $a0, prompt1
        syscall
        li $v0, 5                   
        syscall
        move $t0, $v0             

        # Load constant float values
        l.s $f20, floatZero
        l.s $f21, floatOne
        l.s $f22, floatOnePointFive
        l.s $f23, floatEight
        l.s $f24, floatHundred
        l.s $f25, floatSixteen

    # Loop through each employee
    employee_loop:
        beq $t0, $zero, end_loop    # exit loop if no more employees

        # Get regular hours worked
        li $v0, 4
        la $a0, prompt2
        syscall
        li $v0, 6                   # syscall to read float
        syscall
        mov.s $f1, $f0              # store regular hours in $f1

        # Get overtime hours worked
        li $v0, 4
        la $a0, prompt3
        syscall
        li $v0, 6                   # syscall to read float
        syscall
        mov.s $f2, $f0              # store overtime hours in $f2

        # Get hourly wage
        li $v0, 4
        la $a0, prompt4
        syscall
        li $v0, 6                   # syscall to read float
        syscall
        mov.s $f3, $f0              # store hourly wage in $f3

        # Calculate Gross Salary
        mul.s $f4, $f1, $f3         # regular salary = regular hours * hourly wage
        mul.s $f5, $f2, $f3         # overtime base pay = overtime hours * hourly wage
        mul.s $f5, $f5, $f22        # multiply overtime by 1.5 as f22 store the 1.5 value
        add.s $f6, $f4, $f5         # gross salary = regular salary + overtime pay

        # Print Gross Salary
        li $v0, 4
        la $a0, grossMsg
        syscall
        li $v0, 2                   # syscall to print float
        mov.s $f12, $f6
        syscall

        # Calculate Deductions
        div.s $f7, $f23, $f24       # Tax rate: 8% = 8.0 / 100.0 as 98%30==8
        mul.s $f8, $f6, $f7         # tax = gross salary * tax rate
        div.s $f9, $f25, $f24       # Insurance rate: 16% = 16.0 / 100.0 as (98+8)%30
        mul.s $f10, $f6, $f9        # insurance = gross salary * insurance rate
        add.s $f11, $f8, $f10       # total deductions = tax + insurance

        # Print Total Deductions
        li $v0, 4
        la $a0, newline
        syscall
        la $a0, deductMsg
        syscall
        li $v0, 2
        mov.s $f12, $f11
        syscall

        # Calculate Net Salary
        sub.s $f12, $f6, $f11       # net salary = gross salary - total deductions

        # Print Net Salary
        li $v0, 4
        la $a0, newline
        syscall
        la $a0, netMsg
        syscall
        li $v0, 2
        syscall

        # Print a newline for clarity
        li $v0, 4
        la $a0, newline
        syscall

        # Decrement employee count
        sub $t0, $t0, 1
        j employee_loop

    end_loop:
        li $v0, 10                  # syscall to exit
        syscall
