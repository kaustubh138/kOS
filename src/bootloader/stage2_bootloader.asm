[org 0x7e00]

mov si, Stage2Sucess
call PrintString

cli
hlt

Stage2Sucess: db "[INFO ] In Stage 2 Bootloader", 0x0D, 0x0A

%include "src/bootloader/utils/PrintString.asm"

times 2048-($-$$) db 0
