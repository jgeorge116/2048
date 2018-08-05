##############################################################
# Homework #4
# name: Joel George
# sbuid: 110148892
##############################################################
.text

##############################
# PART 1 FUNCTIONS
##############################

clear_board:
    #Define your code here
	############################################
	li $t0, 2
	blt $a1, $t0, errorInClearBoard #checks if num rows < 2
	blt $a2, $t0, errorInClearBoard #checks if num cols < 2
	
	li $t0, 0 #row counter (i)
	li $t1, 0 #column counter (j)
	li $t5, -1 #empty cell
	li $t2, 2 #sizeof(obj)
	loopToInitBoard:
		mul $t3, $a2, $t2 #num cols * sizeof(obj)
		mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
		mul $t4, $t2, $t1 #sizeof(obj) * j
		add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
		add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
		beq $t1, $a2, incremNumRows #if col counter == num col, increment row
		sh $t5, 0($t3) #inits cell
		addi $t1, $t1, 1 #increment col count
		j loopToInitBoard
		
		incremNumRows:
		addi $a1, $a1, -1 #for convience (num rows)
		beq $t0, $a1, successClearBoard #checks if row count == num row (stopping condition of method)
		addi $a1, $a1, 1 #put it back (num rows)
		li $t1, 0 #reset col counter
		addi $t0, $t0, 1 #increment row counter
		j loopToInitBoard
		
	############################################
	errorInClearBoard:
	li $v0, -1
	jr $ra
	
	successClearBoard:
	li $v0, 0
	jr $ra

place:
    #Define your code here
	############################################
	li $t0, 2
	blt $a1, $t0, errorInPlace #checks if num rows < 2
	blt $a2, $t0, errorInPlace #checks if num cols < 2
	blt $a3, $0, errorInPlace #checks if row index < 0
	lw $t8, 0($sp) #col index
	blt $t8, $0, errorInPlace #checks if column index < 0
	bge $a3, $a1, errorInPlace #checks if row index >= num rows
	bge $t8, $a2, errorInPlace #checks if col index >= num cols
	
	lw $t9, 4($sp) #gets value to be stored
	li $t0, 1
	beq $t9, $t0, errorInPlace #checks if value is 1
	addi $t7, $t9, -1
	and $t7, $t9, $t7 #ands value & value-1
	bne $t7, $0, errorInPlace #checks if value is not a power of 2
	
	li $t0, 0 #row counter (i)
	li $t1, 0 #column counter (j)
	li $t5, -1 #empty cell
	li $t2, 2 #sizeof(obj)
	loopToPlaceInBoard:
		mul $t3, $a2, $t2 #num cols * sizeof(obj)
		mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
		mul $t4, $t2, $t1 #sizeof(obj) * j
		add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
		add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
		beq $t1, $a2, incremNumRowsForPlace #if col counter == num col, increment row
		beq $t1, $t8, checkRowIndex #if col counter == col index, increment row
		addi $t1, $t1, 1 #increment col count
		j loopToPlaceInBoard
		
		checkRowIndex:
		ble  $a3, $t0, placeValue #checks if row count == row index (stopping condition of method) 
		addi $t1, $t1, 1 #increment col count
		j loopToPlaceInBoard
		
		incremNumRowsForPlace:
		li $t1, 0 #reset col counter
		addi $t0, $t0, 1 #increment row counter
		j loopToPlaceInBoard
	############################################
	errorInPlace:
	li $v0, -1
        jr $ra
        
        placeValue:
        sh $t9, 0($t3) #places value in proper address
        li $v0, 0
        jr $ra
        

