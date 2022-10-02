%ifndef PRINT_STRING_ASM
%define PRINT_STRING_ASM

%define ENDL 0x0D, 0x0A

;
; Prints the message to the screen
; Params:
; 	- ds:si or ds:edi register points to the string
;
PrintString:
    push si		; si register is used for string operations
    push ax
    push bx

.loop:
    lodsb		; load the next char in al
    or al, al 	; char is not null
    jz .done    
    
    ; write char interrupt
    mov ah, 0x0E
    int 10h
    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

%endif
