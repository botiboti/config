#!/bin/bash

export PATH="$HOME/.npm-global/bin:$PATH"

# saves image from clipboard with the path and name given
function pasteimg() {
	xclip -selection clipboard -target image/png -o > $1
}

if command -v fzf-share >/dev/null; then
  source "$(fzf-share)/key-bindings.bash"
  source "$(fzf-share)/completion.bash"
fi

function edit() {
  nvim $(fzf)
}
