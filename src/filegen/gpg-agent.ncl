[
  { path = ".local/gnupg/gpg-agent.conf", type = 'make, body | not_exported = fun shortcuts => m%"
      default-cache-ttl 500
      pinentry-program /home/rai/.nix-profile/bin/pinentry-curses
    "%
  }
]
