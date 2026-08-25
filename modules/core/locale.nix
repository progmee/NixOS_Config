{ config, pkgs, ... }:

{
  # Set system time zone
  time.timeZone = "Europe/Paris";

  # Select internationalisation and locale properties
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure regional settings for France (formatting, measurement, dates, etc.)
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT    = "fr_FR.UTF-8";
    LC_MONETARY       = "fr_FR.UTF-8";
    LC_NAME           = "fr_FR.UTF-8";
    LC_NUMERIC        = "fr_FR.UTF-8";
    LC_PAPER          = "fr_FR.UTF-8";
    LC_TELEPHONE      = "fr_FR.UTF-8";
    LC_TIME           = "fr_FR.UTF-8";
  };
}