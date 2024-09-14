.data

##### R1 START MODIFIQUE AQUI START #####
#
# Este espaço é para você definir as suas constantes e vetores auxiliares.
#

vetor: .word 1 2 3 4 5 6 7 8 9 10

##### R1 END MODIFIQUE AQUI END #####

.text
        add s0, zero, zero #Quantidade de testes em que seu programa passou
        la a0, vetor
        addi a1, zero, 10
        addi a2, zero, 2
        jal ra, multiplos
        addi t0, zero, 5
        bne a0,t0,teste2
        addi s0,s0,1
teste2: la a0, vetor
        addi a1, zero, 10
        addi a2, zero, 3
        jal ra, multiplos
        addi t0, zero, 3
        bne a0,t0, FIM
        addi s0,s0,1
        beq zero,zero,FIM

##### R2 START MODIFIQUE AQUI START #####
multiplos:
add t5, zero, a0 #t5 (iterator) = address of array[0]
add x10, zero, zero #x10 = 0
slli t6, a1, 2 #t6 = size * 4
add t4, t5, t6 #t4 = address of array[size]
loop:
lw t3, 0(t5) #t3 = array[i]
rem t3, t3, a2 #t3 = array[i] % n (inteiro que deve ser verificado)
beq t3, zero, sum #verifica se t3 == 0
addi t5, t5, 4 #incrementa i
bltu t5, t4, loop #verifica se address of array[i] < address of array[size]
jalr zero, 0(ra)
sum:
addi x10, x10, 1 #número de múltiplos++
addi t5, t5, 4 #incrementa i
bltu t5, t4, loop #verifica se address of array[i] < address of array[size]
jalr zero, 0(ra)

##### R2 END MODIFIQUE AQUI END #####

FIM: addi t0, s0, 0
