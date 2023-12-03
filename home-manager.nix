{ system, pkgs, lib, config, username, dotfiles_dir, configuration, ... }:

# export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

#run: nix-instantiate --eval %

let
  home_dir    = "/home/${username}";
in {
  home.username      = username;
  home.homeDirectory = home_dir;

  # On first run will have to -- enable nix-command and flakes
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  # Do not change this even if upgrading HM. Read release notes before changing.
  home.stateVersion = "23.11";

  # Packages to be in my path
  home.packages = let
    channels = {
      pkgs = pkgs;
      #unstable = unstable;
    };
    convertToNixpkg = path: value: let
      nixexpr = (builtins.foldl'
        (acc_expr: segment: acc_expr.${segment})
        channels
        (builtins.filter (x: "string" == builtins.typeOf x) (builtins.split "\\." path))
      );
    in
      if builtins.typeOf value == "null" then nixexpr
      else if builtins.typeOf value == "set" then nixexpr.override value
      else throw "Unsupported error type for package '${path}': ${builtins.typeOf value}"
    ;
  in
    builtins.attrValues (builtins.mapAttrs convertToNixpkg (configuration.packages ))
    #builtins.attrValues (builtins.mapAttrs convertToNixpkg { "pkgs.nickel" = null; "pkgs.eza" = null; })
  ;
  #map (name: pkgs.${name}) packages;

  #[
  #  (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  #  (pkgs.writeShellScriptBin "my-hello" ''
  #    echo "Hello, ${config.home.username}!"
  #  '')
  #];

  # Initialize the directories under $HOME
  home.activation.create_most_named_directories = let
    mkdir_stmts = builtins.foldl'
      (acc: hm_path: let
        first_ch = builtins.substring 0 1 hm_path;
      in
        if      first_ch == ""  then acc  # $HOME, do nothing
        else if first_ch == "/" then acc  # Absolute path, would require sudo
        else                         acc
          + ''[ -d "${hm_path}" ] || { printf %s\\n "Created '${home_dir}/${hm_path}'"; $DRY_RUN_CMD mkdir -p "${hm_path}"; }''
          + "\n"
      )
      ""
      (builtins.attrValues configuration.named_directories)
    ;
  in
    # Since we have effects, according to home.activation documentation, we must run after "writeBoundary"
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${mkdir_stmts}
    ''
  ;


  # @TODO: assert that there are no overlaps, probably on the nickel side?
  home.file = let
    mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
    convertPath = hm_path: let
      first_ch = builtins.substring 0 1 hm_path;
    in
      if      first_ch == ""  then home_dir
      else if first_ch == "/" then hm_path
      else                         home_dir + "/" + hm_path
    ;
  in
    (builtins.mapAttrs
      (target: src: { source = mkOutOfStoreSymlink (convertPath src); })
      configuration.named_directories
    )

    # Directories that should be linked
    # @TODO: assert that these are all directories
    // (builtins.listToAttrs
      (builtins.map
        (rel_path: {
          name = rel_path;
          value.source = mkOutOfStoreSymlink "${dotfiles_dir}/${rel_path}";
        })
        #[ ".config/scripts" ".config/snippets" ".config/vim/after" ]
        configuration.files.dirl
      )
    )
    #// builtins.trace (toString asdf) {}

    // configuration.files.make
  ;
  #{
  #  ".screenrc".source = dotfiles/screenrc;
  #  ".gradle/gradle.properties".text = ''
  #    org.gradle.console=verbose
  #    org.gradle.daemon.idletimeout=3600000
  #  '';
  #};

  # If you don't want to manage your shell through HM, then source
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = { };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
