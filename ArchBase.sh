#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/kolkata /etc/localtime
hwclock --systohc
sed -i '162s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_IN.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 ArchLinux.localdomain ArchLinux" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp qemu edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset gufw sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

pacman -S --noconfirm xf86-video-intel
# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=ArchLinux #change the directory to /boot/efi is you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
#systemctl enable reflector.timer
systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
systemctl enable acpid

useradd -m arch
echo arch:password | chpasswd


echo "arch ALL=(ALL) ALL" >> /etc/sudoers.d/arch


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"



