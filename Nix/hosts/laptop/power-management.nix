{ config, lib, ... }:

{
  services.upower.enable = true;
  services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
  services.power-profiles-daemon.enable = true;
}
