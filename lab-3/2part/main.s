size equ 0x400
bottom equ 0x20000000
top equ size+bottom

	area reset, data, readonly
	dcd top
	dcd start
	
	area my_code, code, readonly
		
	entry
start proc
	mov r0, #0xF0F0F0F
	mov r1, #2
for
	cmp r1, #12
	bcs _end
	
	mov r2, r0
	
	lsr r2, #2
	add r2, #2
	add r0, r2
	add r1, #1
	b for
_end	
	endp
	end