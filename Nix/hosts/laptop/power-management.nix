{ config, lib, ... }:

{
  services.upower.enable = true;

  powerManagement.powertop.enable =
    true; # enable powertop auto tuning on startup.

  services.system76-scheduler.settings.cfsProfiles.enable =
    true; # Better scheduling for CPU cycles - thanks System76!!!
  services.power-profiles-daemon.enable = true;
}
