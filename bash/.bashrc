# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
alias n='nvim .'

. "$HOME/.local/share/../bin/env"
. "$HOME/.cargo/env"

set completion-ignore-case on
set show-all-if-ambiguous on
set mark-symlinked-directories on
set match-hidden-files off
set completion-prefix-display-length 1
set skip-completed-text on
set completion-suppress-space off
