#Nathan Kiernan, 15088410, Options 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 implemented.

.data
#Program menu to be displayed to user:
menu:	.ascii "\n\n\t\t\tM E N U\n\n"
	.ascii "\t1:  Set a value for Number 1\n"
	.ascii "\t2:  Set a value for Number 2\n"
	.ascii "\t3:  Display the values of Number 1 and Number 2\n"
	.ascii "\t4:  Display the sum of Number 1 and Number 2\n"
	.ascii "\t5:  Display the product of Number 1 and Number 2\n"
	.ascii "\t6:  Divide Number 1 by Number 2, displaying the quotient and remainder\n"
	.ascii "\t7:  Exchange the values of Number 1 and Number 2\n"
	.ascii "\t8:  Display numbers in sequence between and including Number 1 and Number 2\n"
	.ascii "\t9:  Display the sum of numbers between and including Number 1 and Number 2\n"
	.ascii "\t10: Raise Number 1 to the power of Number 2\n"
	.ascii "\t11: Display prime numbers between Number 1 and Number 2\n"
	.ascii "\t12: Quit the program\n\n"
	.asciiz "Choose an option: "

#Strings for each option:
#Option 1:
str.getNumber1: .asciiz "\nEnter Number 1: "

#Option 2:
str.getNumber2: .asciiz "\nEnter Number 2: "

#Option 3:
str.showNumber1: .asciiz "\nNumber 1 is " 	#Value of $s1
str.showNumber2: .asciiz " and Number 2 is " 	#Value of $s2

#Option 4:
str.showSum1: .asciiz "\nThe sum of " 	#Number 1
str.showSum2: .asciiz " and " 		#Number 2
str.showSum3: .asciiz " is: " 		#Sum of $s1 and $s2

#Option 5:
str.showProduct1: .asciiz "\nThe product of "	#Number 1
str.showProduct2: .asciiz " and "		#Number 2
str.showProduct3: .asciiz " is: "		#Product of $s1 and $s2

#Option 6:
str.showDivision1: .asciiz "\nDivision of "	#Number 1
str.showDivision2: .asciiz " by "		#Number 2
str.showDivision3: .asciiz " is "		#Quotient of $s1 divided by $s2
str.showRemainder: .asciiz " remainder "	#Remainder of $s1 divided by $s2

#Option 7:
str.swapMessage: .asciiz "\nValues of Number 1 and Number 2 will be swapped:"
str.swapNumber1: .asciiz "\n\tNumber 1 is now "		#Value of what $s2 was
str.swapNumber2: .asciiz " and Number 2 is now "	#Value of what $s1 was

#Option 8:
str.showSequence1: .asciiz "\nThe sequence of numbers between " #Number 1
str.showSequence2: .asciiz " and "				#Number 2
str.showSequence3: .asciiz " is:\n\t"				#Sequence of numbers between $s1 and $s2

#Option 9:
str.showSequenceSum1: .asciiz "\nThe sum of numbers between "	#Number 1
str.showSequenceSum2: .asciiz " and " 				#Number 2
str.showSequenceSum3: .asciiz " is: "				#Sum of numbers between $s1 and $s2

#Option 10:
str.showPower1: .asciiz "\nRaising "		#Number 1
str.showPower2: .asciiz " to the power of "	#Number 2
str.showPower3: .asciiz " results in: "		#$s1 to the power of $s2

#Option 11:
str.showPrimes1: .asciiz "\nPrime numbers between " 	#Number 1
str.showPrimes2: .asciiz " and " 			#Number 2
str.showPrimes3: .asciiz " are:\n\t"			#List of prime numbers between $s1 and $s2

#Option 12:
str.userQuit: .asciiz "\n\t\t\tGoodbye!\n"

.text
li $s1, 4	#Load immeadiate value (4) to $s1 to set a default value for Number 1
li $s2, 20	#Using $s2 to store default value for Number 2 ($s registers are used to store values)