start_game:
    #Define your code here
	############################################
	lw $t0, 0($sp) #loads c1
	lw $t1, 4($sp) #loads r2
	lw $t2, 8($sp) #loads c2
	
	li $t4, 2
	blt $a1, $t4, errorInStartGame #checks if num rows < 2
	blt $a2, $t4, errorInStartGame #checks if num cols < 2
	
	blt $a3, $0, errorInStartGame #checks if row index1 < 0
	blt $t0, $0, errorInStartGame #checks if column index1 < 0
	bge $a3, $a1, errorInStartGame #checks if row index1 >= num rows
	bge $t0, $a2, errorInStartGame #checks if col index1 >= num cols
	
	blt $t1, $0, errorInStartGame #checks if row index2 < 0
	blt $t2, $0, errorInStartGame #checks if column index2 < 0
	bge $t1, $a1, errorInStartGame #checks if row index2 >= num rows
	bge $t2, $a2, errorInStartGame #checks if col index2 >= num cols
	
	addi $sp, $sp, -32
	sw $ra, 0($sp) #store ra
	sw $a0, 4($sp) #board
	sw $a1, 8($sp) #num rows
	sw $a2, 12($sp) #num cols
	sw $a3, 16($sp) #r1
	sw $t0, 20($sp) #c1
	sw $t1, 24($sp) #r2
	sw $t2, 28($sp) #c2
	jal clear_board #args: a0-> address of board, a1-> num rows, a2-> num cols
	
	lw $a0, 4($sp) #board
	lw $a1, 8($sp) #num rows
	lw $a2, 12($sp) #num cols
	lw $a3, 16($sp) #r1
	lw $t0, 20($sp) #c1
	addi $sp, $sp, -8
	sw $t0, 0($sp) #col index1
	li $t5, 2
	sw $t5, 4($sp) #value
	jal place  #args: a0-> address of board, a1-> num rows, a2-> num cols, a3-> row index, nextArg-> col index-> nextArg-> value
	
	addi $sp, $sp, 8
	lw $a0, 4($sp) #board
	lw $a1, 8($sp) #num rows
	lw $a2, 12($sp) #num cols
	lw $t1, 24($sp) #r2
	lw $t2, 28($sp) #c2
	addi $sp, $sp, -8
	move $a3, $t1 #moves r2
	sw $t2, 0($sp) #col index2
	li $t5, 2
	sw $t5, 4($sp) #value
	jal place  #args: a0-> address of board, a1-> num rows, a2-> num cols, a3-> row index, nextArg-> col index-> nextArg-> value
	
	addi $sp, $sp, 8
	lw $ra, 0($sp) #store ra
	addi $sp, $sp, 32
	
	j successStartGame
	############################################
	errorInStartGame:
	li $v0, -1	
        jr $ra
        
        successStartGame:
        li $v0, 0	
        jr $ra
        
##############################
# PART 2 FUNCTIONS
##############################

merge_row:
    #Define your code here
    ############################################
    lw $t0, 0($sp) #loads direction
    blt $t0, $0, errorInMergeRow #checks if dir < 0
    li $t1, 1
    bgt $t0, $t1, errorInMergeRow #checks if dir > 1
    #addi $a3, $a3, -1 #for convience (row#)
    ###CHECK A3 OUTSIDE OF RANGE
    li $t1, 2
    blt $a1, $t1, errorInMergeRow #if num rows < 2
    blt $a2, $t1, errorInMergeRow #if num cols < 2
    bltz $a3, errorInMergeRow
    addi $a1, $a1, -1
    bgt $a3, $a1, errorInMergeRow #if row index is bigger than or = to num rows
    addi $a1, $a1, 1
    
    li $t1, 0 #column counter (j)
    
    bne $t0, $0, SKIPmergeLeft #check value of dir
    
    mergeLeftRight: #0 (t3 is address of 1st val(left), t4 has 2nd val(right))
        li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t6, $t3 #makes copy
    	sll $t8, $t8, 16
    
    	addi $t1, $t1, 1 #add 1 to get next element too
    	bge $t1, $a2, successMergeRow #a2 is num cols: checks if next value is out of bounds (stopping condition)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j+1
    	addi $t1, $t1, -1 #puts it back
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j+1)
    	add $t4, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j+1) 
    	lhu $t9, 0($t4) #gets value at specified location +1 (2nd value)
    	sll $t9, $t9, 16
    	
    	bgt $t8, $0, checkNextValForMergeRow #checks if 1st value isn't -1
    	addi $t1, $t1, 1 #increment col counter
    	j mergeLeftRight
    	
    	checkNextValForMergeRow:
    	srl $t8, $t8, 16
    	bgt $t9, $0, checkIfValsAreEqualMergeRow
    	addi $t1, $t1, 1 #increment col counter
    	j mergeLeftRight
    	
    	checkIfValsAreEqualMergeRow:
    	srl $t9, $t9, 16
    	beq $t8, $t9, mergeValuesInRowLeft
    	addi $t1, $t1, 1 #increment col counter
    	j mergeLeftRight
    	
    	mergeValuesInRowLeft:
    	mul $t8, $t8, $t2 #mult by 2
    	sh $t8, 0($t6) #stores on left side
    	li $t6, -1
    	sh $t6, 0($t4) #store -1 on right
    	addi $t1, $t1, 1 #increment col counter
    	j mergeLeftRight

    SKIPmergeLeft:
    addi $a2, $a2, -1
    move $t1, $a2 #makes index of j last cell
    addi $a2, $a2, 1 #puts it back
    
    mergeRightLeft: #1
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t6, $t3 #makes copy
    	sll $t8, $t8, 16
    
    	addi $t1, $t1, -1 #sub 1 to get next element too
    	bltz $t1, successMergeRow #checks if next value is out of bounds (stopping condition)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j-1
    	addi $t1, $t1, 1 #puts it back
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j-1)
    	add $t4, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j+1) 
    	lhu $t9, 0($t4) #gets value at specified location +1 (2nd value)
    	sll $t9, $t9, 16
    	
    	bgt $t8, $0, checkNextValForMergeRowRight #checks if 1st value isn't -1
    	addi $t1, $t1, -1 #increment col counter
    	j mergeRightLeft
    	
    	checkNextValForMergeRowRight:
    	srl $t8, $t8, 16
    	bgt $t9, $0, checkIfValsAreEqualMergeRowRight
    	addi $t1, $t1, -1 #increment col counter
    	j mergeRightLeft
    	
    	checkIfValsAreEqualMergeRowRight:
    	srl $t9, $t9, 16
    	beq $t8, $t9, mergeValuesInRowRight
    	addi $t1, $t1, -1 #increment col counter
    	j mergeRightLeft
    	
    	mergeValuesInRowRight:
    	mul $t8, $t8, $t2 #mult by 2
    	sh $t8, 0($t6) #stores on right side
    	li $t6, -1
    	sh $t6, 0($t4) #store -1 on left
    	addi $t1, $t1, -1 #increment col counter
    	j mergeRightLeft
    
    ############################################
    errorInMergeRow:
    li $v0, -1
    jr $ra
    
    successMergeRow:
    li $t1, 0 #j
    li $t6, 0 #non empty values counter
    
    	loopFindNonEmptyValues:
        li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	sll $t8, $t8, 16
    	
    	beq $t1, $a2, exitMergeRow #stopping condition
    	bge $t8, $t2, incrementnumValuesMergeRow #if value is >= 2
    	addi $t1, $t1, 1 #increment col counter
    	j loopFindNonEmptyValues
    	
    	incrementnumValuesMergeRow:
    	addi $t6, $t6, 1 #increment value counter
    	addi $t1, $t1, 1 #increment col counter
    	j loopFindNonEmptyValues
    	
    	
    exitMergeRow:
    move $v0, $t6 #returns num of non empty values
    jr $ra
    

