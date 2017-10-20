#! /bin/sh

mkfs.btrfs -L nixos /dev/vda
mount /dev/vda /mnt

nixos-generate-config --root /mnt

cp *.nix /mnt/etc/nixos/

nixos-install --show-trace --no-root-passwd
