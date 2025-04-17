{
  description = "NixOS + Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = {
      linux = "x86_64-linux";
      darwin = "aarch64-darwin";
    };
    user = {
      darwin = "example";
      linux = "example";
    };
    host = {
      linux = "yourname";
      darwin = "Mac-mini-cua-phuclee"; #(`scutil --get LocalHostName`)
    };
    # --- Configuration For All System ---
    configuration = {
      home-manager = {
        backupFileExtension = "backup";
        useUserPackages = true;
        useGlobalPkgs = true;
      };
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nixpkgs.config.allowUnfree = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
    };
  in {
    # --- NixOS Configuration ---
    nixosConfigurations."${host.linux}" = nixpkgs.lib.nixosSystem {
      system = system.linux;
      modules = [
        configuration
        ./nixos/configuration.nix
        {
          users.users.${user.linux} = {
            home = "/home/${user.linux}";
            isNormalUser = true;
            extraGroups = ["wheel"]; # Give sudo access
          };
        }
        home-manager.nixosModules.home-manager
        {
          home-manager.users.${user.linux} = {
            import = [
              ./nixos/home.nix
            ];
          };
        }
      ];
    };
    # --- Expose Packages ---
    nixosPackages = self.nixosConfigurations.${host.linux}.pkgs;
  };
}
