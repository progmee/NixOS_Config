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
        BetterFolders = { enabled = true; };
        BetterSettings = { enabled = true; };
        BetterUploadButton = { enabled = true; };
        CallTimer = { enabled = true; };
        CrashHandler = { enabled = true; };
        FakeNitro = { enabled = true; };
        FixImagesQuality = { enabled = true; };
        FixYoutubeEmbeds = { enabled = true; };
        MemberCount = { enabled = true; };
        NoF1 = { enabled = true; };
        ServerInfo = { enabled = true; };
        SilentTyping = { enabled = true; };
        VolumeBooster = { enabled = true; };
      };
    };
  };
}