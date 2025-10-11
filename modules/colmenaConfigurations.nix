{
  lib,
  flake-parts-lib,
  moduleLocation,
  ...
}:
let
  inherit (lib)
    mapAttrs
    mkOption
    types
    ;
  inherit (flake-parts-lib)
    mkSubmoduleOptions
    ;
in
{
  options = {
    flake = mkSubmoduleOptions {
      colmenaConfigurations = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = { };
        apply = mapAttrs (
          k: v: {
            _file = "${toString moduleLocation}#colmenaConfigurations.${k}";
            imports = [ v ];
          }
        );
        description = ''
          Colmena system configurations.

          Used for devices managed by colmena.
        '';
      };
    };
  };
}
