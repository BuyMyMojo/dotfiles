{
  config,
  pkgs,
  unstable,
  inputs,
  lib,
  ...
}:

let
  withExtraPackages =
    pkg: extraPackages:
    pkgs.runCommand "${pkg.name}-wrapped" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
      for exe in ${lib.getBin pkg}/bin/*; do
        makeWrapper $exe $out/bin/$(basename $exe) --prefix PATH : ${lib.makeBinPath extraPackages}
      done
    '';
in
{

  imports = [
    inputs.bellado.homeManagerModules.default
  ];

  home.packages =
    with unstable;
    with inputs;
    [

    ];

  programs.neovim = {
    # package = unstable.neovim;
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

  };

  programs.git = {
    enable = true;
    userName = "BuyMyMojo";
    userEmail = "hello+git@buymymojo.net";
    lfs.enable = true;
    signing.key = "E7B7B8D20C8753C077F9B17119AB7AA462B8AB3B";
    signing.signByDefault = true;
    extraConfig = {
      init = {

        defaultBranch = "main";
      };
    };
  };

  programs.bellado = {
    enable = true;
    enableAliases = true;
  };

  programs.ssh.enable = true;
  programs.ssh.addKeysToAgent = "yes";

  # === shells ===
  programs.bash.enable = true;
  programs.fish.enable = true;

}
