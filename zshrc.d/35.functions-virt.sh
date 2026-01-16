function alpine() {
    local ROOT="$HOME/.VirtualMachines/Alpine"

    #region init
    mkdir -p "$ROOT/Shared"

    if [ ! -f "$ROOT/disk.qcow2" ]; then
        qemu-img create -f qcow2 "$ROOT/disk.qcow2" 10G
    fi

    if [ ! -f "$ROOT/CODE.fd" ]; then
        cp /opt/homebrew/Cellar/qemu/10.2.0/share/qemu/edk2-x86_64-code.fd "$ROOT/CODE.fd"
    fi

    if [ ! -f "$ROOT/VARS.fd" ]; then
        qemu-img create -f raw "$ROOT/VARS.fd" 64K
    fi
    #endregion

    qemu-system-x86_64 \
        -name Alpine \
        -uuid 019bb1a1-caf4-7321-9fbd-e8f8d787eb86 \
        -smbios type=1,manufacturer="DESMG",product="Alpine-macOS",version="1.0",serial="4445534D470000" \
        -nodefaults \
        -machine q35,vmport=off,i8042=off \
        -smp cpus=2,sockets=1,cores=2,threads=1 \
        -cpu qemu64 \
        -accel tcg,thread=multi,tb-size=65536 \
        -global ICH9-LPC.disable_s3=1 \
        -m 4096 \
        -drive if=pflash,format=raw,unit=0,readonly=on,file="$ROOT/CODE.fd" \
        -drive if=pflash,format=raw,unit=1,file="$ROOT/VARS.fd" \
        -device virtio-blk-pci,bus=pcie.0,drive=disk0,bootindex=0 \
        -device ide-cd,bus=ide.0,drive=cdrom0,bootindex=1 \
        -drive id=disk0,if=none,format=qcow2,file="$ROOT/disk.qcow2",discard=unmap,detect-zeroes=unmap \
        -drive id=cdrom0,if=none,media=cdrom,file="$ROOT/Alpine-Extended-x86_64-3.23.2.iso" \
        -virtfs local,path="$ROOT/Shared",mount_tag=hostshare,security_model=none,id=hostshare \
        -vga none \
        -device virtio-vga \
        -usb \
        -device usb-mouse,bus=usb-bus.0 \
        -device usb-kbd,bus=usb-bus.0 \
        -device ich9-usb-ehci1,id=usb-controller-0 \
        -device ich9-usb-uhci1,masterbus=usb-controller-0.0,firstport=0,multifunction=on \
        -device ich9-usb-uhci2,masterbus=usb-controller-0.0,firstport=2,multifunction=on \
        -device ich9-usb-uhci3,masterbus=usb-controller-0.0,firstport=4,multifunction=on \
        -device e1000e,mac=44:45:53:4D:47:00,netdev=net0 \
        -netdev user,id=net0 \
        -rtc base=localtime \
        -device virtio-rng-pci \
        -display cocoa \
        -monitor stdio
}

function fedora() {
    local ROOT="$HOME/.VirtualMachines/Fedora"

    #region init
    mkdir -p "$ROOT/Shared"

    if [ ! -f "$ROOT/disk.qcow2" ]; then
        qemu-img create -f qcow2 "$ROOT/disk.qcow2" 20G
    fi

    if [ ! -f "$ROOT/CODE.fd" ]; then
        cp /opt/homebrew/Cellar/qemu/10.2.0/share/qemu/edk2-x86_64-code.fd "$ROOT/CODE.fd"
    fi

    if [ ! -f "$ROOT/VARS.fd" ]; then
        qemu-img create -f raw "$ROOT/VARS.fd" 64K
    fi
    #endregion

    qemu-system-x86_64 \
        -name Fedora \
        -uuid 019bb1a1-9826-7136-95d1-ff20a50fee91 \
        -smbios type=1,manufacturer="DESMG",product="Fedora-macOS",version="1.0",serial="4445534D470001" \
        -nodefaults \
        -machine q35,vmport=off,i8042=off \
        -smp cpus=2,sockets=1,cores=2,threads=1 \
        -cpu qemu64 \
        -accel tcg,thread=multi,tb-size=65536 \
        -global ICH9-LPC.disable_s3=1 \
        -m 8192 \
        -drive if=pflash,format=raw,unit=0,readonly=on,file="$ROOT/CODE.fd" \
        -drive if=pflash,format=raw,unit=1,file="$ROOT/VARS.fd" \
        -device virtio-blk-pci,bus=pcie.0,drive=disk0,bootindex=0 \
        -device ide-cd,bus=ide.0,drive=cdrom0,bootindex=1 \
        -drive id=disk0,if=none,format=qcow2,file="$ROOT/disk.qcow2" \
        -drive id=cdrom0,if=none,media=cdrom,file="$ROOT/Fedora-Server-x86_64-43.iso" \
        -virtfs local,path="$ROOT/Shared",mount_tag=hostshare,security_model=none,id=hostshare \
        -vga none \
        -device virtio-vga \
        -usb \
        -device usb-mouse,bus=usb-bus.0 \
        -device usb-kbd,bus=usb-bus.0 \
        -device ich9-usb-ehci1,id=usb-controller-0 \
        -device ich9-usb-uhci1,masterbus=usb-controller-0.0,firstport=0,multifunction=on \
        -device ich9-usb-uhci2,masterbus=usb-controller-0.0,firstport=2,multifunction=on \
        -device ich9-usb-uhci3,masterbus=usb-controller-0.0,firstport=4,multifunction=on \
        -device e1000e,mac=44:45:53:4D:47:01,netdev=net0 \
        -netdev user,id=net0 \
        -rtc base=localtime \
        -device virtio-rng-pci \
        -display cocoa \
        -usb -device usb-tablet \
        -monitor stdio
}
