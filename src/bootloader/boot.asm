org 0x7C00
bits 16

jmp main

%include "src/bootloader/PrintString.asm"
%include "src/bootloader/DiskRead.asm"

KERNEL_LOCATION equ 0x7e00	; Kernel start location

main:
    xor ax, ax			    ; clear bits of ax
    mov es, ax			    ; set es to 0
    mov ds, ax			    ; set ds to 0

    mov bx, KERNEL_LOCATION	; location to read from es:bx
    mov dh, 20			    ; read 20 sectors (blank sectors: empty_end)

    mov [BOOT_DISK], dl     ; Store the boot disk number
    
    mov si, msg_hello
    call PrintString
    
    call DiskRead

    ; Check read
    mov si, ax
    call PrintString

    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello kOS!', ENDL, 0

times 510-($-$$) db 0

dw 0AA55h