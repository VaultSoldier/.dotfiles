{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    terraform
    dart
    clang
    gcc
    go
    nodejs
    python314
    uv
    sqlite
  ];
}
