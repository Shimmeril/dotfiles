#!/bin/sh


NAME="$( basename "${0}"; printf a )"; NAME="${NAME%?a}"
WD="$( dirname "$0"; printf a )"; WD="${WD%?a}"
cd "${WD}" || { printf "Could not cd to directory of '%s'" "$0" >&2; exit 1; }

#run: % port
main() {
  hosts="$( nix-instantiate --log-format raw --eval \
    --expr 'toString (builtins.attrNames (import ./hosts.nix))'
  )" # returns '"host1 host2"'
  hosts="${hosts#\"}"
  hosts="${hosts%\"}"
  host="${1:-"$( 
    prompt "${hosts}" "$(
      for h in ${hosts}; do printf %s\\n "- ${h}"; done
      printf %s "Choose a host: "
    )" "Invalid host."
  )"}" || exit "$?"


  home-manager switch --flake ".#${host}"
}

prompt() {
  printf %s "${2}" >&2; read -r value || return "$?"; printf %s\\n "" >&2
  while :; do
    for opt in ${1}; do [ "${opt}" = "${value}" ] && break 2; done # break while loop
    printf %s\\n%s "${3}" "${2}" >&2; read -r value || return "$?"; printf %s\\n "" >&2
  done
  printf %s "${value}"
}


<&0 main "$@"
