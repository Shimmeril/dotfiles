[
  { path = ".config/scripts",    type = 'dirl },
  { path = ".config/snippets",   type = 'dirl },
  #{ path = ".config/vim/unused", type = 'skip },
  { path = ".config/vim/after",  type = 'dirl },
]
@ (import "filegen/alacritty.ncl")
@ (import "filegen/mpv.ncl")
@ (import "filegen/ion.ncl")
@ (import "filegen/rc.ncl")
@ (import "filegen/dunst.ncl")
@ (import "filegen/i3.ncl")
@ (import "filegen/newsboat.ncl")
@ (import "filegen/tmux.ncl")
@ (import "filegen/zathura.ncl")
@ (import "filegen/sxiv.ncl")
@ (import "filegen/streamlink.ncl")
@ (import "filegen/neomutt/colours.ncl")
@ (import "filegen/neomutt/keybinds.ncl")
@ (import "filegen/neomutt/mailcap.ncl")
@ (import "filegen/neomutt/neomuttrc.ncl")
@ (import "filegen/lf.ncl")
@ (import "filegen/vim.ncl")
@ (import "filegen/helix/languages.ncl")
@ (import "filegen/helix/config.ncl")
@ (import "filegen/helix/catppuccin_latte.ncl")

# In Home folder
@ (import "filegen/bashrc.ncl")
@ (import "filegen/profile.ncl")
@ (import "filegen/x.ncl")
@ (import "filegen/Xresources.ncl")
