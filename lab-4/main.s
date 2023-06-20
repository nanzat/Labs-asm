const equ 0x20000150
size equ 0x400
bottom equ 0x20000000
top equ size+bottom
	
	area RESET, data, readonly
	dcd top
	dcd start
		
	area array, data, readonly
	dcd 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
		
	area my_code, code, readonly
	entry
start proc
	mov r0, #0
	ldr r2, =array
	ldr r3, =0x20000150
	
while
	cmp r0, #10
	bcs _next
	ldr r1, [r2]
	str r1, [r3]
	add r2, #4
	add r3, #4
	add r0, #1
	b while
_next

	ldr r3, =0x20000150
	mov r0, #0
	
_while
	cmp r0, #5
	bcs __next
	ldrd r5, r6, [r3]
	strd r6, r5, [r3]
	add r3, #8
	add r0, #1
	b _while
__next

	ldr r1, =0x20000150
	mov r0, #0
	
_while1
	cmp r0, #10
	bcs _next1
	ldr r2, [r1]
	push {r2}
	
	add r0, #1
	add r1, #4
	b _while1
_next1

	ldr r1, =0x20000150
	mov r0, #0
	
_while2
	cmp r0, #10
	bcs _next2
	pop {r2}
	str r2, [r1]
		
	add r0, #1
	add r1, #4
	b _while2
_next2

	endp
	end
	
