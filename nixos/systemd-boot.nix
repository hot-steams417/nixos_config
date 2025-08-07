# Systemd-boot configuration for NixOS
{pkgs, ...}: {
  boot = {
    bootspec.enable = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";  # Ensure this matches your EFI partition mount
      };
      # Disable GRUB - CRUCIAL FOR DUAL BOOT
      grub.enable = false;
      grub.device = "nodev";  # Prevents GRUB installation
      
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 8;
        # Add Windows entry for dual boot
        extraEntries = {
          "windows.conf" = ''
            title Windows Boot Manager
            efi /EFI/Microsoft/Boot/bootmgfw.efi
          '';
        };
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_latest;

    # Silent boot
    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  # To avoid systemd services hanging on shutdown
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
}
