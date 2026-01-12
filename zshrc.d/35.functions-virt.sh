function alpine() {
    qemu-system-x86_64 \
    -machine q35,accel=tcg \
    -smp 2 \
    -cpu qemu64 \
    -m 1024 \
    -boot d \
    -cdrom /Users/jyxjjj/Downloads/alpine-extended-3.23.2-x86_64.iso \
    -vga std \
    -display cocoa
}
