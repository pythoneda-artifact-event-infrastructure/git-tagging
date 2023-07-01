{
  description = "Infrastructure layer for pythoneda-artifact-event/git-tagging";

  inputs = rec {
    nixos.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils/v1.0.0";
    pythoneda-base = {
      url = "github:pythoneda/base/0.0.1a15";
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
    };
    pythoneda-artifact-event-git-tagging = {
      url = "github:pythoneda-artifact-event/git-tagging/0.0.1a1";
      inputs.nixos.follows = "nixos";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pythoneda-base.follows = "pythoneda-base";
    };
  };
  outputs = inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixos { inherit system; };
        description =
          "Infrastructure layer for pythoneda-artifact-event/git-tagging";
        license = pkgs.lib.licenses.gpl3;
        homepage =
          "https://github.com/pythoneda-artifact-event-infrastructure/git-tagging";
        maintainers = with pkgs.lib.maintainers; [ ];
        nixpkgsRelease = "nixos-23.05";
        shared = import ./nix/devShells.nix;
        pythoneda-artifact-event-infrastructure-git-tagging-for = { version
          , pythoneda-artifact-event-git-tagging, pythoneda-base, python }:
          let
            pname = "pythoneda-artifact-event-infrastructure-git-tagging";
            pythonVersionParts = builtins.splitVersion python.version;
            pythonMajorVersion = builtins.head pythonVersionParts;
            pythonMajorMinorVersion =
              "${pythonMajorVersion}.${builtins.elemAt pythonVersionParts 1}";
            pnameWithUnderscores =
              builtins.replaceStrings [ "-" ] [ "_" ] pname;
            wheelName =
              "${pnameWithUnderscores}-${version}-py${pythonMajorVersion}-none-any.whl";
          in python.pkgs.buildPythonPackage rec {
            inherit pname version;
            projectDir = ./.;
            src = ./.;
            format = "pyproject";

            nativeBuildInputs = with python.pkgs; [ pip pkgs.jq poetry-core ];
            propagatedBuildInputs = with python.pkgs; [
              dbus-next
              grpcio
              pythoneda-artifact-event-git-tagging
              pythoneda-base
            ];

            checkInputs = with python.pkgs; [ pytest ];

            pythonImportsCheck =
              [ "pythonedaartifacteventinfrastructuregittagging" ];

            preBuild = ''
              python -m venv .env
              source .env/bin/activate
              pip install ${pythoneda-base}/dist/pythoneda_base-${pythoneda-base.version}-py3-none-any.whl
              pip install ${pythoneda-artifact-event-git-tagging}/dist/pythoneda_artifact_event_git_tagging-${pythoneda-artifact-event-git-tagging.version}-py3-none-any.whl
              rm -rf .env
            '';

            postInstall = ''
              mkdir $out/dist
              cp dist/${wheelName} $out/dist
              jq ".url = \"$out/dist/${wheelName}\"" $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json > temp.json && mv temp.json $out/lib/python${pythonMajorMinorVersion}/site-packages/${pnameWithUnderscores}-${version}.dist-info/direct_url.json
            '';

            meta = with pkgs.lib; {
              inherit description license homepage maintainers;
            };
          };
        pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-for =
          { pythoneda-base, pythoneda-artifact-event-git-tagging, python }:
          pythoneda-artifact-event-infrastructure-git-tagging-for {
            version = "0.0.1a1";
            inherit pythoneda-base pythoneda-artifact-event-git-tagging python;
          };
      in rec {
        packages = rec {
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python38 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-for {
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python38;
              pythoneda-artifact-event-git-tagging =
                pythoneda-artifact-event-git-tagging.packages.${system}.pythoneda-artifact-event-git-tagging-latest-python38;
              python = pkgs.python38;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python39 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-for {
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python39;
              pythoneda-artifact-event-git-tagging =
                pythoneda-artifact-event-git-tagging.packages.${system}.pythoneda-artifact-event-git-tagging-latest-python39;
              python = pkgs.python39;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python310 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-for {
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python310;
              pythoneda-artifact-event-git-tagging =
                pythoneda-artifact-event-git-tagging.packages.${system}.pythoneda-artifact-event-git-tagging-latest-python310;
              python = pkgs.python310;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python38 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python38;
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python39 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python39;
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python310 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python310;
          pythoneda-artifact-event-infrastructure-git-tagging-latest =
            pythoneda-artifact-event-infrastructure-git-tagging-latest-python310;
          default = pythoneda-artifact-event-infrastructure-git-tagging-latest;
        };
        defaultPackage = packages.default;
        devShells = rec {
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python38 =
            shared.devShell-for {
              package =
                packages.pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python38;
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python39;
              python = pkgs.python38;
              inherit pkgs nixpkgsRelease;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python39 =
            shared.devShell-for {
              package =
                packages.pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python39;
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python39;
              python = pkgs.python39;
              inherit pkgs nixpkgsRelease;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python310 =
            shared.devShell-for {
              package =
                packages.pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python310;
              pythoneda-base =
                pythoneda-base.packages.${system}.pythoneda-base-latest-python310;
              python = pkgs.python310;
              inherit pkgs nixpkgsRelease;
            };
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python38 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python38;
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python39 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python39;
          pythoneda-artifact-event-infrastructure-git-tagging-latest-python310 =
            pythoneda-artifact-event-infrastructure-git-tagging-0_0_1a1-python310;
          pythoneda-artifact-event-infrastructure-git-tagging-latest =
            pythoneda-artifact-event-infrastructure-git-tagging-latest-python310;
          default = pythoneda-artifact-event-infrastructure-git-tagging-latest;

        };
      });
}
