{pkgs, ...}: {
  # Linux Only Packages, not available on Darwin
  home.packages = with pkgs; [
    # Automatically trims your branches whose tracking remote refs are merged or gone
    # It's really useful when you work on a project for a long time.
    git-trim

    # cloud tools that nix do not have cache for.
    terraform
    terraformer # generate terraform configs from existing cloud resources

    nmon
    iotop
    iftop

    # misc
    libnotify
    wireguard-tools # manage wireguard vpn manually, via wg-quick

    # need to run `conda-install` before using it
    # need to run `conda-shell` before using command `conda`
    # conda is not available for MacOS
    conda

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    bpftrace # powerful tracing tool
    tcpdump  # network sniffer
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
  ];

  # auto mount usb drives
  services = {
    udiskie.enable = true;
  };

  services = {
    # syncthing.enable = true;
  };
}