merge_col:
    #Define your code here
    ############################################
 
    lw $t0, 0($sp) #loads direction
    blt $t0, $0, errorInMergeCol #checks if dir < 0
    li $t1, 1
    bgt $t0, $t1, errorInMergeCol #checks if dir > 1
    ##addi $a3, $a3, -1 #for convience (col#)
    #CHECK A3 OUTSIDE OF RANGE
    li $t1, 2
    blt $a1, $t1, errorInMergeCol #if num rows < 2
    blt $a2, $t1, errorInMergeCol #if num cols < 2
    bltz $a3, errorInMergeCol 
    addi $a2, $a2, -1
    bgt $a3, $a2, errorInMergeCol #checks if col index is bigger than or = to num cols
    addi $a2, $a2, 1
    li $t1, 0 #row counter (i)
    
    beqz $t0, SKIPmergeColTop #check value of dir (0 is bot-top, 1 is top-bot)
    
    mergeTopBot: #1 (t3 is address of 1st val(bot), t4 has 2nd val(top))
        li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * col#)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * col#) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t5, $t3 #makes copy
    	sll $t8, $t8, 16
    
    	addi $t1, $t1, 1 #add 1 to get next element too
    	bge $t1, $a1, successMergeCol #a1 is num rows: checks if next value is out of bounds (stopping condition)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i+1
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	addi $t1, $t1, -1 #puts it back
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i+1) + (sizeof(obj) * col#)
    	add $t4, $a0, $t3 # base_address + (num cols * sizeof(obj) * i+1) + (sizeof(obj) * row#) 
    	lhu $t9, 0($t4) #gets value at specified location +1 (2nd value)
    	sll $t9, $t9, 16
    	
    	bgt $t8, $0, checkNextValForMergeColTop #checks if 1st value isn't -1
    	addi $t1, $t1, 1 #increment row counter
    	j mergeTopBot
    	
    	checkNextValForMergeColTop:
    	srl $t8, $t8, 16
    	bgt $t9, $0, checkIfValsAreEqualMergeColTop
    	addi $t1, $t1, 1 #increment row counter
    	j mergeTopBot
    	
    	checkIfValsAreEqualMergeColTop:
    	srl $t9, $t9, 16
    	beq $t8, $t9, mergeValuesInColTop
    	addi $t1, $t1, 1 #increment row counter
    	j mergeTopBot
    	
    	mergeValuesInColTop:
    	mul $t8, $t8, $t2 #mult by 2
    	sh $t8, 0($t5) #stores on top 
    	li $t6, -1
    	sh $t6, 0($t4) #store -1 on bot
    	addi $t1, $t1, 1 #increment row counter
    	j mergeTopBot
    	
    SKIPmergeColTop:
    addi $a1, $a1, -1
    move $t1, $a1 #set index to last cell in col
    addi $a1, $a1, 1 #put back
    	
    mergeBotTop: #0
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * col#)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * col#) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t5, $t3 #makes copy
    	sll $t8, $t8, 16
    
    	addi $t1, $t1, -1 #sub 1 to get next element too
    	bltz $t1, successMergeCol #checks if next value is out of bounds (stopping condition)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i-1
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	addi $t1, $t1, 1 #puts it back
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i-1) + (sizeof(obj) * col#)
    	add $t4, $a0, $t3 # base_address + (num cols * sizeof(obj) * i-1) + (sizeof(obj) * row#) 
    	lhu $t9, 0($t4) #gets value at specified location -1 (2nd value)
    	sll $t9, $t9, 16
    	
    	bgt $t8, $0, checkNextValForMergeColBot #checks if 1st value isn't -1
    	addi $t1, $t1, -1 #increment row counter
    	j mergeBotTop
    	
    	checkNextValForMergeColBot:
    	srl $t8, $t8, 16
    	bgt $t9, $0, checkIfValsAreEqualMergeColBot
    	addi $t1, $t1, -1 #increment row counter
    	j mergeBotTop
    	
    	checkIfValsAreEqualMergeColBot:
    	srl $t9, $t9, 16
    	beq $t8, $t9, mergeValuesInColBot
    	addi $t1, $t1, -1 #increment row counter
    	j mergeBotTop
    	
    	mergeValuesInColBot:
    	mul $t8, $t8, $t2 #mult by 2
    	sh $t8, 0($t5) #stores on bot
    	li $t6, -1
    	sh $t6, 0($t4) #store -1 on top
    	addi $t1, $t1, -1 #increment row counter
    	j mergeBotTop
    
    ############################################
    errorInMergeCol:
    li $v0, -1
    jr $ra
    
    successMergeCol:
    li $t1, 0 #i
    li $t6, 0 #non empty values counter
    
    	loopFindNonEmptyValuesCol:
        li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * col#)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * col#) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	sll $t8, $t8, 16
    	
    	beq $t1, $a1, exitMergeCol #stopping condition
    	bge $t8, $t2, incrementnumValuesMergeCol #if value is >= 2
    	addi $t1, $t1, 1 #increment row counter
    	j loopFindNonEmptyValuesCol
    	
    	incrementnumValuesMergeCol:
    	addi $t6, $t6, 1 #increment value counter
    	addi $t1, $t1, 1 #increment row counter
    	j loopFindNonEmptyValuesCol
    	
    	
    exitMergeCol:
    move $v0, $t6 #returns num of non empty values
    jr $ra
    ############################################
    jr $ra

shift_row:
    #Define your code here
    ############################################
    
    lw $t0, 0($sp) #loads direction
    blt $t0, $0, errorInShiftRow #checks if dir < 0
    li $t1, 1
    bgt $t0, $t1, errorInShiftRow #checks if dir > 1
    bltz $a3, errorInShiftRow 
    addi $a1, $a1, -1
    bgt $a3, $a1, errorInShiftRow #checks if row index is bigger than num rows
    addi $a1, $a1, 1 
    li $t1, 2
    blt $a1, $t1, errorInShiftRow #if num rows < 2
    blt $a2, $t1, errorInShiftRow #if num cols < 2
    
    bnez $t0, SKIPshiftRowLeft #checks if dir is not 0 (which means shift right -> 1)
    li $t1, 0 #index counter (j)
    li $t0, 0 #cells shifted counter
    li $t5, 0
    
    shiftRowLeft: # dir == 0
    	addi $a2, $a2, -1
    	bgt $t1, $a2, successShiftRow #if counter j is greater than num cols
    	addi $a2, $a2, 1 #put it back
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t7, $t8 #make copy 
    	sll $t8, $t8, 16
    	
    	beqz $t1, checkFirstIndexShiftRowLeft #if counter is at first run, check first cell
    	j continueShiftRowLeft
    	
    	checkFirstIndexShiftRowLeft:
    	bltz $t8, firstIndexIsEmptyShiftRowLeft
    	addi $t1, $t1, 1 #increment j (GOES HERE IF 1ST INDEX ISN"T EMPTY)
    	j shiftRowLeft
    	
    	firstIndexIsEmptyShiftRowLeft:
    	move $t5, $t3 #makes copy of empty cell in first index
    	addi $t1, $t1, 1 #ncrement j
    	j shiftRowLeft
    	
    	continueShiftRowLeft:
    	bltz $t8, indexIsEmptyShiftRowLeft
    	bgtz $t7, swapShiftRowLeft
    	j swapShiftRowLeft
    	
    	consecutiveValuesShiftRowLeft:
    	addi $t1, $t1, 1
    	j shiftRowLeft
    	
    	swapShiftRowLeft:
    	beqz $t5, consecutiveValuesShiftRowLeft #this will be false if empt cell address has already been stored
    	li $t9, -1
    	srl $t8, $t8, 16
    	sh $t9, 0($t3) # (GOES HERE IF CELL ISN'T EMPTY) stores -1 where value is
    	sh $t8, 0($t5) #stores value where empty cell was
    	addi $t5, $t5, 2 #gets next value
    	addi $t0, $t0, 1 #increment cells shifted counter
    	j shiftRowLeft
    	
    	indexIsEmptyShiftRowLeft:
    	blt $t3, $t5 keepEarliestIndexLeft #check to see which is the lowest value
    	beqz $t5, keepEarliestIndexLeft #in case base address doesn't start with 0xffff0000
    	addi $t1, $t1, 1 #increment j
    	j shiftRowLeft
    	
    	keepEarliestIndexLeft:
    	move $t5, $t3 #makes copy of empty cell in current index
    	addi $t1, $t1, 1 #increment j
    	j shiftRowLeft
    	
    		
    SKIPshiftRowLeft:	
    addi $a2, $a2, -1 #take 1 away from num cols to get index
    move $t1, $a2 #sets counter j to last index of row
    addi $a2, $a2, 1 #put it back
    li $t0, 0 #cells shifted counter
    li $t5, 0
    
    shiftRowRight: #dir == 1
    	bltz $t1, successShiftRow #if counter j is greater than num cols
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $a3, #num cols * sizeof(obj) * row#
    	mul $t4, $t2, $t1 #sizeof(obj) * j
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * row#) + (sizeof(obj) * j)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * row#) + (sizeof(obj) * j) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t7, $t8 #make copy 
    	sll $t8, $t8, 16
    	
    	addi $a2, $a2, -1 #take 1 away from num cols to get index
    	beq $t1, $a2, checkFirstIndexShiftRowRight #if counter is at first run, check first cell
    	addi $a2, $a2, 1 #put it back
    	j continueShiftRowRight
    	
    	checkFirstIndexShiftRowRight:
    	addi $a2, $a2, 1 #put it back
    	bltz $t8, firstIndexIsEmptyShiftRowRight
    	addi $t1, $t1, -1 #increment j (GOES HERE IF 1ST INDEX ISN"T EMPTY)
    	j shiftRowRight
    	
    	firstIndexIsEmptyShiftRowRight:
    	move $t5, $t3 #makes copy of empty cell in first index
    	addi $t1, $t1, -1 #ncrement j
    	j shiftRowRight
    	
    	continueShiftRowRight:
    	bltz $t8, indexIsEmptyShiftRowRight
    	bgtz $t7, swapShiftRowRight
    	j swapShiftRowRight
    	
    	consecutiveValuesShiftRowRight:
    	addi $t1, $t1, -1
    	j shiftRowRight
    	
    	swapShiftRowRight:
    	beqz $t5, consecutiveValuesShiftRowRight #this will be false if empt cell address has already been stored
    	li $t9, -1
    	srl $t8, $t8, 16
    	sh $t9, 0($t3) # (GOES HERE IF CELL ISN'T EMPTY) stores -1 where value is
    	sh $t8, 0($t5) #stores value where empty cell was
    	addi $t5, $t5, -2 #gets next value
    	addi $t0, $t0, 1 #increment cells shifted counter
    	j shiftRowRight
    	
    	indexIsEmptyShiftRowRight:
    	bgt $t3, $t5 keepEarliestIndexRight #check to see which is the lowest value
    	beqz $t5, keepEarliestIndexRight #fixes 1 edge case
    	addi $t1, $t1, -1 #increment j
    	j shiftRowRight
    	
    	keepEarliestIndexRight:
    	move $t5, $t3 #makes copy of empty cell in current index
    	addi $t1, $t1, -1 #increment j
    	j shiftRowRight
    	
    ############################################
    errorInShiftRow:
    li $v0, -1
    jr $ra
    
    successShiftRow:
    move $v0, $t0 #move cells shifted to return
    jr $ra

shift_col:
    #Define your code here
    ############################################
    
    lw $t0, 0($sp) #loads direction
    blt $t0, $0, errorInShiftCol #checks if dir < 0
    li $t1, 1
    bgt $t0, $t1, errorInShiftCol #checks if dir > 1
    bltz $a3, errorInShiftCol #if index col < 0
    addi $a2, $a2, -1
    bgt $a3, $a2, errorInShiftCol #checks if col index is bigger than num cols
    addi $a2, $a2, 1 
    li $t1, 2
    blt $a1, $t1, errorInShiftCol #if num rows < 2
    blt $a2, $t1, errorInShiftCol #if num cols < 2
    
    bnez $t0, SKIPshiftColUp #checks if dir is not 0 (which means shift down -> 1)
    li $t1, 0 #index counter (i)
    li $t0, 0 #cells shifted counter
    li $t5, 0
    
    shiftColUp:
    	addi $a1, $a1, -1
    	bgt $t1, $a1, successShiftCol #if counter i is greater than num rows
    	addi $a1, $a1, 1 #put it back
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * col#)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * col#) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t7, $t8 #make copy 
    	sll $t8, $t8, 16
    	
    	beqz $t1, checkFirstIndexShiftColUp #if counter is at first run, check first cell
    	j continueShiftColUp
    	
    	checkFirstIndexShiftColUp:
    	bltz $t8, firstIndexIsEmptyShiftColUp
    	addi $t1, $t1, 1 #increment i (GOES HERE IF 1ST INDEX ISN"T EMPTY)
    	j shiftColUp
    	
    	firstIndexIsEmptyShiftColUp:
    	move $t5, $t3 #makes copy of empty cell in first index
    	addi $t1, $t1, 1 #increment i
    	j shiftColUp
    	
    	continueShiftColUp:
    	bltz $t8, indexIsEmptyShiftColUp
    	bgtz $t7, swapShiftColUp
    	j swapShiftColUp
    	
    	consecutiveValuesShiftColUp:
    	addi $t1, $t1, 1
    	j shiftColUp
    	
    	swapShiftColUp:
    	beqz $t5, consecutiveValuesShiftColUp #this will be false if empt cell address has already been stored
    	li $t9, -1
    	srl $t8, $t8, 16
    	sh $t9, 0($t3) # (GOES HERE IF CELL ISN'T EMPTY) stores -1 where value is
    	sh $t8, 0($t5) #stores value where empty cell was
    	
    	move $t4, $t5 ##BLOCK THAT GETS NEXT VALUE
    	li $t2, 2
    	mul $t5, $a2, $t2
    	add  $t5, $t5, $t4 #gets next value
    	addi $t0, $t0, 1 #increment cells shifted counter
    	j shiftColUp
    	
    	indexIsEmptyShiftColUp:
    	blt $t3, $t5 keepEarliestIndexUp #check to see which is the lowest value
    	beqz $t5, keepEarliestIndexUp #in case base address doesn't start with 0xffff0000
    	addi $t1, $t1, 1 #increment i
    	j shiftColUp
    	
    	keepEarliestIndexUp:
    	move $t5, $t3 #makes copy of empty cell in current index
    	addi $t1, $t1, 1 #increment i
    	j shiftColUp
   
    SKIPshiftColUp:
    addi $a1, $a1, -1 #take 1 away from num cols to get index
    move $t1, $a1 #sets counter j to last index of row
    addi $a1, $a1, 1 #put it back
    li $t0, 0 #cells shifted counter
    li $t5, 0
    
    shiftColDown:
    	bltz $t1, successShiftCol #stopping condition
    	li $t2, 2 #sizeof(obj)
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
    	mul $t3, $t3, $t1, #num cols * sizeof(obj) * i
    	mul $t4, $t2, $a3 #sizeof(obj) * col#
    	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * col#)
    	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * col#) 
    	lhu $t8, 0($t3) #gets value at specified location, (1st value)
    	move $t7, $t8 #make copy 
    	sll $t8, $t8, 16
    	
    	addi $a1, $a1, -1
    	beq $t1, $a1, checkFirstIndexShiftColDown #if counter is at first run, check first cell
    	addi $a1, $a1, 1 #put back
    	j continueShiftColDown
    	
    	checkFirstIndexShiftColDown:
    	addi $a1, $a1, 1
    	bltz $t8, firstIndexIsEmptyShiftColDown
    	addi $t1, $t1, -1 #increment i (GOES HERE IF 1ST INDEX ISN"T EMPTY)
    	j shiftColDown
    	
    	firstIndexIsEmptyShiftColDown:
    	move $t5, $t3 #makes copy of empty cell in first index
    	addi $t1, $t1, -1 #increment i
    	j shiftColDown
    	
    	continueShiftColDown:
    	bltz $t8, indexIsEmptyShiftColDown
    	bgtz $t7, swapShiftColDown
    	j swapShiftColUp
    	
    	consecutiveValuesShiftColDown:
    	addi $t1, $t1, -1
    	j shiftColDown
    	
    	swapShiftColDown:
    	beqz $t5, consecutiveValuesShiftColDown #this will be false if empt cell address has already been stored
    	li $t9, -1
    	srl $t8, $t8, 16
    	sh $t9, 0($t3) # (GOES HERE IF CELL ISN'T EMPTY) stores -1 where value is
    	sh $t8, 0($t5) #stores value where empty cell was
    	
    	move $t4, $t5 ##BLOCK THAT GETS NEXT VALUE
    	li $t2, 2
    	mul $t5, $a2, $t2
    	sub  $t5, $t4, $t5 #gets next value
    	addi $t0, $t0, 1 #increment cells shifted counter
    	j shiftColDown
    	
    	indexIsEmptyShiftColDown:
    	bgt $t3, $t5 keepEarliestIndexUp #check to see which is the lowest value
    	beqz $t5, keepEarliestIndexDown #in case base address doesn't start with 0xffff0000
    	addi $t1, $t1, -1 #increment i
    	j shiftColDown
    	
    	keepEarliestIndexDown:
    	move $t5, $t3 #makes copy of empty cell in current index
    	addi $t1, $t1, -1 #increment i
    	j shiftColDown
    
    ############################################
    errorInShiftCol:
    li $v0, -1
    jr $ra
    
    successShiftCol:
    move $v0 ,$t0
    jr $ra

check_state:
    #Define your code here
    ############################################
    li $t0, 0 #row counter (i)
    li $t1, 0 #column counter (j)
    li $t2, 2 #sizeof(obj)
    li $t9, 2048 #target 
    
    checkIfWin:
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
	mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
	mul $t4, $t2, $t1 #sizeof(obj) * j
	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
	beq $t1, $a2, incremNumRowsCheckWin #if col counter == num col, increment row
	lh $t5, 0($t3) #loads cell
	bge $t5, $t9, checkStateWinGame #2048 or greater has been found
	addi $t1, $t1, 1 #increment col count
	j checkIfWin
		
	incremNumRowsCheckWin:
	addi $a1, $a1, -1 #for convience (num rows)
	beq $t0, $a1, reinitToCheckRows #checks if row count == num row (stopping condition of loop)
	addi $a1, $a1, 1 #put it back (num rows)
	li $t1, 0 #reset col counter
	addi $t0, $t0, 1 #increment row counter	
    	j checkIfWin
    
    reinitToCheckRows:
    li $t0, 0 #row counter (i)
    li $t1, 0 #column counter (j)
    li $t2, 2 #sizeof(obj)
    li $t9, 2048 #target 
    
    checkStateOfRows:
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
	mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
	mul $t4, $t2, $t1 #sizeof(obj) * j
	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
	beq $t1, $a2, incremNumRowsCheckRow #if col counter == num col, increment row
	lh $t5, 0($t3) #loads cell
	bge $t5, $t9, checkStateWinGame #2048 or greater has been found
	bltz $t5, checkStateMovePossible #checks if value < 0, means if empty cell found, you can do something 
	
	addi $t1, $t1, 1 #increment col count
	
	mul $t3, $a2, $t2 #num cols * sizeof(obj)
	mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
	mul $t4, $t2, $t1 #sizeof(obj) * j
	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
	beq $t1, $a2, incremNumRowsCheckRow #if col counter == num col, increment row
	addi $t1, $t1, -1 #put it back
	lh $t4, 0($t3) #loads cell
	bge $t4, $t9, checkStateWinGame #2048 or greater has been found
	bltz $t4, checkStateMovePossible #checks if value <0, means if empty cell found, you can do something
	bge $t4, $t9, checkStateWinGame #2048 or greater has been found
	beq $t5, $t4, checkStateMovePossible #checks if a merge is possible
	addi $t1, $t1, 1 #increment col count
	j checkStateOfRows
		
	incremNumRowsCheckRow:
	addi $a1, $a1, -1 #for convience (num rows)
	beq $t0, $a1, reInitToCheckCols #checks if row count == num row (stopping condition of loop)
	addi $a1, $a1, 1 #put it back (num rows)
	li $t1, 0 #reset col counter
	addi $t0, $t0, 1 #increment row counter	
    	j checkStateOfRows
    
    reInitToCheckCols:	
    li $t0, 0 #row counter (i)
    li $t1, 0 #column counter (j)
    li $t2, 2 #sizeof(obj)
    	
    checkStateOfColumns:	
    	mul $t3, $a2, $t2 #num cols * sizeof(obj)
	mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
	mul $t4, $t2, $t1 #sizeof(obj) * j
	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
	beq $t0, $a1, incremNumColsCheckCol #if row counter == num rows, increment col
	lh $t5, 0($t3) #loads cell
	bge $t5, $t9, checkStateWinGame #2048 or greater has been found
	bltz $t5, checkStateMovePossible #checks if value < 0, means if empty cell found, you can do something 
	addi $t0, $t0, 1 #increment row count
	
	mul $t3, $a2, $t2 #num cols * sizeof(obj)
	mul $t3, $t3, $t0, #num cols * sizeof(obj) * i
	mul $t4, $t2, $t1 #sizeof(obj) * j
	add $t3, $t3, $t4 #(num cols * sizeof(obj) * i) + (sizeof(obj) * j)
	add $t3, $a0, $t3 # base_address + (num cols * sizeof(obj) * i) + (sizeof(obj) * j) 
	beq $t0, $a1, incremNumColsCheckCol #if row counter == num rows, increment col
	addi $t0, $t0, -1 #put it back
	lh $t4, 0($t3) #loads cell
	bge $t4, $t9, checkStateWinGame #2048 or greater has been found
	bltz $t4, checkStateMovePossible #checks if value <0, means if empty cell found, you can do something
	bge $t4, $t9, checkStateWinGame #2048 or greater has been found
	beq $t5, $t4, checkStateMovePossible #checks if a merge is possible
	addi $t0, $t0, 1 #increment col count
	j checkStateOfColumns
		
	incremNumColsCheckCol:
	addi $a2, $a2, -1 #for convience (num rows)
	beq $t1, $a2, checkStateLossGame #checks if col count == num cols (stopping condition of loop)
	addi $a2, $a2, 1 #put it back (num rows)
	li $t0, 0 #reset row counter
	addi $t1, $t1, 1 #increment col counter	
    	j checkStateOfColumns
    
    ############################################
    checkStateWinGame:
    li $v0, 1 #if a cell has value >= 2048
    jr $ra
    
    checkStateLossGame:
    li $v0, -1 #if not adjacent cells can be moved
    jr $ra
    
    checkStateMovePossible:
    li $v0, 0 #if an empty cell is present/ if two adajcent values are =, you can doing something
    jr $ra

user_move:
    #Define your code here
    ############################################
    addi $sp, $sp, -24
    sw $ra, 0($sp) #store ra
    sw $a0, 4($sp) #board
    sw $a1, 8($sp) #num rows
    sw $a2, 12($sp) #num cols
    sw $a3, 16($sp) #dir
    li $t1, 0 #row/col index counter
    
    li $t0, 'L'
    beq $t0, $a3, userMoveLeft #merge/shift: 0
    li $t0, 'R'
    beq $t0, $a3, userMoveRight #merge/shift: 1
    li $t0, 'U'
    beq $t0, $a3, userMoveUp #merge 1: shift: 0
    li $t0, 'D'
    beq $t0, $a3, userMoveDown #merge: 0, shift: 1
    j errorUserMove #goes here if invalid character is used
    
    userMoveLeft: #merge/shift: 0
    	addi $a1, $a1, -1 #checking if counter exceeds index of row 
    	bgt $t1, $a1, userMoveCallCheckState
    	addi $a1, $a1, 1 #put back
    	
    	sw $t1, 20($sp) #store counter
    	addi $sp, $sp, -4
    	li $t3, 0
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	jal shift_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	jal merge_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	jal shift_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	
    	bltz $v0, errorUserMove
    	addi $t1, $t1, 1 #increment row counter
    	
    j userMoveLeft
    
    userMoveRight: #merge/shift: 1
    
    	addi $a1, $a1, -1 #checking if counter exceeds index of row 
    	bgt $t1, $a1, userMoveCallCheckState
    	addi $a1, $a1, 1 #put back
    	
    	sw $t1, 20($sp) #store counter
    	addi $sp, $sp, -4
    	li $t3, 1
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	jal shift_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	jal merge_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	jal shift_row #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	
    	bltz $v0, errorUserMove
    	addi $t1, $t1, 1 #increment row counter
    
    j userMoveRight
    
    userMoveUp: #merge 1: shift: 0
    
    	addi $a2, $a2, -1 #checking if counter exceeds index of col 
    	bgt $t1, $a2, userMoveCallCheckState
    	addi $a2, $a2, 1 #put back
    	
    	sw $t1, 20($sp) #store counter
    	addi $sp, $sp, -4
    	li $t3, 0 #for shift
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	jal shift_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	addi $sp, $sp, -4
    	li $t3, 1 #for merge
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	
    	jal merge_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	li $t3, 0 #for shift
    	sw $t3, 0($sp) #store at top for next func
    	jal shift_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	
    	bltz $v0, errorUserMove
    	addi $t1, $t1, 1 #increment row counter
    
    j userMoveUp
    
    userMoveDown: #merge: 0, shift: 1
    	addi $a2, $a2, -1 #checking if counter exceeds index of col 
    	bgt $t1, $a2, userMoveCallCheckState
    	addi $a2, $a2, 1 #put back
    	
    	sw $t1, 20($sp) #store counter
    	addi $sp, $sp, -4
    	li $t3, 1 #for shift
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	jal shift_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	addi $sp, $sp, -4
    	li $t3, 0 #for merge
    	sw $t3, 0($sp) #store at top for next func
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	
    	jal merge_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	move $a3, $t1 #move index counter to a3
    	
    	bltz $v0, errorUserMove
    	addi $sp, $sp, -4
    	li $t3, 1 #for shift
    	sw $t3, 0($sp) #store at top for next func
    	jal shift_col #a0: board, a1: num rows, a2: num cols, a3: row index, stackt[0]: dir
    	addi $sp, $sp, 4
    	lw $ra, 0($sp) #load ra
    	lw $a0, 4($sp) #board
    	lw $a1, 8($sp) #num rows
    	lw $a2, 12($sp) #num cols
    	lw $t1, 20($sp) #load counter
    	
    	bltz $v0, errorUserMove
    	addi $t1, $t1, 1 #increment row counter
    
    j userMoveDown
    
    userMoveCallCheckState:
    lw $a0, 4($sp) #board
    lw $a1, 8($sp) #num rows
    lw $a2, 12($sp) #num cols
    jal check_state
    lw $ra, 0($sp) #load ra
    j successUserMove
    
    ############################################
    errorUserMove: #goes here if invalid dir or any function had an error
    li $v0, -1
    li $v1, -1
    jr $ra
    
    successUserMove: #return 0 and return of check State
    move $v1, $v0 #return of check state
    li $v0, 0
    jr $ra

#################################################################
# Student defined data section
#################################################################
.data
.align 2  # Align next items to word boundary

#place all data declarations here


