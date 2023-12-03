# Introduction

The configuration for various computers.
This use to deployed via a perl script `linker.pl`, but now it is deployed via Nix (home-manager and maybe deploy-rs).

# Philosophy and workflow

The target workflow is primarily terminal-based one.
I use a tiling window manager, and I open terminals into tmux by default.
I primarily use tmux for searching through command history and copying; I generally do not use panes and windows except for programming/writing to run build scripts.

My primary tech stack is: bash, tmux, i3/sway, lf, helix/vim, neomutt, pass, syncthing, firefox/chromium, [ventoy](https://github.com/ventoy/Ventoy). The features are:

* I use [nickel](github.com/tweag/nickel) to manage almost all configuration
* type `c` in `bash` or `lf` to go a set of favourite locations. Bash and ZSH have `CDPATH` that this replaces
* In normal mode in helix or vim, `\q` `\w` `\e` `\r` `\t\` will open a new pane that will run `build.sh` in my SCRIPTS directory
* Use `email.sh` to access email
* Inspired by `sxhkd`, [my shortcuts](./.config/wm-shortcuts) are specified [chordscript](https://github.com/Aryailia/chordscript). I am replacing this with nickel.
* I use specific keybinds for switching into a language. The activate/deactivate paradigm of all IMEs (fcitx, ibus, rime, etc.) only makes sense for two languages and I use more than that.
* Bookmarks are stored in `.environment` and access via a shellscript

# Wishlist

* [Penzai](https://github.com/shimmeril/penzai) - to replace many of my `s` shellscripts because it will give them auto-completion
* [Tetra](https://github.com/shimmeril/tetra) - to facilitate a obsidian/zettelkasten-like note-taking experience. Also to replace my statically generated website/portfolio.
* A shellscript runner for the browser to integrate `pass` and bookmarks shellscript
* Modern Terminal Web Browser - That can read blogs/terminal
* RSS feed generator that expands [RSS-bridge](https://github.com/RSS-Bridge/rss-bridge) so that it can interact with ActivityPub read-only with no-login. This can replace [Squawker](https://github.com/j-fbriere/squawker), [NewPipe](https://github.com/TeamNewPipe/NewPipe), etc.
* A terminal file browser like `lf` that can handle ssh and ftp.

# Install/Deployment

Clone this repo to `$HOME/dotfiles`, if you need to change the directory name, you will have to edit flake.nix accordingly.
(There are hacks around specifying arugments to flakes, but I have not decided on what I want to do).
Files not tracked by git are expected to go into the `e` directory (shortcut), which is `$HOME/.environment`.


If you have home-manager installed, just run `./make.sh`.
Eventually, this script will handle fetching nix/home-manager.

Deploy-rs for servers is planned (can deploy to non-NixOS, i.e. it can deploy home-manager configurations).

## Deploying Secrets

How I deploy secrets is still a work in progress.
I use pass for my secrets and `rsync` to replicate across computers.

## Setting up emails

TODO


# Text Editor Philosophy

It is probably not an exaggeration to say that all terminal-based setups are entirely around the fact that we want to use Vim/Emacs/etc. as our text editor.
When confessing their love for vim, people often emphasize not needing to move your hand off to the mouse, which I seems irrelevant to most.
Its salience is that, when you achieve certain thresholds of speed, your workflow becomes qualitatively different; things that would not be possible before become possible.
You spend time immersed in your work and not in the actions you need to do to get the work done.
And terminal text editors reach that highest threshold of speed, perhaps only rivaled by Speech-editing HCI like [Cursorless](https://www.cursorless.org/), wrappers around [Vosk](https://alphacephei.com/vosk/install), etc.

I use vim with default keybinds where possible and achieve extensibility with shellscripts.
This is because VimL is a terrible language (shellscript and/or real programming languages are not), it keeps your vim install lean, and we get to leverage the existing UNIX tools (+ bonus points for UNIX philosophy).
Staying close to default vim is desirable because when you SSH into a server, you won't have plugins.

Some notes:

* many utility plugins can be achieved with vim filters (lookup `:h filter`)`:<range>!<shell-command>`, e.g. format a selection into a table `'<,'>!column -t -s \| -o \|`.
* The only LSP features I really use are variable rename and autocomplete for files (which vim handles with `C-x C-f`).
* I do not use a fuzzy file finder in vim nor do I open multiple buffers, I have found exiting to use `lf` (and maybe fuzzy find from there) is sufficient for me.

For coding I have switched to using helix, because the workflow is 95% the same (with hacks) and the configuration is a 10th of what you need for Vim.
For writing/notetaking purposes, vim is still superior because of spellcheck, jump to file `gf`, and follow link (plugins).

# Nightly Features we Want

* [importstr for Nickel](https://github.com/tweag/nickel/pull/1734) to get rid of nickel thin wrappers around shellscripts
* [Non-hacky ways to specify arguments to flakes](https://github.com/NixOS/nix/issues/3843) or [nix expressions in flake inputs](https://github.com/NixOS/nix/issues/5663) to better work with deploy-rs and local deployment
* [Helix plugin system](https://github.com/helix-editor/helix/discussions/3806) so that we can implement Vim's `gf` and opening links in external program.
This helps alot for ergonomics making use of the primary selling-point of zettelkasten (forward and back links).