main:
jal printMenu		#Jump and link to subroutine at printMenu label (see comments on each subroutine for more detail)
jal getUserOption	#Jump and link to getUserOption subroutine, store value in $s0
beq $s0, 1,  option1	#If value of $s0 is = 1, program branch to option1 label
beq $s0, 2,  option2	#As above if $s0 = 2, go to option2, etc
beq $s0, 3,  option3
beq $s0, 4,  option4
beq $s0, 5,  option5
beq $s0, 6,  option6
beq $s0, 7,  option7
beq $s0, 8,  option8
beq $s0, 9,  option9
beq $s0, 10, option10
beq $s0, 11, option11
beq $s0, 12, quit

j main #Program will jump back to main label, displaying menu again in case of input error

option1: #Read in and store Number 1 from user
la $a0, str.getNumber1	#Store string at str.getNumber1 label into $a0 ($a registers are argument registers)
jal printString		#Jump and link to printString subroutine to print above string	
jal getUserNumber	#Jump and link to getUserNumber subroutine and store value in $v0 ($v registers are for return values)
move $s1, $v0		#Value obtained by using getUserNumber will be stored in $s1 and used as Number 1
j main			#Jump back to main when this has been completed

option2: #Read in and store Number 2 from user
la $a0, str.getNumber2	#Same procedure as above, except user's number will be stored in $s2 as Number 2
jal printString
jal getUserNumber
move $s2, $v0
j main

option3: #Display values of Number 1 and Number 2
la $a0, str.showNumber1
jal printString
move $a0, $s1	#Move value of Number 1 to argument register
jal printNumber	#Use printNumber to display Number 1

la $a0, str.showNumber2
jal printString
move $a0, $s2	#Same as above but with Number 2
jal printNumber

j main

option4: #Display sum of Number 1 and Number 2
la $a0, str.showSum1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showSum2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showSum3
jal printString
add $a0, $s1, $s2	#Add Number 1 to Number 2 and store result in $a0
jal printNumber		#Use argument register to print result of summing $s1 and $s2

j main

option5: #Display product of Number 1 and Number 2
la $a0, str.showProduct1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showProduct2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showProduct3
jal printString
mul $a0, $s1, $s2	#Store product of $s1 and $s2 in argument register to print to user
jal printNumber

j main

option6: #Display division and remainder of Number 1 and Number 2
la $a0, str.showDivision1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showDivision2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showDivision3
jal printString
div $a0, $s1, $s2	#Store quotient of $s1 divided by $s2 in $a0 to print
jal printNumber

la $a0, str.showRemainder
jal printString
rem $a0, $s1, $s2	#Store remainder of $s1 divided by $s2 in $a0
jal printNumber

j main

option7: #Exchange values of Number 1 and Number 2 and display new values
la $a0, str.swapMessage
jal printString

move $t1, $s1	#Move $s1 to $t1 ($t registers are for storing temporary values)
move $s1, $s2	#Move $s2 to $s1, Number 1 has been swapped with Number 2
move $s2, $t1	#Move Number 1 (temporarily stored in $t1) to $s2 so it is now Number 2

la $a0, str.swapNumber1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.swapNumber2
jal printString
move $a0, $s2
jal printNumber

j main

option8: #Display numbers in sequence between Number 1 and Number 2
la $a0, str.showSequence1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showSequence2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showSequence3
jal printString
j startSequence #See subroutine for more details

option9: #Display sum of numbers between Number 1 and Number 2
la $a0, str.showSequenceSum1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showSequenceSum2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showSequenceSum3
jal printString
j sequenceSum #See subroutine for more details

option10: #Raise Number 1 to the power of Number 2
la $a0, str.showPower1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showPower2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showPower3
jal printString
j calculatePower #See subroutine for more details

option11: #Display prime numbers betwen Number 1 and Number 2
la $a0, str.showPrimes1
jal printString
move $a0, $s1
jal printNumber

