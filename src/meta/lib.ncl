# Until nickel has types as values
let Fields = { } in
{
  RelativePath | not_exported = std.contract.from_predicate (fun x =>
    let first_char = std.string.substring 0 1 x in
    (std.is_string x) && first_char != "/"
  ),

  named_paths | not_exported = fun loc =>
  {
    shortcuts = (loc.base | {
      d  | String, # dotfiles
      dl | String, # Downloads
      e  | String, # .env: local only files, not for git
      f  | String, # Documents (files)
      m  | String, # Music
      p  | String, # Pictures
      t  | String, # temp dir
      x  | String, # External, e.g. Windows home user, android Storage
    })  & {
      a   = dc ++ "/vim/after",
      c   = ".config",
      cl  = ".local",
      cr  = c ++ "/remind",
      dc  = loc.base.d ++ "/.config",
      df  = loc.base.d ++ "/src/filegen",
      dm  = loc.base.d ++ "/src/meta",
      ec  = loc.base.e ++ "/.config",
      h   = "",
      i   = "interim",
      l   = loc.base.e ++ "/Library",
      me  = "/media",
      mn  = "/mnt",
      n   = loc.base.e ++ "/notes",
      o   = loc.base.d ++ "/containers", # 'o' for OCI (Open Container Intiative)
      q   = loc.base.dl ++ "/queue",
      s   = dc ++ "/scripts",
      sn  = dc ++ "/snippets",
      w   = "projects",
      z   = loc.base.e ++ "/zettelkasten",
    },
  },

  
  #node = {
  #  type | [| 'File, 'Exec, 'Dir, 'Skip |],
  #  dependencies | Array String,
  #  body | String,
  #},
}
