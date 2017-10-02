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
      (pkgs.lib.overrideDerivation pkgs.beam.packages.erlangR20.elixir (attrs: {
        LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
        LANG = "en_US.UTF-8";
        LC_COLLATE = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      }))
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

  users.extraUsers.ghost = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys =
      [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjsHk6IYqS1cX/xV0jEYr95PGyDpzxoYxah2cUmA5OY8N8HxiFhHR2xjUGq9B/W1g54Cpwz08Krk+F6L0nUqfT3tWMXdv1vXvL5NiC2sT7u/hsOwiVsKGc2nqgIUNrI7/czVRaK9X6Tv+IPHm1aFBApiuCRppYIIzlro2IQBUyaMypur5NTPEVt3oaV1mb7r5aMsB6wO55YlMHICbJIEUin+D0TTY4zfXpZqxvuk/0AhragOcC4xLjP6sz6PTWn7q7jnlI9mLR1vQmL2TFLSZF4wq8trPms95UkpagEhDBjnd8NhBMX2/8WK4qUX5baSCS1mnUHWu59LjIkvkZbSTsNTm0CbpXJYWn+SpUywj71bmPz1BOZE2wJZKnxBcV0ugmFIPhl9jxEhNmN5LtHx/BE956bEIGzX2q3eZHP/Aybmg6Mbhu71fEPCyAzDYQdhU8qrsnEbUqnrQGUwVMnr/31OMZVWf/5FMihvoEQpULOmPFn3n8O38Xp9Wh6TyaEjEOfZJyAj4o1Xyg+AeWFD8+YoAXdYS2qt67O33QEqDvJANjGVpzhssunKrdThr9nTCUo931r7q3lVBYnUaafAtBFt2zngzBiGygLR2HKprFsBmtp1hEfZqvsFTg1J/5o3GbwiHpeao5vJwkZLvLErA1LHHZVnZ6uDDoCphBkhezqQ== somlor+vultr@eml.cc"
      ];
  };

  system.stateVersion = "18.03";
}