la $a0, str.showPrimes2
jal printString
move $a0, $s2
jal printNumber

la $a0, str.showPrimes3
jal printString
j displayPrimes #See subroutine for more details

#Subroutines:

printMenu:
	la $a0, menu	#Load menu strings into argument register
	li $v0, 4	#Load 4 into $v0 to call service 4 (print out null terminated string)
	syscall		#Operating system will execute service 4
	jr $ra		#Jump back to return address ($ra) and resume code after original jump off
#End printMenu

getUserOption:
	li $v0, 5
	syscall	#Execute service 5 (Read in single integer) to process user's menu option
	move $s0, $v0
	jr $ra
#End getUserOption

printString: #Use service 4 to print a string
	li $v0, 4
	syscall
	jr $ra
#End printString

getUserNumber: #Use service 5 to take in values for Number 1 and Number 2 from user
	li $v0, 5
	syscall
	jr $ra
#End getUserNumber

printNumber: #Use service 1 to print out an integer
	li $v0, 1
	syscall
	jr $ra
#End printNumber

printChar: #Use service 11 to print single characters
	li $v0, 11
	syscall
	jr $ra
#End printChar

#Begin startSequence subroutine (opt8):
startSequence:
	sgt $t1, $s1, $s2		#Set $1 to 1 if Number 1 is greater than Number 2
	beq $t1, 1, descendingSequence	#If $t1 is equal to 1, sequence will descend so branch to descendingSequence

#If $s1 is less than $s2:
	move $t0, $s1		#Set $t0 to Number 1 and use as counter
	j beginAscendingLoop	#Skip nextNumber to print first number without space and comma before it

nextNumber: #Used to print comma and space between numbers sequential numbers
	la $a0, ','
	jal printChar
	la $a0, ' '
	jal printChar

beginAscendingLoop:
	move $a0, $t0
	jal printNumber		 #Print current counter value
	addi $t0, $t0, 1	 #Increase counter value	
	ble $t0, $s2, nextNumber #While counter is less than Number 2, print a space and comma after it
	j main			 #Go back to main menu when counter has reached last number ($s2) in sequence

#Similar to above sequence but only used if $s1 is greater than $s2:
descendingSequence:
	move $t0, $s1
	j beginDescendingLoop

previousNumber:
	la $a0, ','
	jal printChar
	la $a0, ' '
	jal printChar

beginDescendingLoop:
	move $a0, $t0
	jal printNumber
	subi $t0, $t0, 1 #Decrease counter value in this case as sequence is descending
	bge $t0, $s2, previousNumber
	j main
#End startSequence subroutine (opt8)

#Begin sequenceSum subroutine (opt9):
sequenceSum:
	move $t0, $s1		  #Use Number 1 in $t0 as counter
	move $t1, $s1		  #Use Number 1 in $t0 to begin total value of sum
	sgt $t2, $s1, $s2	  #Use $t2 to compare values of $s1 and $s2
	beq $t2, 1, descendingSum #Go to descendingSum if $s2 is higher vallue

#If $s1 is less than $s2:
ascendingSum:
	addi $t0, $t0, 1	   #Increase counter by 1
	add $t1, $t0, $t1	   #Add counter value to total value
	blt $t0, $s2, ascendingSum #Repeat previous two lines while counter is less than Number 2
	move $a0, $t1		   #Print total value when it has been reached
	jal printNumber
	j main

#If $s1 is greater than $s2:
descendingSum:
	subi $t0, $t0, 1		#Decrease counter value in this case as sequence is descending
	add $t1, $t0, $t1		#Add decreased value to total value
	bgt $t0, $s2, descendingSum	#Repeat previous two lines while counter is greater than Number 2
	move $a0, $t1			#Print total value when it has been reached
	jal printNumber
	j main
#End sequenceSum subroutine (opt9)

