[org 0x7C00]
[bits 16]

mov [BOOT_DISK], dl

mov bp, 0x7c00
mov sp, bp

mov si, msg_hello
call PrintString

mov bx, PROGRAM_SPACE
mov dh, 3
call DiskRead

jmp PROGRAM_SPACE

%include "src/bootloader/utils/PrintString.asm"
%include "src/bootloader/utils/DiskRead.asm"

msg_hello: db '[INFO ] Welcome to kOS!', 0x0D, 0x0A, 0

times 510-($-$$) db 0

dw 0xaa55