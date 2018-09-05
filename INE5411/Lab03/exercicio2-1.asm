.data
_error: .asciiz "Index Out of Bounds Exception"
_save: .word 9999, 8, 6, 6, 6, 6, 5, 6, 3, 0
_k: .word 6	
	
.text
.globl main
main: # inicialização
lw $s5, _k  		# Carrega _k em $s5

la $s6, _save 		# Carrega o endereço base de _save em $s5

add $s3, $zero, $zero   # Inicializa i em 0

lw $t2, 4($s6)       	# Carrega o tamanho do vetor

Loop: # verificação de limites do arranjo
# VERIFICA SE i < 0
slt $t0, $s3, $zero			# Seta $t0 para 1 se i for menor que zero
bne $t0, $zero, IndexOutOfBounds    	# Se $t0 for 0, continua normalmente 

# VERIFICA SE i >= tamanho
slt $t0, $s3, $t2			# Seta $t0 para 1 se i for menor que tamanho
beq $t0, $zero, IndexOutOfBounds	# Vai para Cont se i for menor que tamanho

# Loop normalmente
sll $t1, $s3, 2    	# Coloca i*4 em $t1, para acessar os valores do vetor alinhados
add $t1, $t1, $s6       # Adiciona o valor de  i*4 ao endereço base do vetor e coloca em $t1
lw $t0, 8($t1) 		# Carrega o valor da i-ésima posição do vetor em $t0
bne $t0, $s5, Exit    	# Se o valor da i-ésima posição for diferente de k, vai para Exit
addi $s3, $s3, 1        # Se não, incremente i em 1 e volta para Loop
j Loop			# Volta para Loop

Exit: # rotina para imprimir inteiro no console
addi $v0, $zero, 1
add $a0, $zero, $s3
syscall
j End

IndexOutOfBounds: # rotina para imprimir mensagem de erro no console
addi $v0, $zero, 4
la $a0, _error
syscall
End:   
