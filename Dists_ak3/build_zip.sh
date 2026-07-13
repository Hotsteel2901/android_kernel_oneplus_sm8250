#!/bin/sh
# Build the AnyKernel3 flashable zip for OnePlus 8 (sm8250/kona).
#
# Prerequisites:
#   The GitHub Actions workflow (.github/workflows/build-kernel.yml) builds
#   this kernel automatically: it fills the proprietary OPLUS vendor modules
#   from the LineageOS lineage-23.2 branch (which inlines them as real files),
#   compiles with clang-12, copies the image here, and runs this script.
#
#   Manual build:
#   1. Build the kernel (see .github/workflows/build-kernel.yml for the
#      canonical recipe). The stock OnePlus tree needs the OPLUS vendor
#      modules resolved first.
#   2. Copy arch/arm64/boot/Image.gz-dtb (or Image.gz / Image) into THIS
#      directory (Dists_ak3/).
#   3. Run this script. The resulting zip can be flashed in TWRP/OrangeFox.
#
set -e
cd "$(dirname "$0")"

img=""
for cand in Image.gz-dtb Image.gz Image; do
    if [ -f "$cand" ]; then img="$cand"; break; fi
done
if [ -z "$img" ]; then
    echo "ERROR: place the built 'Image.gz-dtb' (or 'Image.gz' / 'Image') in this folder first."
    exit 1
fi
echo "Using kernel image: $img"

OUT="ksu-susfs-kona-op8-$(date +%Y%m%d).zip"
rm -f "$OUT"
zip -r9 "$OUT" * -x build_zip.sh .git README.md '*~' placeholder .gitignore >/dev/null
echo "Built: $OUT"
