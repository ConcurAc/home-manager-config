{
  defaults = ./defaults;
  features = {
    ai = ./features/ai.nix;
    development = ./features/development.nix;
    engineering = ./features/engineering.nix;
    gaming = ./features/gaming;
    music = ./features/music.nix;
    productivity = ./features/productivity.nix;
    security = ./features/security.nix;
  };

  mounts = ./mounts.nix;
}
