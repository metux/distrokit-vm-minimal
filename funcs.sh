declare -a PARAMS

die() {
    echo "$0: $*" >&2
    exit 1
}

info() {
    echo "[INFO] $*" >&2
}

. ./selected_platformconfig || die "cant include selected_platformconfig"

PLATFORM_DIR="./platform-$PTXCONF_PLATFORM"

force_rebuild() {
    info "forcing rebuild of package: $1"
    rm -f "$PLATFORM_DIR/state/$1.compile"
}

build_images() {
    ptxdist images
}

kill_qemu() {
    killall `get_qemu_cmd`
}

get_qemu_cmd() {
    echo -n "$PLATFORM_DIR/sysroot-host/bin/qemu-system-$PTXCONF_ARCH_STRING"
}

get_qemu_datadir() {
    echo -n "$PLATFORM_DIR/sysroot-host/share/qemu"
}

get_rootfs_image() {
    if [ "$PTXCONF_IMAGE_ROOT_EXT" = "y" ]; then
        echo -n "$PLATFORM_DIR/images/root.ext2"
    fi
}

get_kernel_image() {
    echo -n "$PLATFORM_DIR/root/boot/$PTXCONF_KERNEL_IMAGE"
}

get_bios_image() {
    local datadir=`get_qemu_datadir`
    echo -n "$datadir/$1"
}

qemu_bootparm_init() {
    PARAMS=(`get_qemu_cmd`)
    PARAMS+=("-L" `get_qemu_datadir`)
    if [ "$QEMU_KVM" == "on" ]; then
        info "Using KVM"
        PARAMS+=("-enable-kvm")
    fi
    if [ "$QEMU_MACHINE" ]; then
        info "Using machine type: $QEMU_MACHINE"
        PARAMS+=("-machine" "$QEMU_MACHINE")
    fi
}

qemu_bootparm_kernel() {
    KERNEL_IMAGE=`get_kernel_image`
    if [ "$KERNEL_IMAGE" ]; then
        info "Using kernel image: $KERNEL_IMAGE"
        PARAMS+=("-kernel" "$KERNEL_IMAGE")
    fi
}

qemu_bootparm_rootfs() {
    ROOTFS_IMAGE=`get_rootfs_image`
    if [ "$ROOTFS_IMAGE" ]; then
        info "using root fs image: $ROOTFS_IMAGE"
        QEMU_ROOT_DEVICE="/dev/vda"
        PARAMS+=("-drive" "id=vda,file=$ROOTFS_IMAGE,if=virtio")
    fi
}

qemu_bootparm_bios() {
    if [ "$QEMU_BIOS_TYPE" ]; then
        info "using bios type: $QEMU_BIOS_TYPE"
        PARAMS+=("-bios" "$PLATFORM_DIR/sysroot-host/share/qemu/$QEMU_BIOS_TYPE")
    fi
}

qemu_startup() {
    ${PARAMS[@]}
}
