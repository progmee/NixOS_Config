{ pkgs, ... }:

{
  # Install Vesktop (Discord client with built-in Vencord support)
  home.packages = [
    pkgs.vesktop
  ];

  # Declarative Vencord settings and enabled plugins
  programs.vesktop = {
    enable = true;
    
    vencord.settings = {
      plugins = {
        BetterFolders = { enabled = true; };      # Improves folder organization and icons
        BetterSettings = { enabled = true; };     # Streamlines the settings menu layout
        BetterUploadButton = { enabled = true; }; # Adds helpful features to the file upload button
        CallTimer = { enabled = true; };          # Displays a timer for active voice calls
        CrashHandler = { enabled = true; };       # Gracefully handles client crashes
        FakeNitro = { enabled = true; };          # Emulates client-side Nitro features (client perks)
        FixImagesQuality = { enabled = true; };   # Prevents compression on uploaded images
        FixYoutubeEmbeds = { enabled = true; };   # Fixes embedded YouTube videos playback
        MemberCount = { enabled = true; };        # Shows total member count in server lists
        NoF1 = { enabled = true; };               # Prevents accidental help triggers
        ServerInfo = { enabled = true; };         # Adds detailed server information popups
        SilentTyping = { enabled = true; };       # Hides your typing indicator from others
        VolumeBooster = { enabled = true; };      # Allows boosting user volumes beyond 100%
      };
    };
  };
}