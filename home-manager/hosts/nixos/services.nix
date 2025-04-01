{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:

{

  services.ssh-agent.enable = true;
  services.syncthing.enable = true;

}
