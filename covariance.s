.data

##### R1 START MODIFIQUE AQUI START #####

#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

vetor1: .word 1 2 3 4 #Primeiro vetor
vetor2: .word 1 1 1 1 #Segundo vetor

##### R1 END MODIFIQUE AQUI END #####
      
.text    

        add s0, zero, zero
        la a0, vetor1
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 2
        bne a0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor2
        addi a1, zero, 4
        jal ra, media
        addi t0, zero, 1
        bne a0,t0, FIM
        addi s0,s0,1
        beq zero,zero, FIM

##### R2 START MODIFIQUE AQUI START #####

# Esse espaço é para você escrever o código dos procedimentos. 
# Por enquanto eles estão vazios

media:
add t6, zero, a0 #t6 = address of array[0]
slli t5, a1, 2 #t5 = size * 4
add t5, t6, t5 #t5 = address of array[size]
add x10, zero, zero
add t3, zero, zero
loop1:
lw t4, 0(t6) # t4 = array[i]
add t3, t4, t3 #t3 = t3 + array[i]
addi t6, t6, 4 #t6 = address of array[i]
bltu t6, t5, loop1
div x10, t3, a1 #x10 = media(array)
jalr zero, 0(ra)

covariancia:
addi x2, x2, -8 #aloca 3 endereços na pilha
sw ra, 8(x2) #armazena ra na pilha
la x18, vetor1 #carrega valor do vetor1 em x18
la x19, vetor2 #carrega valor do vetor2 em x19
addi a1, zero, 4 #a1 = size
add a0, x18, zero #a0 = address of array1
jal ra, media #calcula média para vetor1
sw a0, 0(x2) #armazena média do vetor1 na pilha
add a0, x19, zero #a0 = address of array2
jal ra, media #calcula média para vetor2
sw a0, 4(x2) #armazena média do vetor2 na pilha
add a0, zero, zero #a0 (x10) = 0
add t5, zero, x18 #t5 = address of array1[0]
add t6, zero, x19 #t6 = address of array2[0]
slli t4, a1, 2 #t4 = size * 4
add t3, t5, t4 #t3 = address of array1[size]
lw t2, 0(x2) #t2 = media(array1)
lw t1, 4(x2) #t1 = media(array2)
loop2:
lw x20, 0(t5) #x20 = array1[i]
lw x21, 0(t6) #x21 = array2[i] 
sub x22, x20, t2 #x22 = array1[i] - media(array1)
sub x23, x21, t1 #x23 = array2[i] - media(array2)
mul x24, x22, x23 #x24 = (array1[i] - media(array1)) * (array2[i] - media(array2))
add x25, x25, x24 #x25 = somatório
addi t5, t5, 4 #t5 = address of array1[i]
addi t6, t6, 4 #t6 = address of array2[i]
bltu t5, t3, loop2
addi a1, a1, -1 #a1 = N - 1
div x10, x25, a1 #x10 = somatório / N - 1
lw ra, 8(x2) #atualiza ra para seu valor inicial
jalr zero, 0(ra)

##### R2 END MODIFIQUE AQUI END #####

FIM: add t0, zero, s0
