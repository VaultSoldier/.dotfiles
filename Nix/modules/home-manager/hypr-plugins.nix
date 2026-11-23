{ inputs, ... }:
{
  xdg.configFile."hypr/plugins/split-monitor-workspaces".source = inputs.split-monitor-workspaces;
}
