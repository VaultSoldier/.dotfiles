{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    terraform
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
