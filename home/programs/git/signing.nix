{
  # Specify your SSH public key for signing
  home.file.".ssh/allowed_signers".text = 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHgPhV40o6NEJMfNdn6BZpRBlbVSrEqA2ak4C1SDI6N4 michal.gwozdz00@gmail.com";

  # Configure Git to use SSH signing
  programs.git = {
    enable = true;
    extraConfig = {
      # Enable commit signing
      commit.gpgsign = true;
      
      # Path to allowed_signers file
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      
      # Use SSH for signing (not GPG)
      gpg.format = "ssh";
      
      # Path to your SSH public signing key
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };
}
