stack_size equ 0x400
bottom equ 0x20000000
top equ stack_size+bottom
var  EQU  2979594848
  AREA RESET, DATA, READONLY
  DCD	top
  DCD   Start
  AREA  MY_CODE, CODE, READONLY 
  ENTRY
Start    PROC
  LDR  R0, = var
  LDR  R1, = (var&0xFF)
  LDR  R2, = (var&0xFF00)
  LDR  R3, = (var&0xFF0000)
  LDR  R4, = (var&0xFF000000)

  LSR  R2, #8
  LSR  R3, #16
  LSR  R4, #24

  NOP
  ENDP
  END
