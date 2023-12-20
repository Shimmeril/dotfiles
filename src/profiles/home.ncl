let lib    = import "../meta/lib.ncl" in

fun external => {
  packages = {
    "pkgs.git"     = null,
    "pkgs.neomutt" = null,
    #"pkgs.mpv"     = null,
  }
} & lib.named_paths {
  base = {
    d  = "dotfiles",
    dl = "Downloads",
    e  = ".environment",
    f  = "Documents",
    m  = "Music",
    p  = "Pictures",
    t  = "/tmp",
    x  = "/mnt/a"
  },

}
