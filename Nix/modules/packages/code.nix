{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dart
    clang
    gcc
    go
    nodejs
    python313
    uv
    sqlite
  ];
}