#Begin calculatePower subroutine (opt10)
calculatePower:
	move $t0, $s1	#Move Number 1 to $t0 to use as exponent
	li $t1, 1	#Establish $t1 as a counter
	
	powerLoop:
	mul $t0, $t0, $s1	#Mulitply exponent by itself
	addi $t1, $t1, 1	#Increase counter by 1
	blt $t1, $s2, powerLoop #Keep multiplying exponent by itself until counter has reached value of Number 2
	
	move $a0, $t0
	jal printNumber
	
	j main
#End calculatePower subroutine (opt 10)

#Begin displayPrimes subroutine (opt 11)
displayPrimes:
	sgt $t1, $s1, $s2		#Compare Number 1 and Number 2
	beq $t1, 1, descendingPrimes	#Go to descendingPrimes if sequence is descending

	move $t0, $s1			#Set Number 1 as test value
	li $t1, 1			#Set divisor to 1
	bgt $t0, 1, testAscendingPrime  #Skip next line if Number 1 is greater than one
	addi $t0, $t0, 1		#If test value is 1, increase by 1 (as one is not a prime number)
	
	testAscendingPrime:
	addi $t1, $t1, 1 		  #Increase divisor by one
	beq $t0, $t1, printAscendingPrime #If test value is equal to divisor, it is a prime number and will print
	rem $t2, $t0, $t1		  #Store remainder of division in $t2
	bgtz $t2, testAscendingPrime	  #If $t2 is equal to 0, it is not a prime number so test next value
	
	testNextPrime:
	addi $t0, $t0, 1	#Increase test value by one
	bgt $t0, $s2, main	#Go back to main if test value has passed Number 2
	li $t1, 1		#Reset divisor to test next value
	j testAscendingPrime
	
	printAscendingPrime:
	move $a0, $t0
	jal printNumber			#Print test value if it is a prime
	addi $t3, $t0, 1		#Set $t3 to test value + 1 to see if Number 2 has been reached
	bge $t3, $s2, testNextPrime	#Go back to testNextPrime if test value will reach Number 2 on next test
	la $a0, ','
	jal printChar
	la $a0, ' '
	jal printChar
	j testNextPrime			#Test next value if it is less than Number 2
	
	#Similar to above but only used if $s1 is greater than $s2:
	descendingPrimes:
	move $t0, $s1			#Use Number 1 as test value
	li $t1, 1			#Set divisor to 1
	bgt $t0, 1, testDescendingPrime #Skip next line if Number 1 is greater than one
	addi $t0, $t0, 1		#If test value is 1, increase by 1
	
	testDescendingPrime:
	addi $t1, $t1, 1		   	#Increase divisor by one
	beq $t0, $t1, printDescendingPrime	#Print test value if proven to be a prime number
	rem $t2, $t0, $t1			#Store remainder of division in $t2
	bgtz $t2, testDescendingPrime	  	#If $t2 is equal to 0, it is not a prime number so test next value
	
	testPreviousPrime:
	subi $t0, $t0, 1	#Decrease test value by one
	blt $t0, $s2, main	#Go back to main if test value reaches less than Number 2
	li $t1,1		#Set divisor back to 1
	j testDescendingPrime	#Test new value
	
	printDescendingPrime:
	move $a0, $t0
	jal printNumber			#Print test value if it is a prime
	beq $t0, 2, main		#Go back to main if test value reaches 2, as not to test 1
	subi $t3, $t0, 1		#Set $t3 to test value - 1 to see if Number 2 has been reached
	ble $t3, $s2, testPreviousPrime #Go back to testPreviousPrime if test value will reach Number 2 on next test
	la $a0, ','
	jal printChar
	la $a0, ' '
	jal printChar
	j testPreviousPrime		#Test next value if it is greater than Number 2
#End display Primes subroutine (opt 11)

quit: 	#Print goodbye message and end program (opt12)
la $a0, str.userQuit
jal printString
#End of program
