ASM = nasm
ASM_FLAGS = -f
ASM_FORMAT = bin

SRC_DIR=src

ISO_DIR=build/iso
ISO_OUT_DIR=$(ISO_DIR)/out

BUILD_DIR=build/bin
INT_DIR=build/bin-int

.PHONY: bootloader always clean run

#
# Bootloader
#
bootloader: $(BUILD_DIR)/bootloader.flp

$(BUILD_DIR)/bootloader.flp: always;
	$(ASM) $(SRC_DIR)/bootloader/boot.asm $(ASM_FLAGS) $(ASM_FORMAT) -o $(BUILD_DIR)/bootloader.flp

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
	$(shell qemu-system-i386 -fda $(BUILD_DIR)/bootloader.flp)

#
# Clean
#
clean:
	rm -rf $(BUILD_DIR)/* $(INT_DIR)/*