# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Use the EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  # depending on how you configured your disk mounts, change this to /boot or /boot/efi.
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true; # automatically add other OSs into grub menu
    # if you use an encrypted /boot partition, you should enable this option.
    # grub 2.12-rc1 support only luks1 and luks2+pbkdf2,
    # so the /boot partition can only use those two luks encrypt format.
    enableCryptodisk = true;
  };

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.initrd = {
    # unlocked luks devices via a keyfile or prompt a passphrase.
    luks.devices."crypted-nixos" = {
      device = "/dev/nvme0n1p2";
      # the keyfile(or device partition) that should be used as the decryption key for the encrypted device.
      # if not specified, you will be prompted for a passphrase instead.
      #keyFile = "/root-part.key";

      # whether to allow TRIM requests to the underlying device.
      # it's less secure, but faster.
      allowDiscards = true;
    };

    luks.devices."crypted-boot" = {
      device = "/dev/nvme0n1p3";
      #keyFile = "/boot-part.key";

      # boot partition do not require fast speed, so we disable it.
      allowDiscards = false;
    };

    # secrets to append to the initrd.
    # the initrd is located in /boot partition, so only enabled this options when you encryped /boot partition!
    secrets = {
      # Format:
      #   file-path inside initrd  =  the source path it should be copied from.
      # "/boot-part.key" = "/etc/secrets/initrd/boot-part.key";
    };
  };


  fileSystems."/" =
    { device = "/dev/disk/by-uuid/836b93a9-324f-45e6-ac1d-964becd7520c";
      fsType = "btrfs";
      options = [ "subvol=@root" "compress-force=zstd:1" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/836b93a9-324f-45e6-ac1d-964becd7520c";
      fsType = "btrfs";
      options = [ "subvol=@nix" "noatime" "compress-force=zstd:1" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/836b93a9-324f-45e6-ac1d-964becd7520c";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress-force=zstd:1" ];
    };

  # mount swap subvolume in readonly mode.
  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/836b93a9-324f-45e6-ac1d-964becd7520c";
      fsType = "btrfs";
      options = [ "subvol=@swap" "ro" ];
    };

  # remount swapfile in read-write mode
  fileSystems."/swap/swapfile" =
    { 
      # the swapfile is located in /swap subvolume, so we need to mount /swap first.
      depends = [ "/swap"];
      
      device = "/swap/swapfile";
      fsType = "none";
      options = [ "bind" "rw" ];
    };

  fileSystems."/boot" =
    { device = "/dev/mapper/crypted-boot";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/swap/swapfile"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
