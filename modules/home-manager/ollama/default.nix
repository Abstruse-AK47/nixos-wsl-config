{ _ , ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };
}
