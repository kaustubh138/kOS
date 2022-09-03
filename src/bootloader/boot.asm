org 0x7C00
bits 16

jmp main

%include "src/bootloader/PrintString.asm"

main:
    mov si, msg_hello
    call PrintString
    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello kOS!', ENDL, 0

times 510-($-$$) db 0

dw 0AA55h