{
  specialisation = {
    gaming.configuration = {
      imports = [ ../../modules/gaming.nix ];
    };
    productivity.configuration = {
      imports = [ ../../modules/productivity.nix ];
    };
    music.configuration = {
      imports = [ ../../modules/music.nix ];
    };
    development.configuration = {
      imports = [ ../../modules/development.nix ];
    };
    engineering.configuration = {
      imports = [ ../../modules/engineering.nix ];
    };
    security.configuration = {
      imports = [ ../../modules/security.nix ];
    };
  };
}
