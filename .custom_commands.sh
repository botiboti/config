#!/bin/bash

# saves image from clipboard with the path and name given
function pasteimg() {
	xclip -selection clipboard -target image/png -o > $1
}

