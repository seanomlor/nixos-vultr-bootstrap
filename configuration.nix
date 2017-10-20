{ config, pkgs, ...}:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    kernel = {
      sysctl."vm.overcommit_memory" = "1";
    };

    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/vda";
    };
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      gcc
      git
      nix-repl
      tmux
      vim
      wget
    ];

    variables = {
      EDITOR = "vim";
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking = {
    hostName = "merkle";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  programs = {
    bash = {
      enableCompletion = true;
    };

    ssh = {
      startAgent = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "no";
    };
  };

  time.timeZone = "America/New_York";

  users = {
    extraUsers = {
      root = {
        openssh.authorizedKeys.keys = with import ./ssh-keys.nix; [ sean ];
      };

      ghost = {
        isNormalUser = true;
        extraGroups = ["wheel"];
        openssh.authorizedKeys.keys = with import ./ssh-keys.nix; [ sean ];
      };
    };
  };

  system.stateVersion = "18.03";
}
