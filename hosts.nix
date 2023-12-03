#run: nix-instantiate --eval %
let
  work_external = sys: derivation {
    name    = "work-username";
    system  = sys;
    builder = "/bin/sh";
    args    = [ "-c"
      # Hide my work user from source code. Yes, my work user has a number
      # in it, and the other the Windows directories do not.
      ''
        dir=/mnt/c/Users/*[0-9]*; printf %s $dir >$out \
          || { printf %s\\n "Could not find dir: $dir" exit "$?"; }
      ''
    ];
  };
in {
# these hosts can be called as: `home-manager switch --flake .#port`
  port = let sys = "x86_64-linux"; in { system = sys; profile = "home"; username = "rai"; external = ""; };
  work = let sys = "x86_64-linux"; in { system = sys; profile = "work"; username = "rai"; external = builtins.readFile (work_external sys); };
}
