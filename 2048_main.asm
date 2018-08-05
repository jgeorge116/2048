
# Constants
.data
coma:  .asciiz ","
newLine:  .asciiz "\n"
gameBoard: .word 0xFFFF0000
rows: .word 6
columns: .word 7

.text
.globl _start


####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

_start:
## clear board
	#lw $a0, gameBoard
	#lw $a1, rows
	#lw $a2, columns
	#jal clear_board
	#move $a0, $v0
	#li $v0, 1
	#syscall
	#la $a0, newLine
	#li $v0, 4
	#syscall
	
## place
	#lw $a0, gameBoard
	#lw $a1, rows
	#lw $a2, columns
	#li $a3, 4 #row index 
	#li $t0, 0 #column index 
	#li $t1, 128 #value
	#addi $sp, $sp, -8
	#sw $t0, 0($sp) #col index
	#sw $t1, 4($sp) #value
	#jal place
	#addi $sp, $sp, 8
	#move $a0, $v0
	#li $v0, 1
	#syscall
	#la $a0, newLine
	#li $v0, 4
	#syscall
	
## start game
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #r1
	li $t0, 1 #c1
	li $t1, 4 #r2 
	li $t2, 3 #c2
	addi $sp, $sp, -12
	sw $t0, 0($sp) #c1
	sw $t1, 4($sp) #r2 
	sw $t2, 8($sp) #c2
	jal start_game
	addi $sp, $sp, 12
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 2 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 5 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 6 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 5 #column index  
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 4 #column index  
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
## merge_row
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index number
	li $t0, 0 #direction (l-r) (1 is r-l)
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal merge_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	## shift row	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index number
	li $t0, 1 #direction (to the left) (1 is to the right) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal shift_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall 
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 1 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #col index number
	li $t0, 0 #direction (bot-top) (1 is top-bot)
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal merge_col
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
## shift col
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #col index number
	li $t0, 0 #direction (0 is up) (1 is down) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal shift_col
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 1 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 0 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 2 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 3 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 4 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 5 #column index 
	li $t1, 128 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 6 #column index 
	li $t1, 256 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 0 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 2 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 3 #column index 
	li $t1, 512 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 4 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 6 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 5 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 0 #column index 
	li $t1, 64 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 2 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 3 #column index 
	li $t1, 1024 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 4 #column index 
	li $t1, 128 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 5 #column index 
	li $t1, 64 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 6 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 0 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 2 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 3 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 4 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 5 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 6 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 0 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 1 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 2 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 0 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 1 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 2 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 3#column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 4 #column index 
	li $t1, 128 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 5 #column index 
	li $t1, 1024 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 6 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	jal check_state
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #col index number
	li $t0, 0 #direction (0 is up) (1 is down) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal merge_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #col index number
	li $t0, 0 #direction (0 is up) (1 is down) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal shift_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 6 #col index number
	li $t0, 1 #direction (0 is up) (1 is down) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal shift_col
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #col index number
	li $t0, 1 #direction (0 is up) (1 is down) 
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal shift_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 'L' #dir
	jal user_move
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, coma
	li $v0, 4
	syscall
	move $a0, $v1
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	jal clear_board
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 0 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 4 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 6 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 1 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 3 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 5 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 1 #row index 
	li $t0, 6 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 0 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 2 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 3 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 2 #row index 
	li $t0, 5 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	

	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 0 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 2 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 3 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 3 #row index 
	li $t0, 5 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 0 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 1 #column index 
	li $t1, 1024 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 3 #column index 
	li $t1, 1024 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 4 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 4 #row index 
	li $t0, 6 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 0 #column index 
	li $t1, 16 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 4 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 6 #column index 
	li $t1, 64 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 2 #column index 
	li $t1, 2 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 5 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
		
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 2 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 4 #column index 
	li $t1, 32 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 5 #row index 
	li $t0, 6 #column index 
	li $t1, 4 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall	
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 'D' #dir
	jal user_move
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, coma
	li $v0, 4
	syscall
	move $a0, $v1
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, 0 #row index 
	li $t0, 3 #column index 
	li $t1, 8 #value
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index
	sw $t1, 4($sp) #value
	jal place
	addi $sp, $sp, 8
	move $a0, $v0
	li $v0, 1
	syscall
	la $a0, newLine
	li $v0, 4
	syscall
	
	lw $a0, gameBoard
	lw $a1, rows
	lw $a2, columns
	li $a3, -1 #col index number
	li $t0, 0 #direction (bot-top) (1 is top-bot)
	addi $sp, $sp, -4
	sw $t0, 0($sp)
	jal merge_row
	addi $sp, $sp, 4
	move $a0, $v0
	li $v0, 1
	syscall 
	la $a0, newLine
	li $v0, 4
	syscall
	
	
	# Exit the program
	li $v0, 10
	syscall

###################################################################
# End of MAIN program
####################################################################

#################################################################
# Student defined functions will be included starting here
#################################################################

.include "hw4.asm"
