#!/usr/bin/env bash

set -eu

is_app_installed() {
  type "$1" &>/dev/null
}

# get data either form stdin or from file
buf=$(cat "$@")

copy_backend_remote_tunnel_port=$(tmux show-option -gvq "@copy_backend_remote_tunnel_port")
copy_use_osc52_fallback=$(tmux show-option -gvq "@copy_use_osc52_fallback")

# Resolve copy backend: pbcopy (OSX), reattach-to-user-namespace (OSX), xclip/xsel (Linux)
if [ -n "$copy_backend" ]; then
  printf "%s" "$buf" | eval "$copy_backend"
  exit;
fi

