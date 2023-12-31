[
  { path = ".Xresources", type = 'make, body | not_exported = fun shortcuts => m%"
    ! Base16 One Light
    ! Scheme: Daniel Pfeifer (http://github.com/purpleKarrot)
    
    !#define base00 #fafafa
    !#define base01 #f0f0f1
    !#define base02 #e5e5e6
    !#define base03 #a0a1a7
    !#define base04 #696c77
    !#define base05 #383a42
    !#define base06 #202227
    !#define base07 #090a0b
    !#define base08 #ca1243
    !#define base09 #d75f00
    !#define base0A #c18401
    !#define base0B #50a14f
    !#define base0C #0184bc
    !#define base0D #4078f2
    !#define base0E #a626a4
    !#define base0F #986801
    
    !One Light bastardizatoin
    !#define base00 #bbbbbb
    !#define base03 #ffffff
    !#define base08 #de3e35
    !#define base09 #de3e35
    !#define base0B #3f953a
    !#define base01 #3f953a
    !#define base0A #d2b67c
    !#define base02 #d2b67c
    !#define base0D #2f5af3
    !#define base04 #2f5af3
    !#define base0E #950095
    !#define base06 #a00095
    !#define base0C #3f953a
    !#define base0F #3f953a
    !#define base05 #000000
    !#define base07 #000000
    
    ! --- set ~ automatically replaced by 'colours.sh' ---
    #define base00 #fcfcfc
    #define base01 #718c00
    #define base02 #eab700
    #define base03 #9e9e9e
    #define base04 #4271ae
    #define base05 #111111
    #define base06 #8959a8
    #define base07 #111111
    #define base08 #c82829
    #define base09 #e45649
    #define base0A #c18401
    #define base0B #50a14f
    #define base0C #3e999f
    #define base0D #4271ae
    #define base0E #8959a8
    #define base0F #3e999f
    ! --- end ~ automatically replaced by 'colours.sh' ---
    
    *foreground:   base05
    *background:   base00
    *cursorColor:  base05
    
    *color0:       base05
    *color1:       base08
    *color2:       base0B
    *color3:       base0A
    *color4:       base0D
    *color5:       base0E
    *color6:       base0C
    *color7:       base00
    
    *color8:       base07
    *color9:       base09
    *color10:      base01
    *color11:      base02
    *color12:      base04
    *color13:      base06
    *color14:      base0F
    *color15:      base03
    
    ! This sets $TERM with the Xresources patch
    ! If you run into deletion errors, not having this is probably the problem
    st.termname:   st-256color
    
    
    ! Can look through history for more exhausitive list of possible options
    !st.alpha:      230
    st.font:       mono:size=9:antialias=true:autohint=true;
    !TODO figure out how to implement st.font2
    st.borderpx:   4
    
    
  "%, },
]
