./platform-x86_64/sysroot-host/bin/qemu-system-x86_64 \
    -L ./platform-x86_64/sysroot-host/share/qemu \
    "-kernel" \
    "./platform-x86_64/root/boot/bzImage" \
    "-bios" "../apu/coreboot/build/coreboot.rom" \
    "-gdb" "tcp::9000"
