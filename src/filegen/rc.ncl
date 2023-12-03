[
  { path = ".config/rc/aliasrc", type = 'make, body | not_exported = fun shortcuts => import "aliasrc.ncl" },
  { path = ".config/rc/inputrc", type = 'make, body | not_exported = fun shortcuts => m%"
    # Think about how this affects termux
    #$include /etc/inputrc

    # Set colours for tab completion
    set colored-stats on

    # Do not bell on tab-completion
    set bell-style none

    # The common prefix of all completion suggestions is shown in a different color
    set colored-completion-prefix on

    # Partially complete word and show all combinations
    #set show-all-if-ambiguous on
    set show-all-if-unmodified on

    # Cycle backward: Shift-Tab
    "\e[Z": menu-complete-backward
  "%, },

  { path = ".config/rc/npmrc", type = 'make, body | not_exported = fun shortcuts => m%"
    ; npm ini config file, see `npm help config`
    ;;;;
    ; cache=/home/rai/.npm
    ; cache-lock-stale=60000
    ; cache-lock-retries=10
    ; cache-lock-wait=10000
    ; cache-max=null
    ; cache-min=10
    ; globalconfig=/usr/etc/npmrc
    ; init-module=/home/rai/.npm-init.js
    ; init-author-name=
    ; init-author-email=
    ; init-author-url=
    ; init-version=1.0.0
    ; init-license=ISC
    ; prefix=/usr
    ; user-agent=npm/{npm-version} node/{node-version} {platform} {arch}
    ; registry=https://registry.npmjs.org/
    ; script-shell=null
    ; shell=/bin/bash
    ; tmp=/tmp
    ; userconfig=/home/rai/.npmrc
    ; globalignorefile=/usr/etc/npmignore
  "%, },

  { path = ".config/rc/pythonrc", type = 'make, body | not_exported = fun shortcuts => m%"
    # Lekensteyn
    # https://unix.stackexchange.com/questions/121377/
    # Replaces generating and auto-completing ~/.python_history hook with custom
    import sys
    def register_readline_completion():
        # rlcompleter must be loaded for Python-specific completion
        try: import readline, rlcompleter
        except ImportError: return
        # Enable tab-completion
        readline_doc = getattr(readline, '__doc__', '')
        if readline_doc is not None and 'libedit' in readline_doc:
            readline.parse_and_bind('bind ^I rl_complete')
        else:
            readline.parse_and_bind('tab: complete')
    sys.__interactivehook__ = register_readline_completion
  "%, },

  ## I do this on the keyboard firmware layer
  ## This only works when X server is up so does not work for linux TTY (alt+ctrl+1)
  ## Also do not have to learn a different keyboard layout, when this is unsupported
  #{ path = ".config/rc/remap-caps-rctrl.map", type = 'make, body | not_exported = fun shortcuts => m%"
  #  keycode 58 = Control
  #  keycode 97 = Caps_Lock
  #"%, },

  { path = ".config/rc/wgetrc", type = 'make, body | not_exported = fun shortcuts => m%"
    hsts = 0
  "%, },
  #{ path = ".config/rc/", type = 'make, body | not_exported = fun shortcuts => m%"
  #"%, },
]
