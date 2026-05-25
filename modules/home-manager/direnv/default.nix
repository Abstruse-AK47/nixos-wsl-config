{ _ , ...}:

{

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;

  # This provides the 'use devenv' capability to direnv globally
  stdlib = ''
    use_devenv() {
      eval "$(devenv shell --print-bash-env)"
    }
  '';
};

}
