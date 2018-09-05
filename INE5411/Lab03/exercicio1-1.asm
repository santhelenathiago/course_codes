.data
_save: .word 6, 6, 1, 6, 6, 2, 7, 6, 5
_k: .word 6		
.text
.globl main
main: # inicialização
lw $s5, _k  		# Carrega _k em $s5

la $s6, _save 		# Carrega o endereço base de _save em $s5

add $s3, $zero, $zero   # Inicializa i em 0

Loop: # corpo do laço
sll $t1, $s3, 2    	# Coloca i*4 em $t1, para acessar os valores do vetor alinhados
add $t1, $t1, $s6       # Adiciona o valor de  i*4 ao endereço base do vetor e coloca em $t1
lw $t0, 0($t1) 		# Carrega o valor da i-ésima posição do vetor em $t0
bne $t0, $s5, Exit    	# Se o valor da i-ésima posição for diferente de k, vai para Exit
addi $s3, $s3, 1        # Se não, incremente i em 1 e volta para Loop
j Loop
                
Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall     
