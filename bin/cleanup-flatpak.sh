#!/usr/bin/env bash

# Make Bash's error handling strict(er).
set -o nounset -o pipefail -o errexit

# Source https://www.debugpoint.com/clean-up-flatpak/

flatpak uninstall --unused
