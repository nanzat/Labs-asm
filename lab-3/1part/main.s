size equ 0x400
bottom equ 0x20000000
top equ size+bottom

	area reset, data, readonly
	dcd top
	dcd start
	
	area my_code, code, readonly
		
	entry
start proc
	mov r0, #3
	mov r1, #-2
	mov r2, #1
	
	cmp r0, #3; a==3
	beq first
	bne _else
	
first

	cmp r1, #-2; b==-2
	beq second
	bne _else

second

	cmp r2, #1; c==1
	beq third
	bne _else
	
third 
	
	mov r4, #4
	mov r5, #2
	mul r2, r2, r4
	
	add r1, r1, r2
	
	sdiv r0, r0, r5
	
	sub r1, r1, r0
	b _end
	
_else
	mov r3, #1	
	
_end
	endp
	end