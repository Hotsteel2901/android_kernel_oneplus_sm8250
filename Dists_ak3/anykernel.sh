### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
## Customized for OnePlus 8 / 8T / 8 Pro (sm8250 / kona)
## KernelSU-Next + SUSFS 2.1.0 build

### AnyKernel setup
# global properties
properties() { '
kernel.string=KernelSU-Next-SUSFS for OnePlus 8 (sm8250/kona) by Hotsteel2901
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=instantnoodle
device.name2=instantnoodlep
device.name3=kebab
device.name4=oneplus8
device.name5=oneplus8pro
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
# OnePlus 8 is an A/B slot device using sm8250 (kona).
# BLOCK=auto lets AnyKernel3 auto-detect the boot partition
# (/dev/block/bootdevice/by-name/boot_{a,b}).
BLOCK=auto;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
# dump_boot unpacks the current boot image; the new kernel (Image.gz-dtb
# placed in this folder root) replaces the stock kernel. write_boot repacks
# and flashes. No ramdisk modifications are performed (kernel-only flash).
dump_boot;

write_boot;
## end boot install
