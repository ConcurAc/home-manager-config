{ modules, ... }:
{
  imports = with modules.features; [
    gaming
  ];
}
