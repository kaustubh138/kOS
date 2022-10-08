;
; Reference: 
;   1. https://wiki.osdev.org/Global_Descriptor_Table
;   2. https://en.wikipedia.org/wiki/Global_Descriptor_Table
;   3. https://wiki.osdev.org/GDT_Tutorial -> What to put in GDT 
;
gdt_nulldesc:       ; null descriptor
    dd 0
    dd 0   

gdt_codedesc:       ; Kernel Mode Code Segment
    dw 0xffff       ; Segment limit 0-15 bits
    dw 0x0000       ; Base 00-15 bits
    db 0x0000       ; Base 16-23 bits    
    db 0b10011010   ; Access Byte (Structure Ref 2)
    db 0b11001111   ; Flags (High 4 Bits) + Segment Limit last 4 bits (Low 4 bits) 
    db 0x00         ; Base 24-31 bits

gdt_datadesc:       ; Kernel Mode Data Segments
    dw 0xffff       ; Segment limit
    dw 0x0000       ; Base
    db 0x00
    db 0b10010010   ; Access Byte
    db 0b11001111   ; Flags
    db 0x00

gdt_end:

gdt_descriptor: 
    gdt_size:
        dw gdt_end - gdt_nulldesc - 1 ; Size of GDT Table
        dq gdt_nulldesc               ; offset

code_seg equ gdt_codedesc - gdt_nulldesc
data_seg equ gdt_datadesc - gdt_nulldesc