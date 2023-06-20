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
	
	AREA INIT,CODE,READONLY
RCC_INIT PROC
	mov r9, #1
	ldr r0, =SAR+(RCC_CR&0x00FFFFFF)*0x20+HSEON*4
	str r9,[r0]
	ldr r0, =RCC_CR
	
wait_hserdy
	ldr r10,[r0]
	tst r10,#(1<<HSEON)
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
	
	ldr r0,=SAR+(RCC_CFGR&0x00FFFFFF)*0x20+SW*4
	str r9,[r0]
	
	BX LR
	ENDP
		
	EXPORT RCC_INIT
	END