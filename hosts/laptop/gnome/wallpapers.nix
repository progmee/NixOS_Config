{ pkgs, ... }:

let
  # Path to wallpapers root directory
  wallpapersRoot = ../../../assets/wallpapers;
  wallpapersDirStr = toString wallpapersRoot;

  # Explicitly list your wallpaper themes/folders here for 100% stability,
  # or keep it fully dynamic if your folders always contain light/dark pairs.
  # Let's support safe automatic discovery of folders:
  wallpaperDirs = [ "mountains" ]; # Add new folder names here as you create them (e.g. [ "mountains" "road" ])

  # Generate paired XML entries safely per directory
  wallpaperEntries = pkgs.lib.concatStringsSep "\n" (
    map (folderName:
      let
        folderPath = wallpapersRoot + "/${folderName}";
        # Check files inside the folder
        hasLightJpg = builtins.pathExists (folderPath + "/light.jpg");
        hasLightPng = builtins.pathExists (folderPath + "/light.png");
        lightExt = if hasLightPng then "png" else "jpg";
        
        hasDarkJpg = builtins.pathExists (folderPath + "/dark.jpg");
        hasDarkPng = builtins.pathExists (folderPath + "/dark.png");
        darkExt = if hasDarkPng then "png" else "jpg";
      in
      ''
        <wallpaper deleted="false">
          <name>${pkgs.lib.toUpper (builtins.substring 0 1 folderName)}${builtins.substring 1 999 folderName}</name>
          <filename>${wallpapersDirStr}/${folderName}/light.${lightExt}</filename>
          <filename-dark>${wallpapersDirStr}/${folderName}/dark.${darkExt}</filename-dark>
          <options>zoom</options>
          <shade_type>solid</shade_type>
          <pcolor>#ffffff</pcolor>
          <scolor>#000000</scolor>
        </wallpaper>
      ''
    ) wallpaperDirs
  );
in
{
  # Generate safe and clean XML configuration
  xdg.dataFile."gnome-background-properties/auto-wallpapers.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
    <wallpapers>
      ${wallpaperEntries}
    </wallpapers>
  '';

  # Set default wallpapers
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file://${wallpapersDirStr}/mountains/light.jpg";
      picture-uri-dark = "file://${wallpapersDirStr}/mountains/dark.jpg";
    };
  };
}