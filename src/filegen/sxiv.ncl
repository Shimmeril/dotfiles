[
  { path = ".config/sxiv/exec/key-handler", type = 'make, body | not_exported = fun shortcuts => m%"
    #!/usr/bin/env sh
    prompt() {
      if   [ -n "${DISPLAY}" ]; then         <&0 dmenu "$@"
      elif [ -n "${WAYLAND_DISPALY}" ]; then <&0 dmenu-wl "$@"
      fi
    }
    
    
    while read -r path; do case "${1}" in
      d) [ "$( printf "No\\nYes" | prompt -i -p "Confirm delete?" )" = "Yes" ] \
        && rm "${path}" ;;
      p) notify-send -t 2000 "${path}" ;;
      "r") echo yo | dmenu-wl ;;
    esac done
  "%, },
]
