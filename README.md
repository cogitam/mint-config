Mint Debian installation and configuration
==========================================

**Hardware**: Laptop ASUS ROG G550JK-CN519H

**OS**: Linux Mint Debian 201403 Cinnamon 64-bit

*Install made from a USB key created with [Lili](http://www.linuxliveusb.com/en/download)*

*NB: Debian Wheezy (sept. 2014) as no EFI file in its LiveCD (needed to boot on the key with Windows 8) and there are problems with the Geforce GTX 850M, both nouveau and Nvidia drivers, bumblebee, optimus and so on (was never able to start X...).*

**Do not work, to fix**:
- No two-fingers scroll and no simultaneous-click to paste after copy with the touchpad (really annoying...)
- No sound from the small additional subwoofer provided by Asus

## If Windows 8.1 dual boot

- Disable Windows Fast-Startup
- Disable Secure Boot
- Save the UEFI partition (from a LiveCD), use `blkid` to find it:
```
# dd if=/dev/sdxX of=uefi-partition.save
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

*Note*: LMDE automatically add the user in `sudoers`.

## Install softwares

### From repositories

**Development**
- General development tools: `git gcc make`
- Python: `pip python-virtualenv virtualenvwrapper ipython ipython-notebook`

**Scientific**
- Compilers: `gfortran` 
- Latex: `texlive-{base,fonts-extra,science,pictures,extra-utils} texlive-latex-{base,recommended,extra} cm-super`
- Python scientific base (use `pip` for others): `python-{numpy,scipy,sympy,matplotlib}`
- GMT: `gmt`

**Misc**
- Tools: `imagemagick ffmpeg ghostscript redshift unrar zip unzip emacs vim zsh tree cups xscreensaver xscreensaver-gl`
- Education: `stellarium anki`
- Entertainment: `radiotray vlc fortune-mod fortunes-{min,fr,es,de,it,ru}`
- Security: `gnupg`
- Fonts: `fonts-crosextra-carlito fonts-crosextra-caladea` (replace µsoft Calibri and Cambria)

### From the Web: download and install

**Development**
- General development tools: [Sublime Text](http://www.sublimetext.com/3)

**Scientific**
- Python: [Basemap](http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/) (see Cartopy too for future projects...)
- [Mendeley](http://www.mendeley.com/download-mendeley-desktop/)

**Misc**
- Cloud: [Dropbox](https://www.dropbox.com/install?os=lnx)
- Security: [Truecrypt](https://truecrypt.ch/)


## Configuration

First of all, clone this GitHub repos: `git clone https://github.com/cogitam/mint-config.git`

### System

- Customize the `sudoers` file (not detailed in this repos...). See the [Ubuntu doc](http://doc.ubuntu-fr.org/sudoers) and [sudoers manual](http://www.sudo.ws/sudo/sudoers.man.html).

#### Adding my own Bépo keymap

- Add my [bépo keymap](https://github.com/cogitam/mint-config/blob/master/bepo-intl-perso) in `/usr/share/X11/xkb/symbols/fr`:
```
$ sudo cp /usr/share/X11/xkb/symbols/fr /usr/share/X11/xkb/symbols/fr.old
$ sudo tee -a /usr/share/X11/xkb/symbols/fr < bepo-intl-perso > /dev/null
```
- Add the variant in `/usr/share/X11/xkb/rules/base.xml` and `/usr/share/X11/xkb/rules/evdev.xml` (e.g. after standard bepo), i.e. copy-paste the following line and put them after the bepo variant section:
```
        <variant>
          <configItem>
            <name>bepo-intl-perso</name>
            <description>French (Bepo, perso)</description>
          </configItem>
        </variant>
```
- Add the new variant in the keyboards list and set left Windows key as keymap switcher.

#### Add Windows NTFS partitions in fstab (single user)

1. Get the UUIDs with `sudo blkid`
2. Create a mount point in `/media` for each partition and set the user as owner: `sudo chown $USER:$USER /media/YYYY`
3. Add this line in `/etc/fstab` for each partition to auto-mount:
```
UUID=XXXXXXXXXXXXX     /media/YYYY      ntfs-3g rwx,uid=1000,user,auto  0       0
```

#### Installing additional fonts

- Put the script to download them or just write this not to forget?

### Home

- Restore my [dot files](https://github.com/cogitam/mint-config/tree/master/home):
```
cp mint-config/home/.* ~
```
- Get [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh#the-manual-way) and configure, then:
```
cp -r mint-config/home/.oh-my-zsh ~
```
- Restore my [radiotray bookmarks](https://github.com/cogitam/mint-config/blob/master/bookmarks-radiotray.xml):
```
cp mint-config/bookmarks-radiotray.xml ~/.local/share/radiotray/
```
- Restore my [redshift](https://github.com/cogitam/mint-config/blob/master/home/.config/redshift.conf) config file:
```
cp mint-config/home/.config/redshift.conf ~/.config/
```
and set my coordinates using [findgeographiccoordinates.com](http://findgeographiccoordinates.com/).
- Add xscreensaver in autostart (note: add my images or links to them in `Images/Screensaver`) with the following:
```
#!/bin/sh

sleep 30
killall cinnamon-screensaver
sleep 10
xscreensaver -nosplash
```
- Import my GPG keys
- Setup and configure Dropbox (+ Dropbox secure)

### Internet

#### Firefox/Iceweasel

- Install the following addons: Adblock plus, Ghostery, Quick Translator, Xmarks, YouTube Smart Pause, YouTube High Definition, NetVideoHunter *and/or* Youtube and more - Easy Video Downloader, Firebug, Web Developer
- Install additional dictionaries
- Configure Xmarks and synchronize bookmarks, etc.
- Set starting page and restore tabs at startup, enable text research when typing
- Add a few lines in Adblocks plus...

#### Thunderbird/Icedove

1. Restore everything from my current profile
2. Set the path to my profile folder in `.icedove/profiles.ini`
3. Check or reinstall the following addons: Enigmail, ...

### Cinnamon

- Add useful/funny launchers:
```
display http://www.sat24.com/image2.ashx?region=eu&ir=false
display http://www.sat24.com/image2.ashx?region=eu&ir=true
display http://c.xkcd.com/redirect/comic/now
```
and my [Satellite Live View](https://github.com/cogitam/mint-config/blob/master/satellite-live-view.sh) script.

*NB, optional*: first argument (default `fr`, try `eu`) for region, second one time span in hours (`6`) and third one in 1/100th of a second for animation delay (`20`)

#### Setting up xscreensaver

#### Create shortcuts...


