# A recursive helper function that scans a directory and its subdirectories
# to find all .nix files and folders containing a default.nix.
dir:
let
  # Read the contents of the current directory
  dirContent = builtins.readDir dir;

  # Helper function to process individual entries
  collect = name: type:
    let
      path = dir + "/${name}";
    in
    if type == "regular" && name != "default.nix" && builtins.match ".*\\.nix" name != null then
      # If it's a regular .nix file (excluding default.nix), include it
      [ path ]
    else if type == "directory" then
      let
        subDirDefault = path + "/default.nix";
      in
      if builtins.pathExists subDirDefault then
        # If it's a directory and has its own default.nix, import the directory itself
        [ path ]
      else
        # Otherwise, recursively scan inside the subdirectory
        import ./auto-import.nix path
    else
      [];

  # Map over all entries in the directory and flatten the resulting lists
in
builtins.concatLists (
  builtins.attrValues (
    builtins.mapAttrs collect dirContent
  )
)