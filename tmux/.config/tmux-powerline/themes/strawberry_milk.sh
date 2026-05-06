# ==============================================================================
# SAKURA MIKU (Strawberry Milk) Theme - Enhanced Styling
# ==============================================================================

# -- Core Palette --
BG_BASE="#1A161E" # (Updated to your deep plum shadow)
FG_MAIN="#F4EDEA"
FG_DIM="#7A738C"       # (Updated to your muted gray)
PINK_PRIMARY="#FFB7B2" # (Updated to your pastel pink)
PINK_MUTED="#FF8FA3"   # (Updated to your vibrant pink)
MIKU_TEAL="#89DCEB"    # (Replaced HOT_PINK with Miku Teal)

# -- Separators & Styling --
# Uses rounded powerline glyphs for a softer, pill-like aesthetic
TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$BG_BASE}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$FG_MAIN}
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}
TMUX_POWERLINE_SEG_SPACE_DISABLE="true" # Removes standard spaces to let custom separators shine

# -- Left Status Bar --
# Sessions use high-contrast Miku Teal, while path info remains clean and readable
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "tmux_session_info $MIKU_TEAL $BG_BASE"
    "hostname $PINK_MUTED $BG_BASE"
    "pwd $BG_BASE $PINK_PRIMARY"
  )
fi

# -- Right Status Bar --
# Reorganized to flow from dark/muted tones down to bright accents near the edge
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "mac_ram $BG_BASE $FG_DIM"
    "battery $BG_BASE $PINK_PRIMARY"
    "mem_used $BG_BASE $PINK_PRIMARY"
    "date_day $PINK_MUTED $BG_BASE"
    "date $PINK_PRIMARY $BG_BASE"
    "time $MIKU_TEAL $BG_BASE"
  )
fi

# -- Window Tabs --
# This prevents tmux-powerline from overwriting your tabs with defaults
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
    "#[fg=$PINK_PRIMARY,bg=default]"
    "#[fg=$BG_BASE,bg=$PINK_PRIMARY,bold] 󰓩 #I $TMUX_POWERLINE_SEPARATOR_RIGHT_THIN #W "
    "#[fg=$PINK_PRIMARY,bg=default]"
  )
fi

if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
    "#[fg=$FG_DIM,bg=default] $TMUX_POWERLINE_SEPARATOR_LEFT_THIN #[fg=$FG_DIM,bg=default] #I #W $TMUX_POWERLINE_SEPARATOR_RIGHT_THIN "
  )
fi

# -- Layout --
# Force tmux-powerline to center the window list
export TMUX_POWERLINE_STATUS_JUSTIFICATION="centre"
