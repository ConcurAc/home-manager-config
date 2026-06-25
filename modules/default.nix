{
  defaults = ./defaults;
  features = {
    development = ./features/development.nix;
    engineering = ./features/engineering.nix;
    gaming = ./features/gaming.nix;
    music = ./features/music.nix;
    productivity = ./features/productivity.nix;
    security = ./features/security.nix;
  };

  mounts = ./mounts.nix;
}
