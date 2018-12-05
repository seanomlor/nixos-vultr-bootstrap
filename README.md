Bootstraps a [Vultr](https://www.vultr.com) server with [NixOS](https://nixos.org).

**NOTE:** Be sure to replace the [public key](./ssh-keys.nix) with your own if you fork this!

```bash
nix-env -iA nixos.gitMinimal

git clone https://github.com/somlor/nixos-vultr-bootstrap.git

cd nixos-vultr-bootstrap
./bootstrap.sh
reboot
```
