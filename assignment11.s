###########################################################
# Assignment #: 11
# Name: Augustus Crosby 
# ASU email: ancrosby@asu.edu
# Course: CSE230, MW 3:05pm
# Description: Performs arithmetic on floating point numbers 
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM

            .data   
line1:   .asciiz "Specify how many numbers should be stored in the array (at most 25):\n"
line2:   .asciiz "Enter a number:\n"
line3:	 .asciiz "The original array contains the following:\n"
line4: 	 .asciiz "\nSpecify how many small numbers to print:\n"
line5:	 .asciiz "\nThe smallest #"
line6:	 .asciiz ": "
enter:	 .asciiz "\n"

#program code is contained below under .text

            .text 
            .globl main    #define a global function main

# the program begins execution at main()

main:
	li $v0, 4		# load 4 to print string
	la $a0, line1		# load address of line1
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $s0, $v0		# $s0 = howMany

	move $t0, $zero		# $t0 is counter, starts at 0.

#find the smaller number of 25 or inputed number
	li $t1, 25		# max array size = 25
	blt $s0, $t1, if1	# if $t1 is less than $s0 (howMany) continue instead of jump
	move $a1, $t1		# move smaller value ($t1) into $a1
	j Loop1

if1:
	move $a1, $s0		# move smaller value ($s0) into $a1
				# $a1 = loopingValue1

Loop1:
	li $v0, 4		# load 4 to print string
	la $a0, line2		# load address of line2
	syscall			# print_string()

	li $v0, 6		# load 6 to read float
	syscall 		# read_float()

	addi $sp, $sp, -4	# move sp one float
	s.s $f0, 0($sp)		# store float in $sp

	addi $t0, $t0, 1	# $t0++

	blt $t0, $a1, Loop1	#if $t0 is less than $a1 (loopingValue1) keep looping

#Done entering numbers into array

	li $t1, 4		# number of bytes
	mult $t1, $a1		# mult total number of bytes stored in $sp
	mflo $s1		# $s1 contains number of bytes stored in $sp for this array

	li $v0, 4		# load 4 to print string
	la $a0, line3		# load address of line3
	syscall			# print_string()

	add $sp, $sp, $s1	# return to top of $sp. This is in order to read in order.
	
	move $t0, $zero		# $t0 is counter, return to 0.

Loop2:
	addi $sp, $sp, -4	# move sp one float
	l.s $f12, 0($sp)	# load float into $f12

	li $v0, 2		# load 2 to print float
	syscall			# print_float()

	li $v0, 4		# load 4 to print string
	la $a0, enter		# load address of enter
	syscall			# print_string()	

	addi $t0, $t0, 1	# $t0++

	blt $t0, $a1, Loop2	#if $t0 is less than $a1 (loopingValue1) keep looping

#Done printing numbers from array 

	li $v0, 4		# load 4 to print string
	la $a0, line4		# load address of line4
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $s2, $v0		# $s2 = howManySmall

	add $sp, $sp, $s1	# return to top of $sp. This is in order to read in order.
	
	move $t0, $zero		# $t0 is counter, return to 0.

#find the smaller number of loopingValue1 or howManySmall
	blt $s2, $a1, if2	# if $a1 is less than $s2 (howManySmall) continue instead of jump
	move $a2, $a1		# move smaller value ($a1) into $a2
	j Loop3

if2:
	move $a2, $s2		# move smaller value ($s2) into $a2
				# $a2 = loopingValue2
	addi $a3, $a2, -1	# because comparison between numbers
	
	li $t9, 2		# end condition counter

Loop3:
	addi $sp, $sp, -4	# move sp one float
	l.s $f1, 0($sp)		# load float into $f1
	l.s $f3, 0($sp)		# load float into $f3, lowest value

	addi $t0, $t0, 1	# $t0++
	move $t2, $t0		# $t2 = $t0 as placeholder
	move $t3, $t0		# index after lowest

	blt $t0, $t9, Loop3	# if less than to $t9, continue until done

Loop4:
	addi $sp, $sp, -4	# move sp one float
	l.s $f2, 0($sp)		# load float into $f2

	addi $t0, $t0, 1	# $t0++
	
	c.lt.s   $f3, $f2	# FPcond = 1 if $f3 is less than $f2
	bc1f   if3		# if FPcond is not 1, jump
	
	blt $t0, $a1, Loop4	# if $t0 is less than $a1 (loopingValue1) keep looping
	j if4
if3:
	mov.s $f3, $f2		# if FPcond = 1
	move $t3, $t0		# index after lowest
	blt $t0, $a1, Loop4	# if $t0 is less than $a1 (loopingValue1) keep looping
if4:
	add $sp, $sp, $s1	# return to top of $sp. 
	move $t0, $zero		# $t0 is counter, return to 0.
Loop5:
	addi $sp, $sp, -4	# move sp one float
	addi $t0, $t0, 1	# $t0++
	bne $t0, $t2, Loop5	# if $t0 is less than $t2 keep looping until equal

	s.s $f3, 0($sp)		# store float in $sp
Loop6:
	addi $sp, $sp, -4	# move sp one float
	addi $t0, $t0, 1	# $t0++
	bne $t0, $a1, Loop6	# if $t0 is less than $a1 (loopingValue1) keep looping until equal

	add $sp, $sp, $s1	# return to top of $sp. 
	move $t0, $zero		# $t0 is counter, return to 0.
Loop7:
	addi $sp, $sp, -4	# move sp one float
	addi $t0, $t0, 1	# $t0++
	bne $t0, $t3, Loop7	# if $t0 is less than $t3 keep looping until equal

	s.s $f1, 0($sp)		# store float in $sp
	beq $t3, $a1, Label1	# Just in case it's at the end
Loop8:
	addi $sp, $sp, -4	# move sp one float
	addi $t0, $t0, 1	# $t0++
	blt $t0, $a1, Loop8	# if $t0 is less than $a1 (loopingValue1) keep looping 

Label1:
	add $sp, $sp, $s1	# return to top of $sp. 
	move $t0, $zero		# $t0 is counter, return to 0.

	addi $t9, $t9, 1	# $t9++
	
	blt $t9, $a2, Loop3	#if $t9 is less than $a3 (loopingValue2 -1) keep looping entire thing 
	
Loop9:
	addi $sp, $sp, -4	# move sp one float
	addi $t0, $t0, 1	# $t0++

	li $v0, 4		# load 4 to print string
	la $a0, line5		# load address of line5
	syscall			# print_string()
	
	li $v0, 1 		# load 1 to print int
	move $a0, $t0		# counting number loaded in
	syscall			# print_int()

	li $v0, 4		# load 4 to print string
	la $a0, line6		# load address of line6
	syscall			# print_string()

	l.s $f12, 0($sp)	# load float into $f12
	li $v0, 2		# load 2 to print float
	syscall			# print_float()

	bne $t0, $a2, Loop9	#if $t0 is less than $a2 (loopingValue2) keep looping

	jr $ra
	
	

	

	



