Mint Debian installation and configuration
==========================================

**Hardware**: Laptop ASUS ROG G550JK-CN519H

**OS**: Linux Mint Debian 201403 Cinnamon 64-bit

*Install made from a USB key created with [Lili](http://www.linuxliveusb.com/en/download)*

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
- Run `aptitude update` then `aptitude upgrade`.


## Install softwares

### From repositories

**Development**
- General development tools: `git gcc make`
- Python: `pip python-virtualenv ipython ipython-notebook`

**Scientific**
- Latex: `texlive-latex-base texlive-latex-recommended texlive-latex-extra`
- Mendeley: `mendeleydesktop`
- Python: `python-numpy python-scipy python-sympy python-matplotlib python-h5py`

**Misc**
- Tools: `imagemagick emacs`
- Education: `stellarium`
- Entertainment: `radiotray`
- Security: `gpg`

### From the Web: download and install

**Development**
- General development tools: [Sublime Text](http://www.sublimetext.com/3)

**Scientific**
- Python: [Basemap](http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/) (see Cartopy too for future projects...)

**Misc**
- Security: [Truecrypt](https://truecrypt.ch/)


## Configuration


### System

#### Adding my own Bépo keymap

#### Installing additional fonts


### Restore my dot files

- [Github link]() to download and extract my .dot files (not avalaible yet!)


### Home

- Import my GPG keys


### Shell

#### Setting up the `zsh`

#### Customize `zsh` and `bash` (prompt, alias, functions, ...)


### Cinnamon

#### Setting up xscreensaver

#### Create shortcuts...



