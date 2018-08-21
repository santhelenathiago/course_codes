.globl main

main:
addi $a0, $zero, 8		# Testing
jal fib
j exit

fib:
bne $a0, $zero, L1		# If input equals zero, return 0, else, L1
addi $v0, $zero, 0		# Put zero on return
jr $ra				# Jump back to ra

L1:
addi $t0, $zero, 1		# Set $t0 to one, to check on branch
bne $t0, $a0, L2		# If input equals to one, return 1, else, L2 
addi $v0, $zero, 1		# Put 1 on return
jr $ra				# Jump back to ra

L2:
addi $sp, $sp, -12		# Allocates memory on heap for 3 32 bits values
sw $a0, 0($sp)			# Store $a0 on $sp+0
sw $ra, 4($sp)			# Store $ra on $sp+4
addi $a0, $a0, -1		# Decrements actual $a0 by one
jal fib				# Call Fib
sw $v0, 8($sp)			# Store result of fib(n-1) on $sp+8
lw $a0, 0($sp)			# Load original $a0
addi $a0, $a0, -2		# Put $a0-2 on %a0
jal fib				# Call fib
lw $t0, 8($sp)			# Loads result of fib(n-1)
add $v0, $v0, $t0		# Put on $v0 fib(n-2) + fib(n-1) on return
lw $ra, 4($sp)			# Loads original $ra back
addi $sp, $sp, 12		# Desalocatte memory on heap
jr $ra				# Jump back to function

exit: nop