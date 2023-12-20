let lib = import "../meta/lib.ncl" in

fun external => {
  packages = {
    "pkgs.parallel" = null,
    "pkgs.gitui"    = null,

    "pkgs.sxiv" = null,
    "pkgs.zathura" = null,

    "pkgs.gh"              = null,
    #"pkgs.git-filter-repo" = null,
    "pkgs.podman"          = null,
    "pkgs.buildah"         = null,

    "pkgs.azure-cli"  = null,
    #"unstable.awscli2" = null,
    "pkgs.mysql"      = null,
    "pkgs.sqlcmd"     = null,
    "pkgs.sqlint"     = null, "pkgs.sqlcheck" = null,

    "pkgs.powershell" = null,
    "pkgs.terraform"  = null, "pkgs.terraform-ls" = null,
    #"pkgs.ansible"    = null,
    "pkgs.deno"       = null,
    "pkgs.python3"    = null,
    "pkgs.graphviz"   = null, "pkgs.d2"  = null,
    "pkgs.nls"        = null, "pkgs.jsonnet-language-server" = null,

    #"pkgs.zbar-tools"
  }
} & lib.named_paths {
  base = {
    d  = "dotfiles",
    dl = external ++ "/Downloads",
    e  = ".environment",
    f  = external ++ "/Documents",
    m  = external ++ "/Music",
    p  = external ++ "/Pictures",
    t  = "/tmp",
    x  = external
  },
}
