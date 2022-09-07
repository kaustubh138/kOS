ASM = nasm
ASM_FLAGS = -f
ASM_FORMAT = bin

SRC_DIR=src

ISO_DIR=build/iso
ISO_OUT_DIR=$(ISO_DIR)/out

BUILD_DIR=build/bin
INT_DIR=build/bin-int

.PHONY: floppy bootloader dummy_prgm always clean run

#
# Floppy
#
floppy: $(ISO_DIR)/kOS.flp

$(ISO_DIR)/kOS.flp: bootloader dummy_prgm;
	cat $(BUILD_DIR)/bootloader.bin $(BUILD_DIR)/DummyProgram.bin > $(ISO_DIR)/kOS.flp

#
# Dummy Program
#
dummy_prgm: $(BUILD_DIR)/DummyProgram.bin;

$(BUILD_DIR)/DummyProgram.bin:
	$(ASM) $(SRC_DIR)/bootloader/DummyProgram.asm $(ASM_FLAGS) $(ASM_FORMAT) -o $(BUILD_DIR)/DummyProgram.bin
#
# Bootloader
#
bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: always;
	$(ASM) $(SRC_DIR)/bootloader/boot.asm $(ASM_FLAGS) $(ASM_FORMAT) -o $(BUILD_DIR)/bootloader.bin

#
# Always
#
always:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(INT_DIR)
	mkdir -p $(ISO_DIR)

#
# Run
#
run:
	$(shell qemu-system-i386 -fda $(ISO_DIR)/kOS.flp)

#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/* $(INT_DIR)/*