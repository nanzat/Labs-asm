Stack_Size EQU 0x400
bottom_of_stack EQU 0x20000000
top_of_stack EQU bottom_of_stack + Stack_Size
	
SAR EQU 0x42000000 ; Start Alias Region
RCC EQU 0x40021000
	
; registers addresses
RCC_CR EQU RCC+0x0
RCC_CFGR EQU RCC+0x4
	
; bits numbers
HSEON EQU 16
HSION EQU 0
HSERDY EQU 17
HSIRDY EQU 1
PLLSRC EQU 16
PLLMUL EQU 18
PLLON EQU 24
PLLRDY EQU 25
SW EQU 1
SWS EQU 2

	AREA RESET, DATA, READONLY
	DCD top_of_stack ;Top of Stack
	DCD Start
	AREA MY_CODE, CODE, READONLY
	ENTRY

Start
InitClock

	mov r9, #1
	ldr r0, =SAR+(RCC_CR&0x00FFFFFF)*0x20+HSEON*4		
	str r9,[r0]
	ldr r0, =RCC_CR
	
wait_hserdy
	ldr r10,[r0]
	tst r10,#(1<<HSERDY)
	beq wait_hserdy
	
	ldr r0,=RCC_CFGR
	ldr r10,=(1<<PLLSRC) + (1<<PLLMUL)
	str r10,[r0]
	
	ldr r0,=SAR+(RCC_CR&0x00FFFFFF)*0x20+PLLON*4
	str r9,[r0]
	ldr r0, =RCC_CR
	
wait_pllrdy
	ldr r10,[r0]
	tst r10, #(1<<PLLRDY)
	beq wait_pllrdy
	
	ldr r0,=SAR+(RCC_CFGR&0x00FFFFFF)*0x20+SW*4;
	mov r10, #1; why sw == 01
	str r10,[r0]
	
	ldr r0,=SAR+(RCC_CFGR&0x00FFFFFF)*0x20+SWS*4
	ldr r6, [r0]; sws?
	tst r6, #(2<<SWS)
	
	
	mov r2, #0	
	mov r3, #0
	mov r4, #4800
	mov r5, #2745
	
delay
	add r3, r3, #1; hse how much MHz?
	cmp r3, r4
	bcc delay
	
	add r2, r2, #1
	mov r3, #0
	
	cmp r2, r5
	
	bcs finish
	b delay
	
	
	
finish
	NOP
	NOP
	NOP
	END
	B .
	