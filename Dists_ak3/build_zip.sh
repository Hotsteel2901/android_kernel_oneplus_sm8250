#!/bin/sh
# Build the AnyKernel3 flashable zip for OnePlus 8 (sm8250/kona).
#
# Prerequisites:
#   1. Build the kernel in the full AOSP / OnePlus source tree (the stock
#      OnePlus kernel requires the proprietary OPLUS vendor modules under
#      vendor/oplus/kernel/* which are NOT included in this standalone repo).
#   2. Copy the built kernel image (Image.gz-dtb) produced at
#      arch/arm64/boot/Image.gz-dtb into THIS directory (Dists_ak3/).
#   3. Run this script. The resulting zip can be flashed in TWRP/OrangeFox.
#
set -e
cd "$(dirname "$0")"

if [ ! -f Image.gz-dtb ] && [ ! -f Image ]; then
    echo "ERROR: place the built 'Image.gz-dtb' (or 'Image') in this folder first."
    echo "       It is produced by: make ARCH=arm64 O=out kona-perf_defconfig && make O=out -j\$(nproc)"
    exit 1
fi

OUT="ksu-susfs-kona-op8-$(date +%Y%m%d).zip"
rm -f "$OUT"
zip -r9 "$OUT" * -x build_zip.sh .git README.md '*~' placeholder .gitignore >/dev/null
echo "Built: $OUT"
