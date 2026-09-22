{
  security.tpm2.enable = true;
  security.polkit.enable = true;

  security.sudo-rs = {
    enable = true;
    execWheelOnly = false;
  };
}
