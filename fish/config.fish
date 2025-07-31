source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# pnpm
set -gx PNPM_HOME "/home/buymymojo/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -gx EDITOR msedit
set -gx VISUAL msedit

fish_add_path /home/buymymojo/bin
fish_add_path /home/buymymojo/.cargo/bin

fish_add_path $(go env GOBIN)
fish_add_path $(go env GOPATH)/bin

starship init fish | source
zoxide init fish | source
