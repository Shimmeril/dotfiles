let lib = import "../meta/lib.ncl" in

fun external => {
  packages = {}
} & lib.named_paths {
    base = {
      d  = "dotfiles",
      dl = "Downloads",
      e  = ".environment",
      f  = external ++ "/Documents",
      m  = external ++ "/Music",
      p  = external ++ "/Pictures",
      t  = "/tmp",
      x  = external
    },
  }
