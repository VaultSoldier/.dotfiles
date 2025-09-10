{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    wireplumber.extraConfig = {
      "override.monitor.bluez.properties" = {
        "bluez5.codecs" = "[ldac sbc sbc_xq aac aptx aptx_hd]";
      };
    };
  };
}
