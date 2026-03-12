{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    terraform
    ansible
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
