let contracts = import "../meta/contracts.ncl" in
{
  profiles | not_exported = {
    home   = import "home.ncl",
    devops = import "devops.ncl",
  },
  FieldsSubsetOfSpecificProfiles | not_exported = profiles
    |> std.record.values
    |> std.array.map (fun f => contracts.FieldsSubsetOf (f ""))
    |> std.contract.Sequence
  ,

  # `&` merge in the following with output of profiles
  shared = {
    packages = {
      "pkgs.nickel" = null,
      "pkgs.eza" = null, "pkgs.ripgrep" = null, "pkgs.fd" = null, "pkgs.tree" = null,
      "pkgs.helix" = null,
      "pkgs.tmux" = null,
      "pkgs.nmap" = null, "pkgs.unixtools.nettools" = null, "pkgs.dig" = null,

      "pkgs.lf" = null,   "pkgs.fzf"  = null,  "pkgs.atool" = null,
      "pkgs.pass" = null, "pkgs.gnupg" = null, "pkgs.pinentry" = null, "pkgs.pinentry-curses" = null,

      "pkgs.jq" = null,
      #"xorg.xrandr",
      #"neomutt"

    },
  } | FieldsSubsetOfSpecificProfiles,

  xdg | not_exported = {
    XDG_CACHE_HOME  = ".cache",       # analogous to /etc
    XDG_CONFIG_HOME = ".config",      # analogous to /var/cache
    XDG_DATA_HOME   = ".local/share", # analogous to /usr/share
    XDG_STATE_HOME  = ".local/state", # analogous to /var/lib
    #XDG_RUNTIME_DIR set in .xprofile

  },
}
