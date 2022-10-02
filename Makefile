ASM = nasm
ASM_FLAGS = -f
ASM_FORMAT = bin

SRC_DIR=src

ISO_DIR=build/iso
ISO_OUT_DIR=$(ISO_DIR)/out

BUILD_DIR=build/bin
INT_DIR=build/bin-int

.PHONY: floppy stage1_bootloader stage2_bootloader always clean rebuild run 

#
# Floppy
#
floppy: $(ISO_DIR)/kOS.flp

$(ISO_DIR)/kOS.flp: stage1_bootloader stage2_bootloader;
	cat $(BUILD_DIR)/stage1_bootloader.bin $(BUILD_DIR)/stage2_bootloader.bin > $(ISO_DIR)/kOS.flp

#
# Stage 2 Bootloader
#
stage2_bootloader: $(BUILD_DIR)/stage2_bootloader.bin;

$(BUILD_DIR)/stage2_bootloader.bin:
	$(ASM) $(SRC_DIR)/bootloader/stage2_bootloader.asm $(ASM_FLAGS) $(ASM_FORMAT) -o $(BUILD_DIR)/stage2_bootloader.bin

#
# Bootloader
#
stage1_bootloader: $(BUILD_DIR)/stage1_bootloader.bin

$(BUILD_DIR)/stage1_bootloader.bin: always;
	$(ASM) $(SRC_DIR)/bootloader/stage1_bootloader.asm $(ASM_FLAGS) $(ASM_FORMAT) -o $(BUILD_DIR)/stage1_bootloader.bin

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

#
# Rebuild
#
rebuild: clean floppy