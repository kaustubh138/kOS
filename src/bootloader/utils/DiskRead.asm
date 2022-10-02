%ifndef READ_DISK_ASM
%define READ_DISK_ASM

%include "src/bootloader/utils/PrintString.asm"

PROGRAM_SPACE equ 0x7e00	    ; Stage 2 Bootloader start location

; Refrence: https://wiki.osdev.org/Disk_access_using_the_BIOS_(INT_13h)

;
; Reads from disk using Cylinder, Head, Sector (CHS) Addressing from es:bx location
; Usage: 
;   - Location to read from    : es:bx
;   - Number of secotrs to read: dh
;
DiskRead:
    .loop:
        mov ah, 0x02            ; BIOS read from disk routine
        mov al, dh              ; number of segments 

        mov ch, 0x00            ; track/cylinder 0
        mov dh, 0x00            ; head 0
        mov cl, 0x02            ; sector 2 after boot sector
        
        mov dl, [BOOT_DISK] 

        int 0x13                ; read disk BIOS interrupt

        jc DiskReadError        ; carry flag contains error code

        cmp ah, 0               
        jne .loop            ; return code

    mov si, DiskReadSuccessMsg
    call PrintString

    ret

DiskReadSuccessMsg: db '[INFO ] Disk Read Successful', ENDL, 0 
DiskReadErrorMsg:   db '[ERROR] An error occured while reading from disk!', ENDL, 0

DiskReadError:
    mov si, DiskReadErrorMsg
    call PrintString

    jmp $

BOOT_DISK: db 0

%endif