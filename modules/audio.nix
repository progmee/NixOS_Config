{ pkgs, ... }:

{
  # Enable sound with PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Install essential audio utilities
  # pamixer: CLI tool for volume control
  # pavucontrol: Graphical volume mixer
  # wireplumber: Session manager for PipeWire
  environment.systemPackages = with pkgs; [
    pamixer
    pavucontrol
    wireplumber
  ];
}