{
  nixConfig = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    extra-substituters = [ "https://niks3.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  inputs = {
    llm-agents.url = "github:numtide/llm-agents.nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
  };

  outputs =
    { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { self, ... }: {
        systems = [ "x86_64-linux" ];

        imports = [
          inputs.treefmt-nix.flakeModule
          ./parts
        ];

        flake = {
          nixosConfigurations = {
            nixos = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
                isWsl = false;
              };
              modules = [
                inputs.hjem.nixosModules.hjem
                ./nixos.nix
              ];
            };

            wsl = inputs.nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = {
                inherit inputs;
                isWsl = true;
              };
              modules = [
                inputs.hjem.nixosModules.hjem
                inputs.nixos-wsl.nixosModules.default
                ({ lib, ... }: {
                  wsl.enable = true;
                  networking.wireless.enable = lib.mkForce false;
                  systemd.services.wpa_supplicant.enable = false;
                })
                ({ inputs, ... }: {
                  nixpkgs.overlays = [
                    (final: prev: {
                      llm-agents = inputs.llm-agents.packages.${final.system};
                    })
                  ];
                })
                ./nixos.nix
              ];
            };
          };
        };
      }
    );
}
