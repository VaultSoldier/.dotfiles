{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dart
    clang
    gcc
    go
    nodejs
    python314Full
    uv
    sqlite
  ];
}
