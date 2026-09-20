# ==============================================================================
# Noctalia Theme - Dynamic
# Pulls colors live from the @noctalia_* tmux options on every status refresh,
# so the status bar always matches the current Noctalia palette.
# ==============================================================================

# -- Dynamic Palette Lookup --
# Load all Noctalia palette options from tmux in one call and turn them into
# shell variables (noctalia_surface, noctalia_primary, ...).
# Fallbacks below keep the theme working even if an option is unset.
eval "$(tmux show-option -g 2>/dev/null | sed -n 's/^@\(noctalia_[A-Za-z_0-9]*\) "\([^"]*\)"$/\1=\x27\2\x27/p')"

BG_BASE="${noctalia_surface_container_low:-#181d18}"
FG_MAIN="${noctalia_on_surface:-#dfe4dc}"
FG_DIM="${noctalia_on_surface_variant:-#c1c9bf}"
ACCENT="${noctalia_primary:-#97d5a5}"
ON_ACCENT="${noctalia_on_primary:-#00391b}"
SURFACE_CONTAINER="${noctalia_surface_container:-#1c211c}"
SECONDARY_BG="${noctalia_secondary_container:-#384b3c}"
PRIMARY_CT_BG="${noctalia_primary_container:-#14512d}"
TERTIARY_BG="${noctalia_tertiary_container:-#204d56}"
ON_SECONDARY_FG="${noctalia_on_secondary_container:-#d2e8d3}"
ON_PRIMARY_CT_FG="${noctalia_on_primary_container:-#b2f1c0}"
ON_TERTIARY_FG="${noctalia_on_tertiary_container:-#beeaf6}"

# -- Separators & Styling --
# Rounded powerline glyphs for a softer, pill-like aesthetic
TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-$BG_BASE}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-$FG_MAIN}
TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}
TMUX_POWERLINE_SEG_SPACE_DISABLE="true"

# -- Left Status Bar --
if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "hostname $ACCENT $ON_ACCENT"
    "pwd $BG_BASE $ACCENT"
  )
fi

# -- Right Status Bar --
if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
  TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "date_day $SECONDARY_BG $ON_SECONDARY_FG"
    "date $PRIMARY_CT_BG $ON_PRIMARY_CT_FG"
    "time $TERTIARY_BG $ON_TERTIARY_FG"
  )
fi

# -- Window Tabs --
# bg=default lets the Noctalia status-style bg show through behind the pills
if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_CURRENT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
    "#[fg=$ACCENT,bg=default]$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD"
    "#[fg=$BG_BASE,bg=$ACCENT,bold] 󰓩 #I $TMUX_POWERLINE_SEPARATOR_RIGHT_THIN #W "
    "#[fg=$ACCENT,bg=default]$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD"
  )
fi

if [ -z "$TMUX_POWERLINE_WINDOW_STATUS_FORMAT" ]; then
  TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
    "#[fg=$FG_DIM,bg=default] $TMUX_POWERLINE_SEPARATOR_LEFT_THIN #[fg=$FG_DIM,bg=default] #I #W $TMUX_POWERLINE_SEPARATOR_RIGHT_THIN "
  )
fi

# -- Layout --
export TMUX_POWERLINE_STATUS_JUSTIFICATION="centre"