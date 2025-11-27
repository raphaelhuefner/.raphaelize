#!/usr/bin/env bash

RUN_SCRIPT="$HOME/projects/qr/run.sh"

if [[ ! -x "$RUN_SCRIPT" ]]; then
    echo "Error: $RUN_SCRIPT is not executable"
    echo "Please install it by running: mkdir -p ~/projects; git clone https://github.com/raphaelhuefner/qr ~/projects/qr"
    exit 1
fi

"$RUN_SCRIPT"
