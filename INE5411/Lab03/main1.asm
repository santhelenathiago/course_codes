.data
_save: .word # Estimulo 1.1 e 1.2
_k: .word 6		
.text
.globl main
main: # inicialização
...            
Loop: # corpo do laço
sll $t1, $s3, 2    
add $t1, $t1, $s6 
lw $t0, 0($t1) 
bne $t0, $s5, Exit    
addi $s3, $s3, 1      
j Loop
                
Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall     
