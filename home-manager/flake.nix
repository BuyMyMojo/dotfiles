{
  description = "Home Manager configuration of buymymojo";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moonlight = {
      url = "github:moonlight-mod/moonlight"; # Add `/develop` to the flake URL to use nightly.
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    shadps4-git.url = "./programs/shadps4";

    nixpkgs-gsr-ui = {
      url = "github:js6pak/nixpkgs/gpu-screen-recorder-ui/init"; # Add `/develop` to the flake URL to use nightly.
    };
    
    bellado.url = "github:isabelroses/bellado";

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      nixpkgs-gsr-ui,
      bellado,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      gsr-ui = import nixpkgs-gsr-ui {
        inherit system;
        config.allowUnfree = true;
      };

    in
    {
      homeConfigurations."buymymojo" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit unstable;
          inherit inputs;
          inherit gsr-ui;
          inherit bellado;
    };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ./packages.nix
          ./services.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
