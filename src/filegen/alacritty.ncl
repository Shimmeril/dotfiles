[
  { path = ".config/alacritty/alacritty.yml", type = 'make, body | not_exported = fun shortcuts => m%"
    colors:
    # --- set ~ automatically replaced by 'colours.sh' ---
      primary:
        background: '0xfcfcfc'
        foreground: '0x111111'

      cursor:
        text:       '0xfcfcfc'
        cursor:     '0x111111'

      normal:
        black:   '0x111111'
        red:     '0xc82829'
        green:   '0x50a14f'
        yellow:  '0xc18401'
        blue:    '0x4271ae'
        magenta: '0x8959a8'
        cyan:    '0x3e999f'
        white:   '0xfcfcfc'

      bright:
        black:   '0x111111'
        red:     '0xe45649'
        green:   '0x718c00'
        yellow:  '0xeab700'
        blue:    '0x4271ae'
        magenta: '0x8959a8'
        cyan:    '0x3e999f'
        white:   '0x9e9e9e'
    # --- end ~ automatically replaced by 'colours.sh' ---

    font:
      # Point size
      size: 7.0
  "%, },
]
