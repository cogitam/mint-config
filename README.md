Mint Debian installation and configuration
==========================================

**OS**: Linux Mint Debian 201403 Cinnamon 64-bit


## If Windows 8.1 dual boot

- Disable Windows Fast-Startup
- Disable Secure Boot
- Save the UEFI partition (from a LiveCD), use `blkid` to find it:
```
# dd if=/dev/sdXx of=uefi-partition.save
```
- Free some space (reduce Windows OS partition)
- Create big NTFS partitions in Windows for data


## Installation

- Partition remaining space for `swap` (8 GB), `/home` (30 GB) and `/` (70 GB)
- Mount the existing UEFI partition in /boot/efi
- Install GRUB in `/` ? (check this!)


## Post-installation

- Run `grub-mkconf` to detect and add Windows 8.1 in GRUB.
- Reboot to check that everything is fine both with LMDE and Windows.

## Configuration

### Next step is coming soon...

