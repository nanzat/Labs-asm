stack_size equ 0x400
bottom equ 0x20000000
x equ 10
y equ 20
z equ 30
const equ 0x123456
top equ stack_size+bottom

	area reset, data, readonly
	dcd top
	dcd start 

	area my_code, code, readonly
	entry

start proc
	;1 part
	ldr r0, =x
	ldr r1, =y
	ldr r2, =z
	mov r3, #4
	
	mul r2 , r2, r3
	
	lsr r0, #1
	
	adds r1, r1, r2 
	subs r1, r1, r0
	
	;2 part
	
	ldr r4, =const
	
	orr r4, r4, #0x1
	and r4, r4, #0xFFFFFFF9 ; 0b1111 1111 1111 1111 1111 1111 1111 1001
	
	ror r4, r4, #2
	
	
	
	endp
	end
	
	