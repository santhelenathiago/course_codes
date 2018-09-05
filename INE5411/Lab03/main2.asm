_error: .asciiz "Index Out of Bounds Exception"	
.text
.globl main
main: # inicialização
...            
Loop: # verificação de limites do arranjo
...
# corpo do laço
...
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
