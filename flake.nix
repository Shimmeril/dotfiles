#run: home-manager switch --flake .#port
{
  description = "Multi-Host Home Manager configuration";

  inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs.url = "nixpkgs";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    nickel-source = builtins.path { path = ./src; }; # Copy ./src into store on nix realisation
    hosts         = import ./hosts.nix;

  in {
    # Define one host per key in ${hosts}
    # We are off-loading most of the configuration to nickel
    #
    # Host     is a physical computer
    # Profile  is a software setup
    # External is the extra 'home' directory that exists on Android/Windows
    homeConfigurations = builtins.mapAttrs (
      _host_id: {system , profile, username, external}:
      let
        # @NOTE: Make sure this path is valid
        dotfiles_dir  = "/home/${username}/dotfiles";

        nickel-run = derivationStrict {
          name    = "dotfiles-nickel";
          system  = system;
          builder = "/bin/sh";
          args    = [ "-c" ''
            ${nixpkgs.legacyPackages.${system}.nickel}/bin/nickel \
              export ${nickel-source}/output.ncl \
              -- \
              --override 'profile_id="${profile}"' \
              --override 'external="${external}"' \
            >$out
          ''];
        };
        nickel-json = builtins.fromJSON (builtins.readFile nickel-run.out);

      in home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = system; };
        modules = [ ./home-manager.nix ];

        # These are passed as extra arguments to the modules (functions)
        # I am avoiding `inherit` because it is confusing
        extraSpecialArgs = {
          system        = system;
          username      = username;
          dotfiles_dir  = dotfiles_dir;
          configuration = nickel-json; # 'config' is reserved arg name
        };
      }
    ) hosts;
  };
}
