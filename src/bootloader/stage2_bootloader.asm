[org 0x7e00]

jmp EnterProtectedMode

%include "src/bootloader/gdt.asm"

; Switch to 32-bit protected mode:
; Refernece: https://wiki.osdev.org/Protected_Mode
; Before switching to protected mode, you must:
;   Step 1: Disable interrupts, including NMI (as suggested by Intel Developers Manual).
;   Step 2: Enable the A20 Line.
;   Step 3: Load the Global Descriptor Table with segment descriptors suitable for code, data, and stack.

EnterProtectedMode:
    call EnableA20  ; Step 2 if not enabled already
    cli             ; Step 1
    lgdt [gdt_descriptor]
    mov eax, cr0 
    or eax, 1       ; set PE (Protection Enable) bit in CR0 (Control Register 0)
    mov cr0, eax
    jmp code_seg:StartProtectedMode

EnableA20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

[bits 32]

StartProtectedMode: 
    mov ax, data_seg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb8000], byte 'k'
    mov [0xb8002], byte 'O'
    mov [0xb8004], byte 'S'

    jmp $

times 2048-($-$$) db 0
