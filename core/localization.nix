{ pkgs, ... }:

{
  # Localization
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];

  # TTY console configuration
  console = {
    font = "ter-v24n"; 
    packages = with pkgs; [ terminus_font ];
    keyMap = "ru"; 
  };
}