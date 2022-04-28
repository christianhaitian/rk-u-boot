#!/bin/bash
dd if=/dev/zero of=spi_image.img bs=1M count=0 seek=16
/usr/sbin/parted -s spi_image.img mklabel gpt
/usr/sbin/parted -s spi_image.img unit s mkpart idbloader 64 7167
/usr/sbin/parted -s spi_image.img unit s mkpart vnvm 7168 7679
/usr/sbin/parted -s spi_image.img unit s mkpart reserved_space 7680 8063
/usr/sbin/parted -s spi_image.img unit s mkpart reserved1 8064 8127
/usr/sbin/parted -s spi_image.img unit s mkpart uboot_env 8128 8191
/usr/sbin/parted -s spi_image.img unit s mkpart reserved2 8192 16383
/usr/sbin/parted -s spi_image.img unit s mkpart uboot 16384 32734
dd if=idblock.bin of=spi_image.img seek=64 conv=notrunc
dd if=fit/uboot.itb of=spi_image.img seek=16384 conv=notrunc

